# Habbo Teste66 / Base33 — correção da abertura do login

Retorno real do usuário: a Teste65 ficava em Carregando após selecionar o país e não abria a tela de login. Esta entrega corrige essa regressão, preservando as alterações65. Android `2.32.31-t66-b33`, versionCode `2032165`, AIR `2.32.165`.

## Causa e correção

O método nativo `LoginScreen.initializeHandler` recebe o estado construído por `HabboTicketLogin.buildTokenLogin` e armazena os campos `title` e `instructions` nos slots `_‑0ya` e `_‑3Nt`. Ambos exigem o tipo `_‑2xS::_‑Fk`, a classe Label do cliente.

A65 substituiu esses campos por `starling.text.TextField` para desenhar os textos com contorno. Essa classe não é um Label. A atribuição lança TypeError1034 antes de concluir a inicialização e a transição normal da tela, deixando o carregamento visível.

A66 mantém as duas instâncias Label originais ocultas, com o mesmo tipo e ciclo de vida. A apresentação usa `login62.titleView` e `login62.instructionsView` separados, mantendo transparência, contorno e estilo novos. Somente `Login62.ensure` e `Login62.layout` mudam em relação à65. O dex nativo permanece byte a byte igual ao APK65.

## Verificação

- A execução do inicializador salvo da65, agora com validação de tipos dos slots nativos, reproduz1034 na atribuição do título.
- O mesmo teste sobre66 conclui `initializeHandler` e `onAddedToStage` em oito combinações: quatro tamanhos horizontais/verticais, com e sem perfil vinculado. As duas referências nativas permanecem Label. A transição para `loginScreen` esconde a tela de carregamento.
- Um probe local adicional executou as classes gráficas e o tema do cliente em Ruffle0.7.1/Chromium153. Um slot com o tipo Label exato do cliente rejeitou o TextField com1034 e aceitou Label. Isso confirma a incompatibilidade; não equivale a teste Android.
- Treze verificações locais incluem inicialização, login, luzes/salvamento, porta/malha/UV, console, comandos, renderização de fundo,2059 vínculos de cor, regressões33, script de sessão e roundtrip das2760 classes do dex principal.
- A auditoria compara65 com66:37843 métodos preservados, somente os dois métodos de apresentação acima alterados, sem alterações nos cabeçalhos de protocolo. Assinatura original APKv1/v2 verificada na entrega.

Os testes anteriores verificavam nomes de propriedades, mas não a coerção de classe dos slots nativos. `VerifyToken66` cobre essa lacuna e exige que a65 falhe antes de aceitar a66. A causa e as evidências estão em `work/feature66/startup-cause66.json`; resultados em `validation66.json` e logs associados.

## Reprodução

```bash
bash work/build_token66.sh
python work/regression_token66.py
python work/make_token_apk66.py
java -cp .task-tools/apksig61.jar:work/classes VerifyApkToken61 output/Habbo_2.32.31_Teste66_Base33.apk
python work/package_token66.py
```

O empacotador usa o portador Android33, o SWF66 e o dex65 já verificado. O material original de assinatura deve ser restaurado temporariamente nos caminhos usados por `make_fullscreen.py`; não é incluído nos pacotes. Não gerar outro certificado. Os nomes históricos dos helpers permanecem por compatibilidade; os comandos ativos desta entrega são os66.

O ZIP de alterações mantém os caminhos originais. Os fontes completos incluem as dependências Base33/65; o delta contém apenas os arquivos alterados ou novos desta correção.

## Teste no aparelho

Instalar66 sobre65, selecionar o país e conferir a abertura do login. Conferir também a reabertura com conta já vinculada e a aba Token. A assinatura e o identificador do aplicativo são preservados para atualizar a instalação existente.

Não houve execução no Android nem login com conta real nesta máquina. A validação visual da nova interface, sessão oficial, recorte da porta e fluidez do navegador continuam dependendo do aparelho. Toner/reguladores64 já foram confirmados funcionais pelo usuário e permanecem preservados. A migração nativa34–60 continua suspensa.
