from pathlib import Path
import copy,hashlib,json,re,struct,sys,zipfile,zlib
from make_fullscreen import ROOT,sign_items,chunks,string_pool
from cryptography import x509
from cryptography.hazmat.primitives import hashes

output=ROOT/'output/Habbo_2.32.31_Teste66_Base33.apk'
source=Path(sys.argv[1]).resolve() if len(sys.argv)>1 else ROOT/'inputs/Habbo_Android_BaseToken33.zip'
input_sha=hashlib.sha256(source.read_bytes()).hexdigest()
neutral=input_sha=='416abe9f00605ab8ed99535ebda962551c297b284dbeda33cf1f668343d863d8'
assert neutral or input_sha=='ee3e24588c73c28dd9f687ffa411dd309156508eed5a75c49d4d8f28f39e20ee','Use exact Teste33 APK or the neutral Android carrier supplied in full sources.'
assert (ROOT/'work/fullscreen-signing-key.pem').is_file() and (ROOT/'work/fullscreen-signing-cert.der').is_file(),'Restore original signing material; do not generate a new key.'
cert=x509.load_der_x509_certificate((ROOT/'work/fullscreen-signing-cert.der').read_bytes())
assert cert.fingerprint(hashes.SHA256()).hex()=='35867bcb9b79522df091687a6b2784fa7859dd68121ecb5a452a745735d39aa9'
validation=json.loads((ROOT/'work/feature66/validation66.json').read_text())
swf=(ROOT/'work/HabboTablet_Token66_Base33.swf').read_bytes()
assert hashlib.sha256(swf).hexdigest()==validation['swfSha256']
assert swf[:3]==b'FWS' and struct.unpack_from('<I',swf,4)[0]==len(swf)
compressed=b'CWS'+swf[3:8]+zlib.compress(swf[8:],9)

def signature_file(name):
 return name=='META-INF/MANIFEST.MF' or bool(re.fullmatch(r'META-INF/[^/]+\.(?:SF|RSA|DSA|EC)',name,re.I)) or bool(re.fullmatch(r'META-INF/SIG-[^/]+',name,re.I))

def patch_version(data):
    original = bytearray(data)
    entries = list(chunks(data))
    pool = next(x for x in entries if x[1] == 1)
    strings = string_pool(data, pool[0])
    new_index = len(strings)
    strings.append('2.32.31-t66-b33')
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
                assert old < 2032165, 'Expected an older Android versionCode'
                struct.pack_into('<I', original, at + 16, 2032165)
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

def package_entry(name,data):
 if name=='classes.dex':return (ROOT/'work/feature65/classes65.dex').read_bytes()
 if name=='assets/HabboTablet.swf':return compressed
 if name=='AndroidManifest.xml':return patch_version(data)
 if name=='assets/META-INF/AIR/application.xml':
  assert data.count(b'<versionNumber>')==1 and data.count(b'<versionLabel>')==1
  assert data.count(b'android:hardwareAccelerated="false"')==1
  data=data.replace(b'android:hardwareAccelerated="false"',b'android:hardwareAccelerated="true"')
  data=re.sub(rb'<versionNumber>[^<]+</versionNumber>',b'<versionNumber>2.32.165</versionNumber>',data)
  return re.sub(rb'<versionLabel>[^<]+</versionLabel>',b'<versionLabel>2.32.31-t66-b33</versionLabel>',data)
 return data

with zipfile.ZipFile(source) as old:
 original={i.filename:hashlib.sha256(old.read(i.filename)).digest() for i in old.infolist() if not signature_file(i.filename)}
 items=[(copy.copy(i),package_entry(i.filename,old.read(i.filename))) for i in old.infolist() if not signature_file(i.filename)]
 dex=old.read('classes.dex');assert struct.unpack_from('<I',dex,96)[0]==2760 and b'NativeBridge48' not in dex and b'__habboNative48' not in dex
 if neutral:
  info=zipfile.ZipInfo('assets/HabboTablet.swf',(2026,11,1,0,0,0));info.compress_type=zipfile.ZIP_DEFLATED;items.append((info,compressed))
output.parent.mkdir(exist_ok=True);sign_items(items,output)
with zipfile.ZipFile(output) as after:
 assert after.testzip() is None
 names={n for n in after.namelist() if not signature_file(n)}
 assert names==set(original)|{'assets/HabboTablet.swf'}
 changed={n for n,sha in original.items() if hashlib.sha256(after.read(n)).digest()!=sha}
 assert changed==({'AndroidManifest.xml','assets/META-INF/AIR/application.xml','classes.dex'} if neutral else {'AndroidManifest.xml','assets/META-INF/AIR/application.xml','assets/HabboTablet.swf','classes.dex'})
 data=after.read('assets/HabboTablet.swf');assert b'FWS'+data[3:8]+zlib.decompress(data[8:])==swf
 assert after.read('classes.dex')==(ROOT/'work/feature65/classes65.dex').read_bytes()
 manifest=after.read('AndroidManifest.xml');pool=next(x for x in chunks(manifest) if x[1]==1);assert '2.32.31-t66-b33' in string_pool(manifest,pool[0])
 descriptor=after.read('assets/META-INF/AIR/application.xml');assert b'<versionNumber>2.32.165</versionNumber>' in descriptor and b'<versionLabel>2.32.31-t66-b33</versionLabel>' in descriptor
 assert b'android:hardwareAccelerated="true"' in descriptor
 acceleration=[]
 for pos,kind,header,length in chunks(manifest):
  if kind!=0x102 or string_pool(manifest,pool[0])[struct.unpack_from('<I',manifest,pos+20)[0]]!='application':continue
  start,stride,total=struct.unpack_from('<HHH',manifest,pos+24)
  for i in range(total):
   at=pos+16+start+i*stride
   if string_pool(manifest,pool[0])[struct.unpack_from('<I',manifest,at+4)[0]]=='hardwareAccelerated':acceleration.append(struct.unpack_from('<I',manifest,at+16)[0])
 assert acceleration==[0xffffffff]
 with zipfile.ZipFile(source) as previous:
  for name in ['classes2.dex','classes3.dex']:assert after.read(name)==previous.read(name)
result={'checkpoint':66,'base':33,'route':'official-site browser session or manual launcher token','apk':str(output),'bytes':output.stat().st_size,'sha256':hashlib.sha256(output.read_bytes()).hexdigest(),'androidVersionName':'2.32.31-t66-b33','androidVersionCode':2032165,'airVersion':'2.32.165','swfSha256':validation['swfSha256'],'signerSha256':cert.fingerprint(hashes.SHA256()).hex(),'changedCarrierEntries':sorted(changed),'hardwareAccelerationEnabled':True,'physicalAndroidTested':False,'liveHotelTested':False}
(ROOT/'work/feature66/release66.json').write_text(json.dumps(result,indent=2)+'\n')
print('PASS: Teste33 game code plus scoped66 startup fix; hardware-accelerated WebView enabled, session storage and scoped JavaScript evaluation applied, resources/permissions/fullscreen retained; final embedded SWF exact.')
print(json.dumps(result))
