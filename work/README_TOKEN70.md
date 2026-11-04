# Habbo Teste70 / Base33

Atualização de 03/11/2026. Android `2.32.35-t70-b33`, versionCode `2032169`, AIR `2.32.169`. Usa a Base33 exata e o certificado original para atualizar a instalação anterior.

## Estilos de balões

O botão nativo abre uma janela modal maior, centralizada e limitada à tela. As opções formam uma grade com rolagem vertical. A janela usa a lista já filtrada pelo cliente: estilos bloqueados, restritos ou destinados apenas a mensagens recebidas não são liberados por esta mudança. As imagens mantêm a proporção original.

O estilo atual fica destacado em verde. Tocar nele confirma sem mudar a escolha e fecha a janela; tocar em outro aplica a seleção nativa e fecha. O X fecha preservando a seleção. O fundo modal não fecha por toque externo. Redimensionamento ajusta a grade; descarte do chat e saída limpam a janela e seus listeners.

## Histórico do chat

Cada mensagem ganha uma coluna à esquerda, com data e horário local do aparelho. Data fica acima da hora, em tamanho menor e cor clara distinta, sem alterar autor ou corpo da mensagem. A data é fixada quando o ChatItem nativo é construído, usando o relógio do aparelho e o atraso indicado por getTimer. Abrir o histórico depois não transforma o horário antigo em horário atual. Mensagens de outro ano incluem o ano.

A coluna acompanha a reciclagem do renderer, o texto continua com quebra automática na largura restante e o descarte mantém a chamada à implementação nativa de Feathers. Esse histórico do quarto não recebe um horário oficial do servidor: mostra o momento de recebimento neste cliente.

## Eventos do quarto

Mantida a linha ampliada da Teste69, com Evento em UbuntuBold. A coluna da direita mostra somente a duração, por exemplo `01h59min`, sem o texto Tempo restante. O espaço liberado passa ao nome do evento. Prazo, cancelamentos e identidade do quarto continuam nativos.

## Emblemas do perfil

O perfil próprio solicita o inventário de emblemas, que antes podia continuar vazio até abrir outra área. GetBadges usa o cabeçalho de saída 1505 conferido no Air Plus fornecido. O parser nativo de BadgesEvent monta os fragmentos; o carregamento aceita fragmentos fora de ordem e ignora repetições na contagem. A seleção espera a lista completa; ausência de emblemas ou falha de carregamento gera aviso traduzido e permite tentar novamente.

Toques na imagem interna agora usam o slot que recebeu o evento. Slots vazios, inclusive com código vazio, abrem a seleção no perfil próprio. O salvamento já existente era marcado como pendente depois de fechar a janela: a notificação de fechamento podia acontecer antes e não enviar nada. A marcação passa a ocorrer antes do fechamento. O compositor original salva os cinco slots. Perfis de outras contas continuam sem edição. Listeners e pedidos pendentes são liberados na saída.

## Comando :dc

Adicionado ao painel de preferências como Usar mobis com um toque e aceito ao digitar `:dc`. O comando alterna a opção, que é salva no aparelho.

Quando ativo, um toque único curto usa o primeiro mobi atingido pelo teste nativo de seleção, sem exigir toque longo. O fluxo de uso continua passando por RoomDesktop e pelas permissões e lógicas do mobi. Avatares são ignorados. O limite do gesto de toque passa de 1500 ms para 250 ms, anterior ao início do toque longo nativo, em 300 ms; assim, segurar para abrir a seleção não dispara também um uso. Desativar restaura o limite original. O caminho nativo de toque longo não recebeu o hook de uso automático.

## Mensagens de presentes para visitantes

O bloqueio geral de RoomDesktop impedia visitantes de chegar à lógica dos presentes. Para presentes, o visitante agora pode abrir uma janela de leitura usando MESSAGE e PURCHASER_NAME já presentes nos dados do mobi, com fallback para o formato antigo de texto. A janela mostra mensagem e remetente e tem rolagem e X. Nenhuma chamada de abrir, receber ou devolver o conteúdo é enviada ao servidor por essa leitura.

Dono, controlador e administrador continuam no fluxo nativo do presente. As permissões de outros mobis permanecem intactas.

## Reprodução e validação

1. `bash work/build_token70.sh` recompõe o SWF a partir da Base33 exata.
2. `python work/regression_token70.py` executa 27 verificações de AVM2, JavaScript e integridade nativa.
3. Restaurar privadamente o material original de assinatura e executar `python work/make_token_apk70.py`.
4. `VerifyApkToken61` verifica v1/v2 e certificado. `python work/package_token70.py` gera fontes completas e ZIP somente com arquivos novos ou alterados, preservando caminhos.

Os testes exercitam os métodos salvos, parsers, callbacks e comandos nativos. Medição de fontes/layout, rasterização Android/GPU, entrega de eventos do sistema e transporte real do hotel são fronteiras explícitas. As seis resoluções do seletor são verificações geométricas, não capturas de um Android. O relatório das 2760 classes do DEX é retido e seu hash conferido, pois os três DEX permanecem idênticos à Teste69.

Não houve teste físico Android, acesso a uma conta real, edição real de emblemas ou uso de mobis em hotel real. Login, sessão do navegador, saída e reentrada, entrada do quarto, console, Minhas vendas e iluminação conservam os comportamentos anteriores. A migração nativa 34 a 60 continua suspensa. Material de assinatura, dados de conta e capturas do usuário não acompanham os pacotes.
