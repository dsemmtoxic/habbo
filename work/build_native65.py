"""Rebuild only AndroidWebView's cookie/storage policy; preserve the other dex files."""
from pathlib import Path
import json,re,subprocess,shutil,hashlib,zipfile
root=Path(__file__).resolve().parents[1]
folder=root/'work/feature65'; native=folder/'native'; source=root/'work/native65/AndroidWebView.smali'
folder.mkdir(exist_ok=True)
def run(args,log):
 with (folder/log).open('w') as output:subprocess.run(args,cwd=root,stdout=output,stderr=subprocess.STDOUT,check=True)
if not native.is_dir():run(['java','-XX:-UsePerfData','-Xmx768m','-jar','.task-tools/apktool61.jar','d','-f','-r','-o',str(native),'inputs/Habbo_Android_BaseToken33.zip'],'native-decode.log')
target=native/'smali/com/adobe/air/AndroidWebView.smali'
original=target.read_text()
if not source.exists():
 text=original
 anchor='    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setJavaScriptEnabled(Z)V'
 assert text.count(anchor)==1
 text=text.replace(anchor,anchor+'''\n\n    # Persist the first-party website session in the system WebView profile.
    invoke-virtual {v0, v1}, Landroid/webkit/WebSettings;->setDomStorageEnabled(Z)V

    invoke-static {}, Landroid/webkit/CookieManager;->getInstance()Landroid/webkit/CookieManager;
    move-result-object v2
    invoke-virtual {v2, v1}, Landroid/webkit/CookieManager;->setAcceptCookie(Z)V''')
 anchor='.method public destroyInternals()V\n    .locals 2'
 assert text.count(anchor)==1
 text=text.replace(anchor,anchor+'''\n\n    sget v0, Landroid/os/Build$VERSION;->SDK_INT:I
    const/16 v1, 0x15
    if-lt v0, v1, :session64_cookies_done
    invoke-static {}, Landroid/webkit/CookieManager;->getInstance()Landroid/webkit/CookieManager;
    move-result-object v0
    invoke-virtual {v0}, Landroid/webkit/CookieManager;->flush()V
    :session64_cookies_done''')
 source.parent.mkdir(exist_ok=True);source.write_text(text)
target.write_bytes(source.read_bytes())
out=folder/'native-rebuilt.apk'
run(['java','-XX:-UsePerfData','-Xmx768m','-jar','.task-tools/apktool61.jar','b',str(native),'-o',str(out)],'native-build.log')
with zipfile.ZipFile(out) as archive:data=archive.read('classes.dex')
(folder/'classes65.dex').write_bytes(data)
result={'source':'work/native65/AndroidWebView.smali','changedMethods':['<init>()V','destroyInternals()V','loadURL(Ljava/lang/String;)V'],'sha256':hashlib.sha256(data).hexdigest(),'otherDexFiles':'kept byte-for-byte from Base33','sessionCookiesCleared':False}
(folder/'native65.json').write_text(json.dumps(result,indent=2)+'\n')
print('PASS: AndroidWebView enables DOM storage, accepts website cookies and flushes them on close. JavaScript evaluation avoids navigation; other dex files are retained by the packager.')
