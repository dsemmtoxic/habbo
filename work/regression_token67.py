"""Exercise the saved AVM2, native carrier and browser script; no real hotel login."""
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor,as_completed
import hashlib,json,subprocess,shutil,sys
root=Path(__file__).resolve().parents[1];folder=root/'work/feature67';folder.mkdir(exist_ok=True)
sources=(root/'work/feature63/java-sources.txt').read_text().splitlines()+['PatchToken64.java','VerifyToken64.java','PatchToken65.java','VerifyToken65.java','AuditToken65.java','PatchToken66.java','VerifyToken66.java','AuditToken66.java','PatchToken67.java','VerifyToken67.java','AuditToken67.java']
with (folder/'tests-compile.log').open('w') as log:
 subprocess.run(['java','-XX:-UsePerfData','-m','jdk.compiler/com.sun.tools.javac.Main','-cp','.task-tools/ffdec/ffdec.jar','-d','work/classes']+['work/'+name for name in sources],cwd=root,stdout=log,stderr=subprocess.STDOUT,check=True)
commands=[]
for mode in ['settings','render']:
 commands.append((mode,['java','-XX:-UsePerfData','-Xmx768m','-cp','.task-tools/ffdec/ffdec.jar:work/classes','VerifyToken64','work/HabboTablet_Token63_Base33.swf','work/HabboTablet_Token67_Base33.swf',mode]))
for mode in ['lighting','login','mesh']:
 commands.append((mode,['java','-XX:-UsePerfData','-Xmx768m','-cp','.task-tools/ffdec/ffdec.jar:work/classes','VerifyToken65','work/HabboTablet_Token67_Base33.swf',mode]))
for mode in ['logout','entrance','console']:
 commands.append((mode,['java','-XX:-UsePerfData','-Xmx768m','-cp','.task-tools/ffdec/ffdec.jar:work/classes','VerifyToken67','work/HabboTablet_Token66_Base33.swf','work/HabboTablet_Token67_Base33.swf',mode]))
for label,cls,args in [('audit','AuditToken67',['work/HabboTablet_Token66_Base33.swf','work/HabboTablet_Token67_Base33.swf']),('retained33','VerifyRetained33',['work/HabboTablet_Token67_Base33.swf']),('colorBindings','VerifyColorBindings61',['work/HabboTablet_Token67_Base33.swf'])]:
 commands.append((label,['java','-XX:-UsePerfData','-Xmx768m','-cp','.task-tools/ffdec/ffdec.jar:work/classes',cls]+args))
commands.append(('startup-types',['java','-XX:-UsePerfData','-Xmx768m','-cp','.task-tools/ffdec/ffdec.jar:work/classes','VerifyToken66','work/HabboTablet_Token65_Base33.swf','work/HabboTablet_Token67_Base33.swf']))
commands.append(('browser-script',[shutil.which('node') or 'node','work/test_session67.js']))
def run(item):
 label,args=item;path=folder/('test-'+label+'.log')
 with path.open('w') as log:subprocess.run(args,cwd=root,stdout=log,stderr=subprocess.STDOUT,check=True)
 data=path.read_bytes();assert b'PASS:' in data and b'Exception in thread' not in data
 return {'check':label,'log':path.relative_to(root).as_posix(),'sha256':hashlib.sha256(data).hexdigest()}
records=[]
with ThreadPoolExecutor(max_workers=3) as pool:
 for result in as_completed([pool.submit(run,item) for item in commands]):
  record=result.result();records.append(record);print('PASS '+record['check'],flush=True)
native=root/'work/feature65/native-validation65.json';dex=root/'work/feature65/classes65.dex'
if not native.exists() or not dex.exists():
 subprocess.run([sys.executable,'work/build_native65.py'],cwd=root,check=True)
 subprocess.run([sys.executable,'work/check_native65.py'],cwd=root,check=True)
native_result=json.loads(native.read_text());assert native_result['sha256']==hashlib.sha256(dex.read_bytes()).hexdigest()
records.append({'check':'native-2760-class-roundtrip','log':'work/feature65/test-native.log','sha256':hashlib.sha256((root/'work/feature65/test-native.log').read_bytes()).hexdigest()})
base=root/'work/HabboTablet_LoginSSO33.swf';assert hashlib.sha256(base.read_bytes()).hexdigest()=='de8dd00c53bd9ece24563558ce7a19ad6183e94bad2ec651c06fd20f46d3e901'
result={'checkpoint':67,'base':33,'route':'official-site browser session or manual launcher token','checks':sorted(records,key=lambda r:r['check']),'swfSha256':hashlib.sha256((root/'work/HabboTablet_Token67_Base33.swf').read_bytes()).hexdigest(),'nativeDexSha256':native_result['sha256'],'physicalAndroidTested':False,'liveHotelTested':False,'boundaries':['Android/GPU rasterization','Feathers font/layout measurement','operating-system event delivery','website services/2FA in a signed-in session','actual server acknowledgements and disk/cookie persistence']}
(folder/'validation67.json').write_text(json.dumps(result,indent=2)+'\n')
print('PASS: 14 focused/regression checks; physical Android and live hotel validation remain pending.',flush=True)
