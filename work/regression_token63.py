from pathlib import Path
import hashlib,json,struct,subprocess,zipfile
root=Path(__file__).resolve().parents[1];folder=root/'work/feature63';folder.mkdir(exist_ok=True)
sources=[root/'work'/s for s in (folder/'java-sources.txt').read_text().splitlines() if s]
with (folder/'tests-compile.log').open('w') as out:
 subprocess.run(['java','-XX:-UsePerfData','-m','jdk.compiler/com.sun.tools.javac.Main','-cp','.task-tools/ffdec/ffdec.jar','-d','work/classes']+[str(p) for p in sources],cwd=root,stdout=out,stderr=subprocess.STDOUT,check=True)
checks=[('VerifyToken63',['work/HabboTablet_Token62_Base33.swf','work/HabboTablet_Token63_Base33.swf',mode],mode) for mode in ['door','login','settings','lighting','render']]+[('AuditToken63',['work/HabboTablet_LoginSSO33.swf','work/HabboTablet_Token62_Base33.swf','work/HabboTablet_Token63_Base33.swf'],'audit63'),('VerifyConsole62',['work/HabboTablet_Token63_Base33.swf'],'console63'),('VerifyRetained33',['work/HabboTablet_Token63_Base33.swf'],'retained33'),('VerifyColorBindings61',['work/HabboTablet_Token63_Base33.swf'],'colorBindings63')]
records=[]
for name,args,mode in checks:
 path=folder/('test-'+mode+'.log')
 with path.open('w') as out:subprocess.run(['java','-XX:-UsePerfData','-Xmx768m','-cp','.task-tools/ffdec/ffdec.jar:work/classes',name]+args,cwd=root,stdout=out,stderr=subprocess.STDOUT,check=True)
 data=path.read_bytes();assert b'PASS:' in data and b'Exception in thread' not in data
 records.append({'check':name,'mode':mode,'log':path.relative_to(root).as_posix(),'sha256':hashlib.sha256(data).hexdigest()});print('PASS '+mode,flush=True)
carrier=root/'inputs/Habbo_Android_BaseToken33.zip';assert hashlib.sha256(carrier.read_bytes()).hexdigest()=='416abe9f00605ab8ed99535ebda962551c297b284dbeda33cf1f668343d863d8'
with zipfile.ZipFile(carrier) as z:
 assert 'assets/HabboTablet.swf' not in z.namelist();dex=z.read('classes.dex');assert struct.unpack_from('<I',dex,96)[0]==2760 and hashlib.sha256(dex).hexdigest()=='3022a54c73fdd803098d471e1e25e2903b34c1cb2bcc265447583804a57ef641' and b'NativeBridge48' not in dex
base=root/'work/HabboTablet_LoginSSO33.swf';assert hashlib.sha256(base.read_bytes()).hexdigest()=='de8dd00c53bd9ece24563558ce7a19ad6183e94bad2ec651c06fd20f46d3e901'
swf=root/'work/HabboTablet_Token63_Base33.swf'
result={'checkpoint':63,'base':33,'route':'token only','checks':records,'swfSha256':hashlib.sha256(swf.read_bytes()).hexdigest(),'nativeClasses':2760,'automaticLoginCallbackPresent':False,'physicalAndroidTested':False,'boundaries':['Android/GPU rasterization','Flash event delivery','Feathers measurement/font rasterization','live hotel/network','SharedObject disk flush','platform focus and texture upload']}
(folder/'validation63.json').write_text(json.dumps(result,indent=2)+'\n');print('PASS: nine focused/regression checks and native carrier.',flush=True)
