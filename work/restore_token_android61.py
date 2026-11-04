"""Restore the pre48 Android callback class; keep all other native classes."""
from pathlib import Path
import hashlib,json,re,zipfile
root=Path.cwd();feature=root/'work/feature61';decoded=feature/'carrier60/smali';host='com/adobe/air/AndroidWebView.smali'
archive=root.parent/'recovery/Habbo_Fontes_Adaptador_Nativo_60_Checkpoint.zip'
def normal(s):return '\n'.join(x.strip() for x in s.splitlines() if x.strip() and not x.strip().startswith('#'))
def methods(s):return {m.group(1):m.group(0) for m in re.finditer(r'^\.method ([^\n]+)\n.*?^\.end method',s,re.M|re.S)}
with zipfile.ZipFile(archive) as z:retained=z.read('work/android48/AndroidWebView.smali').decode()
pattern=r'    # Native48: marshal.*?  :native_bridge48_done\n\n'
restored,n=re.subn(pattern,'',retained,flags=re.S);assert n==1 and '__habboNative48' not in restored and 'NativeBridge48' not in restored
before=(decoded/host).read_text();a=methods(before);b=methods(restored);assert a.keys()==b.keys()
changed=[key for key in a if normal(a[key])!=normal(b[key])];assert changed==['public constructor <init>()V'],changed
files={p.relative_to(decoded).as_posix():normal(p.read_text()) for p in decoded.rglob('*.smali')};assert len(files)==2762
removed=['com/adobe/air/NativeBridge48.smali','com/adobe/air/NativeBridge48Task.smali']
for name in removed:assert name in files;(decoded/name).unlink();del files[name]
(decoded/host).write_text(restored);files[host]=normal(restored)
(feature/'native33').mkdir(exist_ok=True);(feature/'native33/AndroidWebView.smali').write_text(restored)
(feature/'native33/expected-classes.json').write_text(json.dumps({n:hashlib.sha256(t.encode()).hexdigest() for n,t in files.items()},indent=2)+'\n')
(feature/'native33/restoration.json').write_text(json.dumps({'runtimeBaseSwf':'original Teste33','swfSha256':'de8dd00c53bd9ece24563558ce7a19ad6183e94bad2ec651c06fd20f46d3e901','carrierApk':'Teste60 with native48 callback removed','carrierSha256':'df18a46235f18551aafd033c937c7176b9af845030b8a35ed97f75e40d8df03c','retainedSource':'work/android48/AndroidWebView.smali (pre48 class plus documented narrow hook)','changedExistingClasses':[host],'changedExistingMethods':changed,'removedClasses':removed,'remainingClasses':len(files),'originalApk33BytesAvailable':False,'limitation':'Original SWF33 recovered and verified. Native carrier restored structurally using retained pre48 source; original complete APK33 bytes unavailable.'},indent=2)+'\n')
print('PASS: original pre48 AndroidWebView restored from retained source;2760 native classes remain, only later callback classes removed.')
