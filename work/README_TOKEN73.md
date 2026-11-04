# Habbo 2.32.38 Teste73 Base33

O leitor de presentes usa um cartão claro com cabeçalho azul, aviso e assinatura do remetente. Presentes com o indicador de remetente confiável usado pelo Air Plus recebem a variante dourada e o aviso verde. A ilustração é um ícone fixo de embrulho.

O leitor de troféus usa a placa metálica da referência, com data à esquerda e autor à direita. No SWF do Habbo Air Plus, `FurnitureTrophyWidgetHandler` lê `furniture_color` e `TrophyFurniWidget` converte 1, 2 e 3 em ouro, prata e bronze, respectivamente. O cliente aplica as cores de fundo da lista `TrophyView.BG_COLOR_LIST`. O valor ausente ou fora da faixa usa a placa dourada, como no Air Plus.

A Teste72 comparava `furniture_owner_id` com o saldo de respeitos. A Teste73 compara com `sessionDataManager.userId`. O clique revalida o objeto e o quarto ativos. Abrir usa o compositor existente para o ID do presente. Retribuir abre o catálogo com o remetente selecionado. A variante da equipe tem somente Abrir, como na referência. Visitantes leem sem ações de dono.

Somente o toque duplo abre a mensagem. O toque longo passa pela seleção nativa e oferece movimento quando o jogador tem permissão. O toque simples continua seguindo o fluxo de caminhada ou seleção. O modo :dc preserva o uso automático nos outros mobis.

## Reprodução

```sh
bash work/build_token73.sh
python work/regression_token73.py
python work/make_token_apk73.py
java -XX:-UsePerfData -cp work/classes:.task-tools/apksig61.jar VerifyApkToken61 output/Habbo_2.32.38_Teste73_Base33.apk
```

A geração do APK exige o mesmo material privado de assinatura usado pela Teste72. A regressão testa os callbacks do cliente com transporte e renderização simulados. A confirmação da aparência e das transações em Android conectado ao hotel exige teste no aparelho.
