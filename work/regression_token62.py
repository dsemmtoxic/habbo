from pathlib import Path
import hashlib,json,struct,subprocess,zipfile
root=Path(__file__).resolve().parents[1];f=root/'work/feature62';f.mkdir(exist_ok=True)
sources=[root/'work'/n for n in (f/'java-sources.txt').read_text().splitlines() if n]
cp='.task-tools/ffdec/ffdec.jar:work/classes'
with (f/'regression-compile.log').open('w') as out:
 subprocess.run(['java','-XX:-UsePerfData','-m','jdk.compiler/com.sun.tools.javac.Main','-cp','.task-tools/ffdec/ffdec.jar','-d','work/classes']+[str(p) for p in sources],cwd=root,stdout=out,stderr=subprocess.STDOUT,check=True)
checks=[('VerifyAppearance62',['work/HabboTablet_Token61_Base33.swf','work/HabboTablet_Token62_Base33.swf']),('VerifyLogin62',['work/HabboTablet_Token62_Base33.swf']),('AuditToken62',['work/HabboTablet_LoginSSO33.swf','work/HabboTablet_Token62_Base33.swf','work/HabboTablet_Token61_Base33.swf']),('VerifyConsole62',['work/HabboTablet_Token62_Base33.swf']),('VerifyRetained33',['work/HabboTablet_Token62_Base33.swf']),('VerifyColorBindings61',['work/HabboTablet_Token62_Base33.swf'])]
records=[]
for name,args in checks:
 p=f/(name+'.log')
 with p.open('w') as out:subprocess.run(['java','-XX:-UsePerfData','-Xmx768m','-cp',cp,name]+args,cwd=root,stdout=out,stderr=subprocess.STDOUT,check=True)
 data=p.read_bytes();assert b'PASS:' in data and b'Exception in thread' not in data
 records.append({'check':name,'log':p.relative_to(root).as_posix(),'sha256':hashlib.sha256(data).hexdigest()});print('PASS '+name,flush=True)
carrier=root/'inputs/Habbo_Android_BaseToken33.zip';assert hashlib.sha256(carrier.read_bytes()).hexdigest()=='416abe9f00605ab8ed99535ebda962551c297b284dbeda33cf1f668343d863d8'
with zipfile.ZipFile(carrier) as z:
 assert 'assets/HabboTablet.swf' not in z.namelist();dex=z.read('classes.dex')
 assert hashlib.sha256(dex).hexdigest()=='3022a54c73fdd803098d471e1e25e2903b34c1cb2bcc265447583804a57ef641'
 assert struct.unpack_from('<I',dex,96)[0]==2760 and b'NativeBridge48' not in dex and b'__habboNative48' not in dex
base=root/'work/HabboTablet_LoginSSO33.swf';swf=root/'work/HabboTablet_Token62_Base33.swf'
assert hashlib.sha256(base.read_bytes()).hexdigest()=='de8dd00c53bd9ece24563558ce7a19ad6183e94bad2ec651c06fd20f46d3e901'
result={'checkpoint':62,'base':33,'route':'token only','checks':records,'swfSha256':hashlib.sha256(swf.read_bytes()).hexdigest(),'base33SwfSha256':hashlib.sha256(base.read_bytes()).hexdigest(),'nativeClasses':2760,'automaticLoginCallbackPresent':False,'physicalAndroidTested':False,'boundaries':['Android/GPU','Flash event delivery','Feathers measurement/rasterization','live hotel/network','device clock/timer primitives']}
(f/'validation62.json').write_text(json.dumps(result,indent=2)+'\n');print('PASS: verified original33, native carrier, six suites and final SWF hash.',flush=True)
