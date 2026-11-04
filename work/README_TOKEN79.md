# Habbo 2.32.44 Teste79 Base33

A Teste78 enviava o cabeçalho 2515, registrado no Air Plus como ClickCharacterComposer. Esse caminho é o clique genérico de RoomObjectEventHandler.clickRoomObject.

A Teste79 troca esse cabeçalho por 2936, registrado como WiredClickUserMessageComposer. O Air Plus usa essa mensagem em HabboUserDefinedRoomEvents.userSelected quando o Wired de clique está ativo. InfoStandWidgetHandler encaminha o ID que usa para getUserDataByIndex. O construtor do composer grava esse índice como um único inteiro.

O APK continua a usar o alvo selecionado no menu, valida a sessão e envia um pacote. O teste executa os dois SWFs e confirma a diferença no quadro produzido pelo codificador, com socket e criptografia simulados. O disparo em uma sala conectada ao hotel depende de um teste no Android.

Para reproduzir, execute bash work/build_token79.sh e python3 work/regression_token79.py com o SWF da Teste78. Use o certificado e a chave originais e o APK da Teste78 em output para executar python3 work/make_token_apk79.py. A verificação de assinatura usa VerifyApkToken61.
