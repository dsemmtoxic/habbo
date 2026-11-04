"""Assemble or verify the complete Teste80 Android payload without signing."""

import argparse
import copy
import hashlib
import json
from pathlib import Path
import re
import struct
from zipfile import ZIP_DEFLATED, ZipFile, ZipInfo
import zlib

from android_binary import chunks, string_pool

ROOT = Path(__file__).resolve().parents[1]
CARRIER = ROOT / "inputs/Habbo_Android_BaseToken33.zip"
CARRIER_METADATA = CARRIER.with_name("base_token33.json")
SWF = ROOT / "work/HabboTablet_Token80_Base33.swf"
VALIDATION = ROOT / "work/feature80/validation80.json"
DEX = ROOT / "work/feature65/classes65.dex"
VERSION_NAME = "2.32.45-t80-b33"
VERSION_CODE = 2032179
AIR_VERSION = "2.32.179"

MANIFEST = "AndroidManifest.xml"
DESCRIPTOR = "assets/META-INF/AIR/application.xml"
GAME = "assets/HabboTablet.swf"


def sha256(data):
    return hashlib.sha256(data).hexdigest()


def is_signature(name):
    return re.fullmatch(r"META-INF/(?:MANIFEST\.MF|[^/]+\.(?:SF|RSA|DSA|EC)|SIG-[^/]+)", name, re.I) is not None


def patch_version(data):
    original = bytearray(data)
    entries = list(chunks(data))
    pool = next(x for x in entries if x[1] == 1)
    strings = string_pool(data, pool[0])
    new_index = len(strings)
    strings.append(VERSION_NAME)
    count = 0
    acceleration = 0
    for pos, kind, header, length in entries:
        if kind != 0x102:
            continue
        element = strings[struct.unpack_from('<I', data, pos + 20)[0]]
        if element not in {'manifest','application'}:
            continue
        start, stride, total = struct.unpack_from('<HHH', data, pos + 24)
        for i in range(total):
            at = pos + 16 + start + i * stride
            name = strings[struct.unpack_from('<I', data, at + 4)[0]]
            if element == 'application' and name == 'hardwareAccelerated':
                assert original[at + 15] == 0x12 and struct.unpack_from('<I', data, at + 16)[0] == 0
                struct.pack_into('<I', original, at + 16, 0xffffffff)
                acceleration += 1
            elif element == 'manifest' and name == 'versionCode':
                old = struct.unpack_from('<I', data, at + 16)[0]
                assert old < VERSION_CODE, 'Expected an older Android versionCode'
                struct.pack_into('<I', original, at + 16, VERSION_CODE)
                count += 1
            elif element == 'manifest' and name == 'versionName':
                struct.pack_into('<I', original, at + 8, new_index)
                original[at + 15] = 3
                struct.pack_into('<I', original, at + 16, new_index)
                count += 1
    assert count == 2 and acceleration == 1
    assert struct.unpack_from('<I', data, pool[0] + 12)[0] == 0
    flags = struct.unpack_from('<I', data, pool[0] + 16)[0] & ~1
    def len8(n):
        return bytes([n]) if n < 128 else bytes([(n >> 8) | 128, n & 255])
    def len16(n):
        return struct.pack('<H', n) if n < 32768 else struct.pack('<HH', (n >> 16) | 32768, n & 65535)
    blob = bytearray()
    offsets = []
    for value in strings:
        offsets.append(len(blob))
        encoded = value.encode('utf-8' if flags & 256 else 'utf-16le')
        units = len(value.encode('utf-16le')) // 2
        blob += (len8(units) + len8(len(encoded)) + encoded + b'\0') if flags & 256 else (len16(units) + encoded + b'\0\0')
    while len(blob) % 4:
        blob += b'\0'
    start = 28 + len(strings) * 4
    replacement = struct.pack('<HHIIIIII', 1, 28, start + len(blob), len(strings), 0, flags, start, 0) + b''.join(struct.pack('<I', n) for n in offsets) + blob
    result = original[:pool[0]] + replacement + original[pool[0] + pool[3]:]
    struct.pack_into('<I', result, 4, len(result))
    return bytes(result)

def patch_air_descriptor(original):
    data = original.replace(b'android:hardwareAccelerated="false"', b'android:hardwareAccelerated="true"')
    if data == original:
        raise ValueError("Expected the original Android acceleration setting in the AIR descriptor")
    for tag, value in (("versionNumber", AIR_VERSION), ("versionLabel", VERSION_NAME)):
        pattern = f"<{tag}>[^<]+</{tag}>".encode()
        data, count = re.subn(pattern, f"<{tag}>{value}</{tag}>".encode(), data)
        if count != 1:
            raise ValueError(f"Invalid AIR descriptor field {tag}")
    return data


def payload():
    carrier_data = CARRIER.read_bytes()
    metadata = json.loads(CARRIER_METADATA.read_text())
    if sha256(carrier_data) != metadata["sha256"]:
        raise ValueError("Android base differs from the expected Base33")
    swf = SWF.read_bytes()
    validation = json.loads(VALIDATION.read_text())
    if validation["swfSha256"] != sha256(swf):
        raise ValueError("Run the AVM2 regression suite for this SWF before packaging")
    if swf[:3] != b"FWS" or struct.unpack_from("<I", swf, 4)[0] != len(swf):
        raise ValueError("Unexpected SWF format or size")

    with ZipFile(CARRIER) as base:
        if sha256(base.read("classes.dex")) != metadata["dexSha256"]:
            raise ValueError("Original Android DEX differs from Base33")
        entries = {}
        for entry in base.infolist():
            if not is_signature(entry.filename):
                entries[entry.filename] = (copy.copy(entry), base.read(entry))
        if GAME in entries:
            raise ValueError("Expected Base33 carrier without a game SWF")

        for name, data in (
            (MANIFEST, patch_version(entries[MANIFEST][1])),
            (DESCRIPTOR, patch_air_descriptor(entries[DESCRIPTOR][1])),
            ("classes.dex", DEX.read_bytes()),
        ):
            entries[name] = (entries[name][0], data)

    game = ZipInfo(GAME, (2026, 11, 3, 0, 0, 0))
    game.compress_type = ZIP_DEFLATED
    entries[GAME] = (game, b"CWS" + swf[3:8] + zlib.compress(swf[8:], 9))
    return entries


def assemble(destination, entries):
    destination.parent.mkdir(parents=True, exist_ok=True)
    with ZipFile(destination, "w") as output:
        for info, data in entries.values():
            output.writestr(info, data)


def verify(apk, entries):
    with ZipFile(apk) as built:
        bad = built.testzip()
        if bad:
            raise ValueError(f"Corrupted APK entry: {bad}")
        names = [name for name in built.namelist() if not is_signature(name)]
        if len(set(names)) != len(names) or set(names) != entries.keys():
            raise ValueError("APK has unexpected, missing or duplicate entries")
        for name, (_, expected) in entries.items():
            if built.read(name) != expected:
                raise ValueError(f"APK content differs from the build: {name}")
    print(f"PASS: {apk.name} contains the validated SWF, DEX, manifest and AIR resources.")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument("--output", type=Path, metavar="APK", help="assemble the unsigned APK")
    mode.add_argument("--verify", type=Path, metavar="APK", help="verify the content of an APK")
    args = parser.parse_args()
    entries = payload()
    if args.output:
        assemble(args.output, entries)
        verify(args.output, entries)
    else:
        verify(args.verify, entries)


if __name__ == "__main__":
    main()
