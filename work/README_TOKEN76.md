# Habbo 2.32.41 Teste76 Base33

A fila geral aceita seis transferências. Recursos pendentes do quarto e dos mobis têm prioridade. Visuais de avatar e seus efeitos ocupam até quatro vagas, reservando capacidade para dois recursos de quarto. O gerenciador de bibliotecas de avatar prepara até seis solicitações, com janela de despacho de 50 ms.

O cliente grava o cache por revisão com FileStream assíncrono, sem aguardar o término da escrita para exibir o recurso. O arquivo temporário só é publicado após fechar com o tamanho esperado e após o carregador nativo marcar o recurso como pronto. Falhas locais não descartam o recurso em memória. Revisões anteriores ficam sujeitas à limpeza normal do cache do aplicativo.

A montagem dos mobis reavalia o tempo a cada quatro lotes e cede após 30 ms. A rodada seguinte continua a montagem, sem pular uma atualização do motor. A cadência global do motor foi preservada.

## Reprodução

```sh
bash work/build_token76.sh
python work/regression_token76.py
python work/make_token_apk76.py
```

O build usa o SWF exato da Teste75. Para empacotar o APK, coloque o APK anterior em output e use o material de assinatura original. As verificações locais executam o bytecode salvo com rede e sistema de arquivos simulados. O ganho em Android conectado ao hotel precisa ser medido.
