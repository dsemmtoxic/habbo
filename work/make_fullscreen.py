import base64
import copy
import datetime
import hashlib
import io
import os
from pathlib import Path
import struct
import zipfile

from cryptography import x509
from cryptography.hazmat.primitives import hashes, serialization
from cryptography.hazmat.primitives.asymmetric import padding, rsa
from cryptography.hazmat.primitives.serialization import pkcs7
from cryptography.x509.oid import NameOID

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / 'upload/HabboAirPlus_Android_ARMV8_20_9.apk'
OUTPUT = ROOT / 'output/HabboAirPlus_20_9_TelaCheia.apk'


def uint32(value):
    return struct.pack('<I', value)


def lp(value):
    return uint32(len(value)) + value


def chunks(data, start=8, end=None):
    end = len(data) if end is None else end
    while start < end:
        kind, header, length = struct.unpack_from('<HHI', data, start)
        assert header >= 8 and length >= header and start + length <= end
        yield start, kind, header, length
        start += length
    assert start == end


def string_pool(data, offset):
    _, header, _ = struct.unpack_from('<HHI', data, offset)
    count, _, flags, start = struct.unpack_from('<IIII', data, offset + 8)
    utf8 = bool(flags & 256)

    def length_at(pos):
        value = data[pos] if utf8 else struct.unpack_from('<H', data, pos)[0]
        pos += 1 if utf8 else 2
        mask = 128 if utf8 else 32768
        if value & mask:
            low = data[pos] if utf8 else struct.unpack_from('<H', data, pos)[0]
            value = ((value & (mask - 1)) << (8 if utf8 else 16)) | low
            pos += 1 if utf8 else 2
        return value, pos

    result = []
    for index in range(count):
        pos = offset + start + struct.unpack_from('<I', data, offset + header + 4 * index)[0]
        length, pos = length_at(pos)
        if utf8:
            length, pos = length_at(pos)
            result.append(data[pos:pos + length].decode('utf8'))
        else:
            result.append(data[pos:pos + length * 2].decode('utf-16le'))
    return result


def patch_manifest(data):
    result = bytearray(data)
    strings = None
    changes = 0
    for pos, kind, header, length in chunks(data):
        if kind == 1:
            strings = string_pool(data, pos)
        elif kind == 0x102:
            tag = strings[struct.unpack_from('<I', data, pos + 20)[0]]
            if tag != 'meta-data':
                continue
            start, stride, count = struct.unpack_from('<HHH', data, pos + 24)
            attributes = {}
            for index in range(count):
                at = pos + 16 + start + index * stride
                name = strings[struct.unpack_from('<I', data, at + 4)[0]]
                attributes[name] = at
            name_at = attributes['name']
            value = struct.unpack_from('<I', data, name_at + 16)[0]
            if strings[value] == 'fullScreen':
                at = attributes['value']
                assert data[at + 15] == 0x12
                assert struct.unpack_from('<I', data, at + 16)[0] == 0
                assert struct.unpack_from('<I', data, at + 8)[0] == 0xffffffff
                struct.pack_into('<I', result, at + 16, 0xffffffff)
                changes += 1
    assert changes == 1
    return bytes(result)


def patch_theme(data):
    result = bytearray(data)
    changes = 0
    for pos, kind, header, length in chunks(data, 12):
        if kind != 0x200:
            continue
        for tp, tk, th, tl in chunks(data, pos + header, pos + length):
            if tk != 0x201 or data[tp + 8] != 9:
                continue
            count, start = struct.unpack_from('<II', data, tp + 12)
            for index in range(count):
                off = struct.unpack_from('<I', data, tp + th + 4 * index)[0]
                if off == 0xffffffff:
                    continue
                entry = tp + start + off
                _, flags, _ = struct.unpack_from('<HHI', data, entry)
                assert flags & 1
                assert struct.unpack_from('<I', data, entry + 8)[0] == 0x01030006
                # Keep the existing Theme.NoShadow attributes and inherit
                # Theme.NoTitleBar.Fullscreen to hide status UI at launch.
                struct.pack_into('<I', result, entry + 8, 0x01030007)
                changes += 1
    assert changes == 1
    return bytes(result)


def digest(data):
    return base64.b64encode(hashlib.sha256(data).digest()).decode('ascii')


def record(attributes):
    lines = []
    for name, value in attributes:
        line = (name + ': ' + value).encode('utf8')
        lines.append(line[:70])
        line = line[70:]
        while line:
            lines.append(b' ' + line[:69])
            line = line[69:]
    return b'\r\n'.join(lines) + b'\r\n\r\n'


def content_digest(parts):
    hashes_ = []
    for part in parts:
        for offset in range(0, len(part), 1048576):
            chunk = part[offset:offset + 1048576]
            hashes_.append(hashlib.sha256(b'\xa5' + uint32(len(chunk)) + chunk).digest())
    return hashlib.sha256(b'\x5a' + uint32(len(hashes_)) + b''.join(hashes_)).digest()


def main():
    with zipfile.ZipFile(SOURCE) as source:
        items = [(copy.copy(info), source.read(info.filename)) for info in source.infolist()
                 if not info.filename.startswith('META-INF/')]
    modified = []
    for index, (info, data) in enumerate(items):
        original = data
        if info.filename == 'AndroidManifest.xml':
            data = patch_manifest(data)
        elif info.filename == 'resources.arsc':
            data = patch_theme(data)
        elif info.filename == 'assets/META-INF/AIR/application.xml':
            assert data.count(b'<fullScreen>false</fullScreen>') == 1
            data = data.replace(b'<fullScreen>false</fullScreen>', b'<fullScreen>true</fullScreen>')
        if data != original:
            modified.append(info.filename)
        items[index] = (info, data)
    assert len(modified) == 3
    print('Modified:', modified)
    sign_items(items, OUTPUT)


def sign_items(items, output):
    key_file = ROOT / 'work/fullscreen-signing-key.pem'
    cert_file = ROOT / 'work/fullscreen-signing-cert.der'
    if key_file.exists():
        key = serialization.load_pem_private_key(key_file.read_bytes(), password=None)
        certificate = x509.load_der_x509_certificate(cert_file.read_bytes())
    else:
        key = rsa.generate_private_key(public_exponent=65537, key_size=2048)
        name = x509.Name([x509.NameAttribute(NameOID.COMMON_NAME, 'HabboAirPlus Fullscreen Test')])
        now = datetime.datetime.now(datetime.timezone.utc)
        certificate = (x509.CertificateBuilder().subject_name(name).issuer_name(name)
                       .public_key(key.public_key()).serial_number(x509.random_serial_number())
                       .not_valid_before(now - datetime.timedelta(days=1))
                       .not_valid_after(now + datetime.timedelta(days=7300))
                       .sign(key, hashes.SHA256()))
        key_file.write_bytes(key.private_bytes(serialization.Encoding.PEM,
                             serialization.PrivateFormat.PKCS8, serialization.NoEncryption()))
        os.chmod(key_file, 0o600)
        cert_file.write_bytes(certificate.public_bytes(serialization.Encoding.DER))

    main_attributes = record([('Manifest-Version', '1.0'), ('Created-By', 'Fullscreen APK build')])
    manifest_sections = [record([('Name', info.filename), ('SHA-256-Digest', digest(data))])
                         for info, data in items]
    manifest = main_attributes + b''.join(manifest_sections)
    sf = record([('Signature-Version', '1.0'), ('Created-By', 'Fullscreen APK build'),
                 ('SHA-256-Digest-Manifest', digest(manifest)),
                 ('SHA-256-Digest-Manifest-Main-Attributes', digest(main_attributes)),
                 ('X-Android-APK-Signed', '2')])
    sf += b''.join(record([('Name', info.filename), ('SHA-256-Digest', digest(section))])
                   for (info, _), section in zip(items, manifest_sections))
    rsa_block = (pkcs7.PKCS7SignatureBuilder().set_data(sf)
                 .add_signer(certificate, key, hashes.SHA256())
                 .sign(serialization.Encoding.DER, [pkcs7.PKCS7Options.DetachedSignature,
                       pkcs7.PKCS7Options.Binary, pkcs7.PKCS7Options.NoAttributes]))
    signature_items = []
    for name, data in [('META-INF/MANIFEST.MF', manifest),
                       ('META-INF/FULLSCR.SF', sf), ('META-INF/FULLSCR.RSA', rsa_block)]:
        info = zipfile.ZipInfo(name, (2026, 10, 24, 0, 0, 0))
        info.compress_type = zipfile.ZIP_DEFLATED
        signature_items.append((info, data))
    items = signature_items + items

    buffer = io.BytesIO()
    with zipfile.ZipFile(buffer, 'w') as archive:
        for info, data in items:
            if info.compress_type == zipfile.ZIP_STORED:
                at = archive.fp.tell() + 30 + len(info.filename.encode('utf8')) + len(info.extra)
                if at % 4:
                    pad = (-at - 4) % 4
                    info.extra += struct.pack('<HH', 0xd935, pad) + bytes(pad)
            archive.writestr(info, data)
    unsigned = buffer.getvalue()
    eocd_offset = unsigned.rfind(b'PK\x05\x06')
    assert eocd_offset == len(unsigned) - 22
    cd_offset = struct.unpack_from('<I', unsigned, eocd_offset + 16)[0]
    content_hash = content_digest([unsigned[:cd_offset], unsigned[cd_offset:eocd_offset],
                                   unsigned[eocd_offset:]])
    cert = certificate.public_bytes(serialization.Encoding.DER)
    signed_data = lp(lp(uint32(0x0103) + lp(content_hash))) + lp(lp(cert)) + lp(b'')
    signature = key.sign(signed_data, padding.PKCS1v15(), hashes.SHA256())
    pubkey = key.public_key().public_bytes(serialization.Encoding.DER,
                                          serialization.PublicFormat.SubjectPublicKeyInfo)
    signer = lp(signed_data) + lp(lp(uint32(0x0103) + lp(signature))) + lp(pubkey)
    v2 = lp(lp(signer))
    pair = struct.pack('<Q', len(v2) + 4) + uint32(0x7109871a) + v2
    signing_block = (struct.pack('<Q', len(pair) + 24) + pair +
                     struct.pack('<Q', len(pair) + 24) + b'APK Sig Block 42')
    eocd = bytearray(unsigned[eocd_offset:])
    struct.pack_into('<I', eocd, 16, cd_offset + len(signing_block))
    output.write_bytes(unsigned[:cd_offset] + signing_block + unsigned[cd_offset:eocd_offset] + eocd)
    print('Signed: APK v1 (SHA256/RSA) and v2 (SHA256/RSA)')
    print('Output:', output)
    print('Size:', output.stat().st_size)
    print('SHA256:', hashlib.sha256(output.read_bytes()).hexdigest())


if __name__ == '__main__':
    main()
