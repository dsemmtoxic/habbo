# Teste77 / Base33

A Teste77 parte do SWF exato da Teste76.

- O menu de outro usuário vira o avatar durante a preparação do menu. A atualização posterior das opções do menu reaproveita o alvo sem enviar outro giro.
- Clicar usa o identificador do objeto na sala, como o `ClickCharacterComposer` do Air Plus. O cabeçalho é 2515 e o conteúdo é um inteiro. A ação não envia um giro em seguida, para preservar a direção que um efeito Wired possa definir.
- O editor moderno de Wired exibe o título e os controles de configuração sem a linha de descrição.

Reprodução a partir da raiz do projeto:

1. Execute `bash work/build_token77.sh`.
2. Execute `python3 work/regression_token77.py`.
3. Com o certificado e a chave originais em `work/fullscreen-signing-cert.der` e `work/fullscreen-signing-key.pem`, execute `python3 work/make_token_apk77.py` e verifique a assinatura v1/v2 com `VerifyApkToken61`.
4. Execute `python3 work/package_token77.py` com o ZIP completo da Teste76 disponível em `output/`.

A verificação local executa os métodos AVM2 salvos e compara a consulta do cabeçalho à tabela do SWF do Air Plus. A ativação no servidor e a interface em um Android físico precisam de um teste em sala conectada.
