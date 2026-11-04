# Habbo 2.32.39 Teste74 Base33

O cartão de presente renderiza a cabeça a partir do campo PURCHASER_FIGURE, ou de furniture_purchaser_figure no modelo legado. Esse dado representa o visual registrado no envio. O renderizador nativo aguarda as peças do avatar e usa o recorte de cabeça. Se o presente não tiver o visual registrado, o espaço fica vazio.

O duplo toque, a escolha explícita na lista de mobis e o botão Usar abrem a mensagem de presentes e troféus. A lista continua chamando o fluxo nativo de seleção e movimento. Para visitantes, o menu de leitura oferece Usar sem iniciar movimento.

O Cadeado da Amizade mantém a arte do cliente e usa as posições e caixas da referência lovelock_engraving_xml do Air Plus. Os avatares de corpo inteiro usam direções 2 e 4 e são centralizados em caixas de 70 por 115. A arte, os nomes e a data ficam no mesmo painel.

## Reprodução

```sh
bash work/build_token74.sh
python work/regression_token74.py
python work/make_token_apk74.py
java -XX:-UsePerfData -cp work/classes:.task-tools/apksig61.jar VerifyApkToken61 output/Habbo_2.32.39_Teste74_Base33.apk
```

A geração do APK exige o certificado e a chave privada originais. Os testes locais exercitam o AVM2 salvo com simulação de transporte, avatar e renderização. A validação visual e de interação em Android conectado ao hotel exige teste no aparelho.
