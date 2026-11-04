# Habbo Android 2.32.45 Teste80 Base33

Este pacote reúne a base Android/AIR, os arquivos de alteração, os SWFs de referência, os testes e os workflows para gerar o APK. O build recompila as alterações da Teste80 sobre o SWF exato da Teste79 e empacota o resultado com o runtime Android e os recursos da Base33. O núcleo AIR e os DEX originais do cliente fazem parte da base distribuída em formato compilado.

## Subir ao GitHub

Extraia o ZIP em uma pasta vazia. Faça commit dos arquivos extraídos, incluindo `.github`, na raiz do repositório. Use Git no terminal. O arquivo da base Android ultrapassa o limite de upload pelo navegador. Nenhum arquivo individual deste projeto precisa de Git LFS.

Na aba **Actions**, o workflow **1 - Validar build do Habbo** recompila o SWF, executa os testes e monta um APK sem assinatura a cada push ou pull request. Ele também pode ser disparado manualmente.

## Configurar a assinatura

Em **Settings > Secrets and variables > Actions**, crie os quatro *repository secrets* abaixo. Os nomes são os mesmos usados pelo TikSave. Preencha com os dados da assinatura do Habbo.

| Secret | Valor |
| --- | --- |
| `KEYSTORE_BASE64` | Keystore original do Habbo em Base64 |
| `KEYSTORE_PASSWORD` | Senha do keystore |
| `KEY_ALIAS` | Alias da chave |
| `KEY_PASSWORD` | Senha da chave |

Se a sua assinatura original está no arquivo separado `Habbo_Assinatura_Privada.zip`, extraia a chave e o certificado em uma pasta privada fora do repositório. Nessa pasta, converta o certificado DER para PEM e crie o keystore PKCS#12 usando a mesma chave e o mesmo certificado.

```bash
umask 077
openssl x509 -inform DER -in fullscreen-signing-cert.der -out habbo-release-cert.pem
openssl pkcs12 -export -inkey fullscreen-signing-key.pem \
  -in habbo-release-cert.pem -name habbo-release -out habbo-release.p12
```

Use `habbo-release` como alias e a senha de exportação nos dois campos de senha. Com a CLI do GitHub autenticada, você pode enviar o Base64 direto ao secret. Substitua `USUARIO/REPOSITORIO` pelo destino.

```bash
base64 < habbo-release.p12 | tr -d '\n' | gh secret set KEYSTORE_BASE64 -R USUARIO/REPOSITORIO
```

O workflow só publica o APK quando o certificado SHA-256 coincide com o da Base33. Isso preserva a identidade de assinatura das versões anteriores.

## Gerar e baixar o APK

1. Abra **Actions > 2 - Gerar APK assinado > Run workflow**.
2. Ao concluir, baixe **Habbo-APK-assinado-`número da execução`** em **Artifacts**.
3. Extraia o APK do artefato. O arquivo `.sha256` permite conferir se a cópia está íntegra.

A assinatura usa o Android Build Tools 36.0.0. O workflow alinha o APK antes de assinar e verifica o alinhamento, as assinaturas v1/v2, o certificado e o conteúdo final antes de disponibilizar o artefato.

## Compilar localmente

No Linux, com Java 17, Python 3, `curl` e `unzip`, execute na raiz:

```bash
bash ci/setup-ffdec.sh
bash ci/build-apk.sh output/Habbo-unsigned.apk
```

Para assinar localmente, instale Android Build Tools 36.0.0 e defina `ANDROID_HOME` ou `ANDROID_BUILD_TOOLS` com o caminho das ferramentas. Disponibilize os quatro valores de assinatura no ambiente e execute:

```bash
bash ci/sign-apk.sh output/Habbo-unsigned.apk output/Habbo_2.32.45_Teste80_Base33.apk
```

As alterações atuais do cliente estão em `work/PatchToken80.java` e `work/BuilderClub80.as`. O código nativo alterado de WebView está em `work/native65/AndroidWebView.smali` e seu DEX incluído é usado durante o empacotamento. Para uma futura versão, ajuste o nome e os números de versão em `work/make_token_apk80.py` e o nome do artefato APK no workflow. O arquivo [work/README_TOKEN80.md](work/README_TOKEN80.md) descreve as alterações da Teste80.
