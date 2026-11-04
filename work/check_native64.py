from pathlib import Path
import re,json,subprocess,hashlib,struct
root=Path(__file__).resolve().parents[1];folder=root/'work/feature64'
target=folder/'native-verify'
with (folder/'native-verify-decode.log').open('w') as log:
 subprocess.run(['java','-XX:-UsePerfData','-Xmx768m','-jar','.task-tools/apktool61.jar','d','-f','-r','-o',str(target),str(folder/'native-rebuilt.apk')],cwd=root,stdout=log,stderr=subprocess.STDOUT,check=True)
original=folder/'native/smali';after=target/'smali'
def normalize(text):
 lines=[];labels={}
 for raw in text.splitlines():
  line=raw.strip()
  if not line or line.startswith(('.line ','.source ','#')):continue
  if line.startswith('.method '):labels={}
  def label(match):
   value=match.group(0)
   if value not in labels:labels[value]=':label'+str(len(labels))
   return labels[value]
  line=re.sub(r'(?<![\w/]):[A-Za-z0-9_$]+',label,line)
  lines.append(line)
 return '\n'.join(lines)
files={p.relative_to(original).as_posix() for p in original.rglob('*.smali')}
assert files=={p.relative_to(after).as_posix() for p in after.rglob('*.smali')}
for name in files:
 assert normalize((original/name).read_text())==normalize((after/name).read_text()),'Changed assembled semantics: '+name
name='com/adobe/air/AndroidWebView.smali'
old=(root/'work/feature61/native33/AndroidWebView.smali').read_text();new=(after/name).read_text()
def methods(text):return {m.group(1).strip():normalize(m.group(2)) for m in re.finditer(r'^\.method ([^\n]+)\n([\s\S]*?)^\.end method',text,re.M)}
a,b=methods(old),methods(new);assert a.keys()==b.keys()
changed={name for name in a if a[name]!=b[name]}
assert changed=={'public constructor <init>()V','public destroyInternals()V'},changed
assert 'setDomStorageEnabled(Z)V' in b['public constructor <init>()V'] and 'setAcceptCookie(Z)V' in b['public constructor <init>()V']
assert 'CookieManager;->flush()V' in b['public destroyInternals()V']
assert all(new.count(x)==old.count(x) for x in ['addJavascriptInterface','removeAllCookies','setAllowUniversalAccessFromFileURLs','SslErrorHandler;->proceed'])
data=(folder/'classes64.dex').read_bytes();assert struct.unpack_from('<I',data,96)[0]==2760
report={'mainDexClasses':len(files),'roundTripAllClasses':True,'changedOriginalMethods':sorted(changed),'sha256':hashlib.sha256(data).hexdigest(),'otherDexFiles':'packager retains original bytes'}
(folder/'native-validation64.json').write_text(json.dumps(report,indent=2)+'\n')
print('PASS: all '+str(len(files))+' main-dex classes reassemble and disassemble without semantic drift. Only AndroidWebView constructor/storage policy and cookie flush differ from original33; no added JavaScript native interface, TLS bypass or cookie deletion.')
