# Habbo Teste68 / Base33

Atualização de 02/11/2026 após o retorno real da 67. O usuário confirmou que o avatar ainda aparecia sobre a parede da entrada e pediu ajustes no login, traduções, textos compatíveis com a fonte, promoções do navegador e devolução de ofertas expiradas da feira livre.

Android `2.32.33-t68-b33`, versionCode `2032167`, AIR `2.32.167`. Jogo e autenticação continuam Base33. A migração nativa 34 a 60 permanece suspensa.

## Entrada do quarto

A 67 restaurou a classificação do avatar na camada nativa `RSC3D_DOOR`, mas isso não bastou: as paredes Away3D e os sprites Starling do avatar pertencem a composições separadas. A parede 3D não recorta automaticamente os pixels desses sprites.

A 68 projeta o próprio vão da malha, calculado a partir da máscara nativa da porta, em uma máscara de stencil Starling. As bordas acompanham a inclinação da parede, a orientação e o zoom. A máscara afeta somente a camada da entrada; ao caminhar para dentro, o avatar continua voltando à ordenação normal. Mobis e as outras camadas mantêm sua ordem nativa. A imagem escura da porta e o clip retangular antigo continuam desativados.

Projeções idênticas reutilizam a máscara. Parede oculta, máscara retirada, plano descartado e descarte do canvas liberam o estado correspondente. O buffer de stencil já está habilitado pela configuração original do Stage3DProxy.

## Login e idioma

A marca H e o nome Habbo do painel esquerdo ficam ocultos. A bandeira fica centralizada nessa área em telas largas e centralizada no topo em telas estreitas. A engrenagem do login fica no canto superior direito da tela, afastada das abas; a posição no jogo não muda.

Conta, ações do perfil, vinculação, troca de personagem, avisos de sessão e barra do navegador são traduzidos para os nove hotéis: português, inglês, alemão, francês, espanhol, italiano, holandês, finlandês e turco. O popup de preferências também acompanha o hotel. São 52 textos novos em nove idiomas, além dos textos já traduzidos da aba Token e das localizações existentes do cliente. O idioma é sincronizado tanto na seleção nativa quanto na apresentação do login.

Os campos Label nativos corrigidos na 66 continuam preservados. A head, proporções, serviço oficial de imagem, sessão persistente, verificações do site e autenticação da 67 permanecem. O script `session64.js` é idêntico ao da 67; as mudanças no WebView nesta entrega limitam-se aos textos da interface.

Os símbolos indicados pelo usuário são substituídos na apresentação de textos do aplicativo, avisos e localizações. A limpeza da localização ocorre depois das regras de plural e dos parâmetros, preservando sua sintaxe interna. As escolhas Wired que eram apenas um símbolo recebem um nome legível quando necessário. IDs, índices de opções, expressões regulares do programa, tokens e mensagens de rede não são alterados.

## Navegador de quartos e eventos

Quartos com amigos substitui Preferidos na aba superior. Preferidos passa para o menu lateral, logo abaixo de Categorias. As duas opções mantêm seus compositores originais distintos; seus textos acompanham o servidor.

Nas pesquisas de promoções novas e principais, a linha mostra o nome do evento recebido pelo servidor. Se ele estiver ausente, usa o nome do quarto. As pesquisas comuns continuam mostrando o nome do quarto, e o objeto mantém sua identidade e nome originais.

Na informação do quarto, abaixo da linha de negociação, usuários e nota, aparecem o nome do evento e o tempo restante. A contagem usa os minutos recebidos em GuestRoomData e também as atualizações/cancelamentos nativos de RoomEventData. Copiar ou reutilizar um renderer não reinicia a duração. O texto desaparece quando o evento termina ou é cancelado. O contador usa os frames da própria interface, atualiza no máximo uma vez por segundo e não faz novas requisições ao hotel.

Os campos correspondem a `roomAdName` e `roomAdExpiresInMin` do Air Plus fornecido nos fontes. O parser e os cabeçalhos de protocolo permanecem os mesmos; a 68 acrescenta apresentação e metadados de tempo após a leitura nativa.

## Feira livre

O botão Desistir é vinculado diretamente ao ID atual da oferta e à lógica nativa. Isso evita perder o pedido quando um renderer reciclado está sem referência ao dono da lista. O botão envia o compositor original de cancelamento, uma vez enquanto aguarda resposta. A oferta só é removida após confirmação do servidor. Falha permite tentar novamente; uma espera sem resposta libera a ação após dez segundos e atualiza a lista.

Devoluções confirmadas são lembradas por instância da lógica da feira. Uma resposta antiga de Minhas vendas não pode recolocar essas ofertas na lista. Contagem e interface são atualizadas ao filtrar uma resposta assim. Ofertas vendidas, status 2, continuam protegidas. Os cabeçalhos 92 e 1704 coincidem com o Air Plus fornecido.

Gerar Moedas deixa de aparecer e ocupar espaço no layout. A instrução traduzida informa para resgatar as moedas no menu H, em Lucros. Nenhum resgate ou compra é executado automaticamente.

## Verificação

Dezenove verificações locais incluem:

- Inicialização e duas abas do login em oito tamanhos e nove idiomas, com e sem perfil; tipos Label nativos preservados.
- 468 traduções, limpeza de símbolos e processamento nativo dos parâmetros.
- Criação do menu nativo e seleção das duas pesquisas do navegador com seus compositores distintos.
- Leitura de pacotes nativos de promoção, nomes, fallback, duração, cópia, expiração, atualização ao vivo, cancelamento e reciclagem.
- Projeção do vão nas duas paredes/orientações e em três níveis de zoom, recorte inclinado, cache e liberação de máscaras.
- Desistir sem referência à lista, ID exato, proteção contra duplicação, falha, nova tentativa, confirmação e rejeição de respostas antigas.
- Luzes e salvamento, malha/UV, console, saída/reabertura do login, configurações, fundo, 2059 vínculos de cor e demais regressões Base33.
- Auditoria estrita: 37811 métodos anteriores preservados, 35 alterações limitadas, 12 métodos adicionados e cinco helpers novos. Tabelas de protocolo inalteradas e offsets AVM2 válidos.
- Script de sessão da 67 com serviços simulados e verificação retida das 2760 classes do dex, cujo hash permanece igual ao da 67.

Esses testes executam o AVM2 salvo e fronteiras simuladas declaradas. Não são teste físico em Android nem transações reais do hotel. Fontes, medições reais, GPU/stencil, eventos do sistema, conta real e servidor precisam de confirmação no aparelho. Prints privados e material de assinatura ficam fora dos pacotes.

## Reprodução

```bash
python work/setup_token63.py
bash work/build_token68.sh
python work/regression_token68.py
python work/make_token_apk68.py
java -m jdk.compiler/com.sun.tools.javac.Main -cp .task-tools/apksig61.jar -d work/classes work/VerifyApkToken61.java
java -cp .task-tools/apksig61.jar:work/classes VerifyApkToken61 output/Habbo_2.32.33_Teste68_Base33.apk
python work/package_token68.py
```

Gerar o APK requer temporariamente a assinatura original nos caminhos usados pelo empacotador. Não gerar outra chave. Material privado não é distribuído. O pacote, permissões, fullscreen, dex e aceleração do navegador são mantidos.

Os comandos ativos são os 68. Os nomes históricos dos helpers continuam por compatibilidade. O ZIP de alterações mantém os caminhos originais e contém apenas arquivos novos ou modificados; os fontes completos incluem as dependências da linha Base33.

No aparelho, conferir a entrada nas duas orientações, idioma após alternar servidores, posição da engrenagem, evento com título diferente do quarto e tempo decrescente, e devolução de uma oferta expirada. As regressões de login, Sair, Toner/reguladores e console também devem continuar funcionais.
