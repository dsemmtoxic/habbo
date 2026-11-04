# Teste62 — base33, login por token

Entrega de01/11/2026 (horário do usuário). O usuário testou o61 e confirmou que a porta e o fundo preto persistiam. Esta entrega corrige o caminho visual que faltava e reformula a tela de login. A base permanece o SWF33 original; login automático/adaptador34–60 continuam suspensos.

## Alterações

- **Porta:** o piso especial da entrada já havia sido normalizado no61. Agora RoomLogic também ignora o recorte visual cujo tipo é `door` e cujo ID começa com `door_`, o identificador criado pela entrada nativa. Janelas e máscaras pertencentes a mobis continuam no caminho original. Coordenadas, altura e movimentação da entrada não são removidas do motor do quarto.
- **Toner:** o61 alterava a limpeza do Stage3D e a cor de View3D, mas o Core desenhava outro fundo opaco depois. O MainViewManager ainda recolocava a cor escura791578 ao entrar/voltar ao quarto. O62 acessa o renderizador real por `habboUI.context.root`, aplica a cor ao seu desenho e a reaplica depois da transição para a tela do quarto. Não recria o quarto, a View3D ou os objetos.
- O estado de um Toner já ligado é guardado se chegar antes do desktop. Eventos atrasados de outro quarto não repintam o atual. Configuração recebida, desligar/religar, retorno à tela do quarto e recuperação do contexto gráfico mantêm a cor. Cores idênticas não descartam novamente os buffers do fundo. Ao sair, a configuração anterior do fundo é restaurada.
- O editor HSL e o envio nativo do Toner são mantidos: a amostra acompanha a edição; o fundo acompanha a configuração efetivada pelo servidor. Alterar um valor e tocar em Aplicar continua sendo o fluxo de salvamento.
- **Login:** cartão central escuro, destaque amarelo, campo de token visível e mascarado, botão Colar ao lado, Entrar como ação principal, hotel/bandeira compactos e acesso ao site como ação secundária. Há textos para os nove hotéis já suportados. O token digitado tem preferência sobre a área de transferência; Enter usa a mesma autenticação do33. O atalho de entrar com campo vazio e token copiado foi preservado. Não há leitura da área de transferência ao abrir a tela.
- **Console e mobis:** datas/paginação do61 e as atualizações imediatas de visibilidade, controles de ocultação e cache do33 são preservados.

## Verificação e limites

Seis suítes aprovadas, com recibos em `work/feature62/validation62.json`:

1. `VerifyAppearance62`: reproduz o fundo escuro do61; executa context.root, troca de modo nativa, Core, dados inteiros/RoomObjectModel/Toner/handlers e o upload dos vértices do fundo. Cinco cores, off/on, estado inicial, retorno ao quarto, contexto recuperado, reutilização dos buffers, evento de quarto antigo e porta versus janela/mobi verificados.
2. `VerifyLogin62`: inicialização real da tela em sete dimensões, campo mascarado/Colar/Enter, nove hotéis, redimensionamento e descarte. Executa a validação e o envio de token originais até a fronteira de autenticação simulada.
3. `AuditToken62`:37612 métodos33 preservados,20 alterações limitadas, três helpers e dois acessores somente de leitura. Também compara ao61, incluindo preservação integral de Console61, validação/autenticação do token e demais métodos de jogo.
4. `VerifyConsole62`: texto original, datas estáveis, histórico, cursores, deduplicação, não lidas, rolagem e repetição limitada.
5. `VerifyRetained33`: ocultadores/controlador, cache, piso recortado, visibilidade imediata e marketplace.
6. `VerifyColorBindings61`: compositor nativo do Toner registrado no cabeçalho2059.

O harness executa AVM2 salvo. GPU/compilação AGAL, eventos da plataforma, ativação dos widgets auxiliares, medição/rasterização Feathers, teclado/clipboard, relógio e rede real são fronteiras explícitas. O suporte de `is Number` do harness foi corrigido para aceitar os valores inteiros usados por RoomObjectModel; isso não modifica o jogo. **Não houve execução em aparelho Android nem sessão no hotel real.** Falta confirmar a aparência da porta/fundo e do novo login no dispositivo do usuário.

APK: `Habbo_2.32.27_Teste62_Base33.apk`.
Android:2.32.27-t62-b33, versionCode2032161; AIR2.32.161. Mesma assinatura original33, v1/v2 verificadas e sem avisos. O versionCode maior permite atualizar o61 sem trocar o certificado.
SHA256 APK: `0bb2eca5d56a6b0598d0de075a3cae1e1b4cf9cd33ad81c12d2ec1edba1f52f7`.
SHA256 SWF: `1821987ac87dfa5d9948ee5316b0f2ab270ec04630017a18a1f4db9130748585`.

## Reprodução

O ZIP de alterações62 é incremental sobre os fontes61 e mantém os caminhos originais `work/...`; `RoomAppearance61.as` conserva o nome de classe usado pela versão anterior, com a implementação62. Para reconstrução isolada use os fontes completos62. Não execute os comandos históricos de geração61 para produzir esta entrega.

Requisitos: Java17+, Python3.9+, `cryptography` e classpath Linux `:`. Ferramentas públicas, bibliotecas Flash/AIR e hashes estão em `work/feature62/dependencies62.json`. As bibliotecas `flashlib/airglobal.swc` e `playerglobal32_0.swc` são necessárias para compilar ActionScript, além do JAR e das dependências FFDec.

```sh
python3 work/setup_token62.py
bash work/build_token62.sh
python3 work/regression_token62.py
```

O build parte do SWF33 exato SHA256 `de8dd00c53bd9ece24563558ce7a19ad6183e94bad2ec651c06fd20f46d3e901`, compila os três helpers e instala os hooks. As referências24/32/33/61/Plus e o invólucro Android neutro estão nos fontes completos. Os decompilados de `feature61/research` e `feature62/research*` servem de referência; não são recompilados integralmente.

Restaure temporariamente a chave e o certificado originais nos caminhos `work/fullscreen-signing-key.pem` e `work/fullscreen-signing-cert.der`. Depois:

```sh
python3 work/make_token_apk62.py
java -XX:-UsePerfData -m jdk.compiler/com.sun.tools.javac.Main -cp .task-tools/apksig61.jar -d work/classes work/VerifyApkToken61.java
java -XX:-UsePerfData -cp .task-tools/apksig61.jar:work/classes VerifyApkToken61 output/Habbo_2.32.27_Teste62_Base33.apk
```

O empacotador exige o certificado original e o hash aprovado pelas suítes; não gere outra chave. Remova os arquivos temporários de assinatura depois. Chaves privadas não integram nenhum pacote. `make_fullscreen.py` é importado como biblioteca de assinatura; seu comando legado não é o fluxo62.

O invólucro `inputs/Habbo_Android_BaseToken33.zip` não contém jogo nem assinatura e não é instalável. O APK33 completo antigo não foi recuperado; o SWF33 foi recuperado exatamente e o invólucro nativo foi restaurado estruturalmente ao pré48, com2760 classes verificadas e sem o callback de login automático. Os registros de origem permanecem em `inputs/base_token33.json` e `work/feature61/native33/restoration.json`.
