"""Package only the active Base33 branch; preserve original paths and exclude keys."""
from pathlib import Path
import hashlib,json,re,zipfile
root=Path(__file__).resolve().parents[1];folder=root/'work/feature66'
release=json.loads((folder/'release66.json').read_text());validation=json.loads((folder/'validation66.json').read_text())
assert release['androidVersionName']=='2.32.31-t66-b33' and release['androidVersionCode']==2032165
assert len(validation['checks'])==13 and validation['swfSha256']==release['swfSha256']
signature=(folder/'apk-signature.log').read_text();assert 'PASS:' in signature and 'Warnings: []' in signature
progress_path=root/'work/PROGRESSO_INTEGRACAO_NATIVA.md'
assert progress_path.read_text().startswith('# Teste66 / Base33')
delta=[
 "work/AuditToken66.java",
 "work/HabboTablet_Token66_Base33.swf",
 "work/Login62.as",
 "work/PatchToken66.java",
 "work/PROGRESSO_INTEGRACAO_NATIVA.md",
 "work/README_TOKEN66.md",
 "work/VerifyToken66.java",
 "work/build_token66.sh",
 "work/make_token_apk66.py",
 "work/package_token66.py",
 "work/regression_token66.py",
 "work/feature66/release66.json",
 "work/feature66/validation66.json",
 "work/feature66/startup-cause66.json",
 "work/feature66/build.log",
 "work/feature66/compile.log",
 "work/feature66/tests-compile.log",
 "work/feature66/apk-build.log",
 "work/feature66/apk-signature.log"
]
delta += [check['log'] for check in validation['checks'] if check['log'].startswith('work/feature66/')]
plan_name='work/feature66/package-plan66.json';delta.append(plan_name)
previous=json.loads((root/'work/feature65/package-plan65.json').read_text())
plan={'full':sorted(set(previous['full']+delta)),'delta':sorted(set(delta))};(folder/'package-plan66.json').write_text(json.dumps(plan,indent=2)+'\n')
results=[]
for kind,filename in [('full','Habbo_Token66_Base33_Fontes.zip'),('delta','Habbo_Teste66_Base33_Alteracoes.zip')]:
 records=[]
 for name in plan[kind]:
  assert not Path(name).is_absolute() and '..' not in Path(name).parts
  assert not re.search(r'(?:signing-key|signing-cert|Assinatura_Privada|NativeAir|AuthSession34)',name,re.I)
  path=root/name;data=path.read_bytes();records.append({'path':name,'bytes':len(data),'sha256':hashlib.sha256(data).hexdigest()})
 manifest={'checkpoint':66,'base':33,'route':release['route'],'kind':kind,'files':records}
 output=root/'output'/filename
 with zipfile.ZipFile(output,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=6) as archive:
  for row in records:
   info=zipfile.ZipInfo(row['path'],(2026,11,2,0,0,0));info.compress_type=zipfile.ZIP_DEFLATED;info.external_attr=(0o100755 if row['path'].endswith('.sh') else 0o100644)<<16
   archive.writestr(info,(root/row['path']).read_bytes())
  archive.writestr('PACKAGE_MANIFEST_TOKEN66.json',json.dumps(manifest,ensure_ascii=False,indent=2)+'\n')
 with zipfile.ZipFile(output) as archive:
  assert archive.testzip() is None and len(archive.namelist())==len(set(archive.namelist()))==len(records)+1
  for row in records:assert hashlib.sha256(archive.read(row['path'])).hexdigest()==row['sha256']
 result={'kind':kind,'filename':filename,'bytes':output.stat().st_size,'sha256':hashlib.sha256(output.read_bytes()).hexdigest(),'entries':len(records)+1};results.append(result);print('PASS: '+json.dumps(result),flush=True)
(folder/'archives66.json').write_text(json.dumps(results,indent=2)+'\n')
