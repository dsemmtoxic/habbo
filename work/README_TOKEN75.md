# Habbo 2.32.40 Teste75 Base33

A fila de bibliotecas da Teste74 é ampliada de duas para quatro vagas. A fila geral entrega a próxima vaga primeiro aos recursos do quarto e de mobis já pendentes. Bibliotecas de roupa, acessórios e efeitos de avatar passam depois e ocupam até três vagas. A quarta fica disponível para uma nova biblioteca do quarto. Transferências em andamento seguem até o fim e a ordem de chegada é preservada dentro de cada prioridade.

O gerenciador de visuais prepara até quatro bibliotecas de avatar simultaneamente para alimentar a fila geral e aproveitar o cache existente. O formato e a política de cache, o carregador nativo de cada biblioteca e as rotas de erro do cliente são preservados.

## Reprodução

```sh
bash work/build_token75.sh
python work/regression_token75.py
python work/make_token_apk75.py
```

O build usa o SWF exato da Teste74 fornecido nos fontes. Para empacotar o APK, coloque o APK anterior em output e use o material de assinatura original. Os testes locais executam o bytecode salvo com transporte simulado. Ainda falta medir o carregamento em Android conectado ao hotel.
