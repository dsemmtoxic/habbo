# Teste63 — base33, somente token

Entrega de 02/11/2026. O usuário confirmou que o fundo colorido funciona no62; reprovou a porta, a parede esquerda e o login compacto. Esta rodada mantém a base33 e trata esses pontos, os editores de iluminação e as preferências permanentes.

## Alterações

- **Entrada e paredes:** restaurado o RoomPlaneParser completo do33, incluindo o guia de entrada usado na formação das paredes. A imagem `room_door_png` e o recorte do avatar são desativados no canvas3D pelo próprio caminho nativo de limpeza. O filtro da máscara da entrada continua limitado a `door` + ID `door_`. Coordenadas, altura, movimentação e máscaras de mobis/janelas permanecem nativas.
- **Toner:** “Usar” e o evento do widget abrem o editor. Matiz/HUE, saturação, luminosidade, hexadecimal e ON/OFF. A prévia acompanha os controles no quarto atual; Cancelar restaura os dados atuais do mobi, e Aplicar envia o compositor2059 original. Não recria o quarto ou seus objetos.
- **Reguladores de luz:** editor com três presets, controles de cor/hexadecimal, ON/OFF e opção “Somente piso e paredes”. O evento de estado passa a chegar à atualização nativa da cor do quarto. Paredes/piso3D recebem a transformação do material; imagens do quarto, mobis e avatares recebem a cor no modo completo. Camadas aditivas/screen luminosas preservadas. Os lotes gráficos são atualizados quando necessário, sem alterar alpha, visibilidade ou IDs dos objetos. Os compositores ausentes3237/905 e o payload2787 são compatíveis com a referência Plus; não há cabeçalhos inventados.
- **Login:** painel amplo, campo de token/Colar/Entrar, hotel e site, ícone de configurações no topo. Autenticação/validação originais33, token digitado, Enter e atalho de clipboard preservados. Janelas com moldura azul e cantos arredondados construídas com as texturas nativas; botões verdes/vermelhos do aplicativo.
- **Comandos permanentes:** switches para `:afk`, `:typing`, `:tradeblock`, `:mutebots`, `:mutepets` e `:friendhl`, acessíveis antes do login e pela engrenagem no quarto. Preferências em SharedObject; mudanças pelos comandos de chat também persistem. AFK/digitação/trocas/destaque usam o comportamento nativo existente, com o contexto atualizado entre quartos. Mutes filtram apenas falas das categorias bot/mascote; usuários humanos e desconhecidos continuam no chat.
- **Console e visibilidade:** preservados os recursos61 de datas/paginação, cache e correções imediatas de mobis/ocultadores33.

## Evidências e limites

Nove verificações em `work/feature63/validation63.json`: porta/geometria, login em oito dimensões (incluindo375×812), preferências/reconexão, editores/protocolo de iluminação, fundo/meshes/imagens, auditoria, console, regressões33 e vínculo2059. A prévia do Toner e o cancelamento são executados sem enviar pacote ou reentrar. Os switches são testados antes do login, após reset/reconexão e em uma nova instância simulada.

A auditoria preserva37632 métodos existentes62, revisa17 modificações limitadas e acrescenta sete acessores/pontes e três helpers. Console61 completo, autenticação e leitores existentes continuam equivalentes. Somente os dois vínculos de saída dos reguladores foram acrescentados; o rastreamento de paredes coincide com o33. Texturas originais foram inspecionadas para confirmar cantos arredondados, moldura e cores dos switches.

O harness executa AVM2 salvo. **Não houve execução em aparelho Android ou sessão real no hotel.** GPU/rasterização, fontes/medição Feathers, eventos/foco da plataforma, gravação real de preferências e rede são limites explícitos. É necessário confirmar a aparência e o comportamento no dispositivo.

APK: `Habbo_2.32.28_Teste63_Base33.apk`. Android2.32.28-t63-b33, versionCode2032162; AIR2.32.162. Assinaturas v1/v2 verificadas, sem avisos, com o certificado original33. A atualização pode ser instalada sobre62 com a mesma assinatura.

SHA256 APK: `79dd34343cb386133fe81871e441378c6e552fcc5d7360ecbe18aa551ca1ffed`.
SHA256 SWF: `f7f64f4549dc823b79de2152270919d6b26d99929ad7618b3ca4c47f704647bb`.

## Reprodução

O ZIP incremental63 é aplicado sobre os fontes62 e conserva `work/...`. Para um diretório vazio, use os fontes completos63. `Login62.as` e `RoomAppearance61.as` mantêm seus nomes de classe por compatibilidade, com a implementação63. Não execute os builds históricos para produzir esta entrega.

Requisitos: Java17+, Python3.9+, `cryptography`; ferramentas e bibliotecas AIR/Flash com hashes em `work/feature63/dependencies63.json`.

```sh
python3 work/setup_token63.py
bash work/build_token63.sh
python3 work/regression_token63.py
```

O build parte do SWF33 exato `de8dd00c53bd9ece24563558ce7a19ad6183e94bad2ec651c06fd20f46d3e901`. As referências33/61/62/Plus e o invólucro neutro estão no pacote completo. Os decompilados de pesquisa não são recompilados integralmente.

Restaure temporariamente a chave e o certificado originais em `work/fullscreen-signing-key.pem` e `work/fullscreen-signing-cert.der`. Depois:

```sh
python3 work/make_token_apk63.py
java -XX:-UsePerfData -m jdk.compiler/com.sun.tools.javac.Main -cp .task-tools/apksig61.jar -d work/classes work/VerifyApkToken61.java
java -XX:-UsePerfData -cp .task-tools/apksig61.jar:work/classes VerifyApkToken61 output/Habbo_2.32.28_Teste63_Base33.apk
```

Remova os arquivos de assinatura temporários. Eles não integram os ZIPs. `make_fullscreen.py` é usado somente como biblioteca de assinatura e o empacotador exige a identidade original; não gere outra chave.

O APK33 completo antigo não foi recuperado. O SWF33 é exato e o invólucro Android foi restaurado estruturalmente ao pré48, com2760 classes verificadas e sem callback de login automático. Origem em `inputs/base_token33.json` e `work/feature61/native33/restoration.json`.

## Confirmação no aparelho

1. Atualizar para63; conferir o login amplo, bordas, hotel/token/Enter e engrenagem.
2. Ativar/desativar preferências no login, entrar em um quarto, alterá-las pela engrenagem e por comando, trocar de quarto e fechar/reabrir o aplicativo.
3. Verificar a porta sem a imagem escura e ambas as paredes em quartos com entradas/orientações diferentes.
4. Abrir o Toner por Usar; arrastar HUE/saturação/luminosidade, digitar hex, cancelar, aplicar e alternar ON/OFF. Confirmar fundo ao entrar já ligado, após retorno à tela e sem mobis invisíveis.
5. Repetir nos reguladores: três presets, modo completo e somente piso/paredes, cancelamento, salvar e desligar. Conferir brilho de mobis luminosos.
6. Conferir console com mensagens reais, datas e carregamento de páginas antigas. A migração34–60 permanece suspensa.
