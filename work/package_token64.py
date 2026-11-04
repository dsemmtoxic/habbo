"""Package only the active Base33 branch; preserve original paths and exclude keys."""
from pathlib import Path
import hashlib,json,re,zipfile
root=Path(__file__).resolve().parents[1];folder=root/'work/feature64'
release=json.loads((folder/'release64.json').read_text());validation=json.loads((folder/'validation64.json').read_text())
assert release['androidVersionName']=='2.32.29-t64-b33' and release['androidVersionCode']==2032163
assert len(validation['checks'])==11 and validation['swfSha256']==release['swfSha256']
signature=(folder/'apk-signature.log').read_text();assert 'PASS:' in signature and 'Warnings: []' in signature
progress_path=root/'work/PROGRESSO_INTEGRACAO_NATIVA.md';progress=progress_path.read_text();history=progress[progress.index('# Teste63 / Base33 / Token'):]
prefix=f'''# Teste64 / Base33 — atualização ativa

Atualizado em02/11/2026, horário do usuário. O retorno real da63 mostrou parede cobrindo a entrada, Aplicar do Toner/regulador sem manter valores, regulador permitindo escuro excessivo, datas grandes no console e login/moldura inadequados. O usuário solicitou expressamente login pelo site em WebView com sessão persistente; essa autorização substitui a restrição histórica de login somente por token. A migração nativa34–60 continua suspensa.

**Teste64 implementada, APK assinado e verificações locais concluídas. Validação Android/conta real pendente.**

- Máscara original da porta restaurada separadamente da imagem escura/clip desativados. Paredes e guia da entrada originais33 preservados.
- Causa do salvamento reproduzida: variável local save ocultava a função e deixava Aplicar sem listener. Listener explícito corrigido. O editor espera confirmação do estado nativo recebido; prévia/rascunhos não substituem dados confirmados.
- Regulador como Air Plus20.9: sete cores, intensidade mínima76/255, três presets e somente piso/paredes versus modo completo, incluindo a integração do fundo. Campos do protocolo nativo e intensidade int verificados. A referência Plus dos fontes é byte a byte igual ao APK fornecido.
- Console com hora HH:mm pequena em label própria, selo Hoje/Ontem/dd/MM acima da primeira mensagem do dia, atualização após paginação e reciclagem. Histórico/cursor/deduplicação/não lidas preservados.
- Login centralizado de tamanho intermediário e moldura nativa mais visível. Conta/Token, hotel e engrenagem permanentes.
- WebView abre o site HTTPS oficial; e-mail/senha/2FA ficam no próprio site. Cookies/DOM storage no perfil Android e flush ao fechar. Código Launcher atual vai ao login33; não é salvo pelo helper. Nome/figure e head no login; perfil exibido como sessão salva, sujeito à validade real do site. Gerenciar conta e token manual disponíveis.

Onze verificações locais aprovadas.37678 métodos anteriores fora dos helpers preservados; três mudanças existentes limitadas, dois getters de leitura e um helper de navegador. Roundtrip das2760 classes do dex principal aprovado, somente dois métodos de AndroidWebView modificados; classes2.dex/classes3.dex iguais à base. APKv1/v2 verificado, sem avisos, certificado original33.

Android2.32.29-t64-b33; versionCode2032163; AIR2.32.163.
SHA256 APK: `{release['sha256']}`.
SHA256 SWF: `{release['swfSha256']}`.

Reprodução, limites e roteiro completo: `work/README_TOKEN64.md`, `work/feature64/validation64.json`, `work/feature64/release64.json`. Fontes completos64 e ZIP somente de alterações preservam caminhos originais. Material de assinatura excluído.

## Confirmação ainda necessária no aparelho

1. Recorte sem sombra, piso de entrada e paredes nas duas orientações, máscaras de mobis/janelas e piso isolado.
2. Toner/regulador: Aplicar e aguardar fechar; reabrir, reentrar no quarto e reiniciar o app. Testar Cancelar, ON/OFF, presets, brilho mínimo e fundo sem perder mobis.
3. Console real: horas pequenas, selo único por dia, envio/recebimento e paginação.
4. Tela de login/bordas; WebView oficial com conta/2FA, nome/head, Entrar após reinício, sessão expirada e troca de hotel. O site bloqueou inspeção automatizada anônima; DOM/endpoints, cookies, eventos Android e rede real permanecem limites de teste. Se necessário, usar Jogar no próprio site para expor o código Launcher; token manual preservado.

Testes locais não equivalem a execução visual em Android nem a confirmação de servidor/conta real. Não reutilizar OTP histórico nem pedir senha/2FA para substituir os testes no aparelho.

---

'''
progress_path.write_text(prefix+history)
delta=[
 'work/AuditToken64.java','work/ClientTheme63.as','work/Console61.as','work/HabboTablet_Token64_Base33.swf','work/Login62.as','work/PROGRESSO_INTEGRACAO_NATIVA.md','work/PatchToken64.java','work/README_TOKEN64.md','work/RoomLighting63.as','work/VerifyToken64.java','work/WebSession64.as',
 'work/build_native64.py','work/build_token64.sh','work/check_native64.py','work/make_token_apk64.py','work/native64/AndroidWebView.smali','work/package_token64.py','work/regression_token64.py','work/session64.js','work/test_session64.js',
 'work/feature64/classes64.dex','work/feature64/native64.json','work/feature64/native-validation64.json','work/feature64/release64.json','work/feature64/validation64.json','work/feature64/build.log','work/feature64/compile.log','work/feature64/tests-compile.log','work/feature64/apk-build.log','work/feature64/apk-signature.log']
delta += [check['log'] for check in validation['checks']]
plan_name='work/feature64/package-plan64.json';delta.append(plan_name)
previous=json.loads((root/'work/feature63/package-plan63.json').read_text())
plan={'full':sorted(set(previous['full']+delta)),'delta':sorted(set(delta))};(folder/'package-plan64.json').write_text(json.dumps(plan,indent=2)+'\n')
results=[]
for kind,filename in [('full','Habbo_Token64_Base33_Fontes.zip'),('delta','Habbo_Teste64_Base33_Alteracoes.zip')]:
 records=[]
 for name in plan[kind]:
  assert not Path(name).is_absolute() and '..' not in Path(name).parts
  assert not re.search(r'(?:signing-key|signing-cert|Assinatura_Privada|NativeAir|AuthSession34)',name,re.I)
  path=root/name;data=path.read_bytes();records.append({'path':name,'bytes':len(data),'sha256':hashlib.sha256(data).hexdigest()})
 manifest={'checkpoint':64,'base':33,'route':release['route'],'kind':kind,'files':records}
 output=root/'output'/filename
 with zipfile.ZipFile(output,'w',compression=zipfile.ZIP_DEFLATED,compresslevel=6) as archive:
  for row in records:
   info=zipfile.ZipInfo(row['path'],(2026,11,2,0,0,0));info.compress_type=zipfile.ZIP_DEFLATED;info.external_attr=(0o100755 if row['path'].endswith('.sh') else 0o100644)<<16
   archive.writestr(info,(root/row['path']).read_bytes())
  archive.writestr('PACKAGE_MANIFEST_TOKEN64.json',json.dumps(manifest,ensure_ascii=False,indent=2)+'\n')
 with zipfile.ZipFile(output) as archive:
  assert archive.testzip() is None and len(archive.namelist())==len(set(archive.namelist()))==len(records)+1
  for row in records:assert hashlib.sha256(archive.read(row['path'])).hexdigest()==row['sha256']
 result={'kind':kind,'filename':filename,'bytes':output.stat().st_size,'sha256':hashlib.sha256(output.read_bytes()).hexdigest(),'entries':len(records)+1};results.append(result);print('PASS: '+json.dumps(result),flush=True)
(folder/'archives64.json').write_text(json.dumps(results,indent=2)+'\n')
