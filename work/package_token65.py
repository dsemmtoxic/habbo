"""Package only the active Base33 branch; preserve original paths and exclude keys."""
from pathlib import Path
import hashlib,json,re,zipfile
root=Path(__file__).resolve().parents[1];folder=root/'work/feature65'
release=json.loads((folder/'release65.json').read_text());validation=json.loads((folder/'validation65.json').read_text())
assert release['androidVersionName']=='2.32.30-t65-b33' and release['androidVersionCode']==2032164
assert len(validation['checks'])==12 and validation['swfSha256']==release['swfSha256']
signature=(folder/'apk-signature.log').read_text();assert 'PASS:' in signature and 'Warnings: []' in signature
progress_path=root/'work/PROGRESSO_INTEGRACAO_NATIVA.md'
assert progress_path.read_text().startswith('# Teste65 / Base33')
delta=[
 "work/AuditToken65.java",
 "work/HabboTablet_Token65_Base33.swf",
 "work/Login62.as",
 "work/ModernUI65.as",
 "work/RoomEntry65.as",
 "work/PROGRESSO_INTEGRACAO_NATIVA.md",
 "work/PatchToken65.java",
 "work/README_TOKEN65.md",
 "work/RoomLighting63.as",
 "work/VerifyToken65.java",
 "work/WebSession64.as",
 "work/build_native65.py",
 "work/build_token65.sh",
 "work/check_native65.py",
 "work/make_token_apk65.py",
 "work/native65/AndroidWebView.smali",
 "work/package_token65.py",
 "work/regression_token65.py",
 "work/session64.js",
 "work/test_session65.js",
 "work/feature65/classes65.dex",
 "work/feature65/native65.json",
 "work/feature65/native-validation65.json",
 "work/feature65/release65.json",
 "work/feature65/validation65.json",
 "work/feature65/site-evidence65.json",
 "work/feature65/build.log",
 "work/feature65/compile.log",
 "work/feature65/tests-compile.log",
 "work/feature65/apk-build.log",
 "work/feature65/apk-signature.log"
]
delta += [check['log'] for check in validation['checks']]
plan_name='work/feature65/package-plan65.json';delta.append(plan_name)
previous=json.loads((root/'work/feature64/package-plan64.json').read_text())
plan={'full':sorted(set(previous['full']+delta)),'delta':sorted(set(delta))};(folder/'package-plan65.json').write_text(json.dumps(plan,indent=2)+'\n')
results=[]
for kind,filename in [('full','Habbo_Token65_Base33_Fontes.zip'),('delta','Habbo_Teste65_Base33_Alteracoes.zip')]:
 records=[]
 for name in plan[kind]:
  assert not Path(name).is_absolute() and '..' not in Path(name).parts
  assert not re.search(r'(?:signing-key|signing-cert|Assinatura_Privada|NativeAir|AuthSession34)',name,re.I)
  path=root/name;data=path.read_bytes();records.append({'path':name,'bytes':len(data),'sha256':hashlib.sha256(data).hexdigest()})
 manifest={'checkpoint':65,'base':33,'route':release['route'],'kind':kind,'files':records}
 output=root/'output'/filename
 with zipfile.ZipFile(output,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=6) as archive:
  for row in records:
   info=zipfile.ZipInfo(row['path'],(2026,11,2,0,0,0));info.compress_type=zipfile.ZIP_DEFLATED;info.external_attr=(0o100755 if row['path'].endswith('.sh') else 0o100644)<<16
   archive.writestr(info,(root/row['path']).read_bytes())
  archive.writestr('PACKAGE_MANIFEST_TOKEN65.json',json.dumps(manifest,ensure_ascii=False,indent=2)+'\n')
 with zipfile.ZipFile(output) as archive:
  assert archive.testzip() is None and len(archive.namelist())==len(set(archive.namelist()))==len(records)+1
  for row in records:assert hashlib.sha256(archive.read(row['path'])).hexdigest()==row['sha256']
 result={'kind':kind,'filename':filename,'bytes':output.stat().st_size,'sha256':hashlib.sha256(output.read_bytes()).hexdigest(),'entries':len(records)+1};results.append(result);print('PASS: '+json.dumps(result),flush=True)
(folder/'archives65.json').write_text(json.dumps(results,indent=2)+'\n')
