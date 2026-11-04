# Habbo 2.32.43 Teste78 Base33

A ação Clicar é despachada pelo ID nativo do item de menu. Ela usa o índice do usuário recebido durante a seleção na sala, confere a sessão e o ocupante do índice e passa pelo envio nativo das demais ações do menu. Isso evita depender de um campo auxiliar do item e de uma nova busca pelo objeto gráfico.

O teste executa o AVM2 salvo desde o menu até o codificador e o envio. Confere o pacote de 10 bytes antes da criptografia, com cabeçalho 2515 e índice de sala de 32 bits. As APIs de socket e criptografia são simuladas. O efeito Wired em uma sala conectada ao hotel ainda precisa de validação.

Para reproduzir, use o SWF FWS da Teste77 (extraído de assets/HabboTablet.swf do APK e descomprimido). O SHA-256 esperado é 3a6ccf580603bdd0974b0b72e515d5a91280039c5a120815f5da8487604761e4. Execute bash work/build_token78.sh e python3 work/regression_token78.py. Com a chave e o certificado originais e o APK Teste77 em output, execute python3 work/make_token_apk78.py.
