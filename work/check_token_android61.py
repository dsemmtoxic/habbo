from pathlib import Path
import hashlib,json,struct,zlib
root=Path.cwd();feature=root/'work/feature61';after=feature/'native33_audit/smali'
def normal(s):return '\n'.join(x.strip() for x in s.splitlines() if x.strip() and not x.strip().startswith('#'))
expected=json.loads((feature/'native33/expected-classes.json').read_text());actual={p.relative_to(after).as_posix():hashlib.sha256(normal(p.read_text()).encode()).hexdigest() for p in after.rglob('*.smali')}
assert actual.keys()==expected.keys() and len(actual)==2760
for name,value in actual.items():assert value==expected[name],name
data=(feature/'carrier60/build/apk/classes.dex').read_bytes()
assert data.startswith(b'dex\n035\0') and struct.unpack_from('<I',data,32)[0]==len(data)
assert data[12:32]==hashlib.sha1(data[32:]).digest() and struct.unpack_from('<I',data,8)[0]==zlib.adler32(data[12:])&0xffffffff
assert b'NativeBridge48' not in data and b'__habboNative48' not in data
(feature/'native33/classes.dex').write_bytes(data)
print('PASS: assembled DEX round-trip matches all2760 expected native classes; automatic-login callback classes/interface absent; DEX digests valid.')
