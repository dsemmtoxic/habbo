# Habbo Teste69 / Base33

Atualização de 02/11/2026, após o retorno sobre a Teste68. Android `2.32.34-t69-b33`, versionCode `2032168`, AIR `2.32.168`. Mantém a Base33 e o certificado original para atualização sobre a versão anterior.

## Eventos do quarto

O nome e o tempo passam a ocupar uma única linha com toda a largura do painel, abaixo das estatísticas. O prefixo Evento usa UbuntuBold; o nome e o tempo usam Ubuntu. O tamanho acompanha a escala nativa da interface e aumenta em relação ao texto anterior. Há espaço reservado no pager para a linha ficar dentro do recorte do renderer.

Formato do tempo: `01h59min`. Os segundos são descartados, sem arredondar para a próxima hora. O nome ocupa o espaço entre o prefixo e o tempo, preservando o horário à direita. Nomes extensos ficam limitados à largura disponível. A contagem mantém os dados nativos de GuestRoomData e RoomEventData, sem novas consultas ao hotel e sem estender a duração ao copiar ou reciclar a linha. Eventos encerrados ou cancelados desaparecem.

## Minhas vendas

A categoria mostra apenas ofertas com status ativo e prazo informado não negativo. Expiradas, vendidas e ofertas sem prazo válido saem do modelo usado pela lista; a contagem também é corrigida. O filtro roda antes da montagem da lista, após respostas do servidor e, com o painel aberto, verifica a expiração uma vez por segundo. O prazo local é aproximado pelos minutos informados pelo hotel. Status ativo com zero minutos ainda é tratado como o último minuto válido, como no renderer nativo; seu botão Retirar permanece.

Retirar permanece nas ofertas válidas, vinculado ao ID atual, com bloqueio de envio duplicado enquanto aguarda a confirmação. Falhas permitem tentar novamente. Um botão reciclado que ainda referencie uma oferta expirada não pode reativar seu prazo. Devoluções confirmadas continuam protegidas contra respostas antigas que recolocariam a oferta na lista.

Essa limpeza é da categoria apresentada. Não cancela ofertas expiradas no servidor nem move itens para o inventário. O saldo disponível em Lucros não muda. O botão Gerar Moedas continua removido, e a orientação para resgatar pelo menu H, em Lucros, permanece traduzida.

## Regulador e fundo

Conferido no Air Plus fornecido com o projeto: o XML de `room_view_container` monta primeiro `background_wrapper`, depois `room_canvas_wrapper` e, por último, `colorizer_wrapper`. Esse último recebe um Sprite com `blendMode = multiply` em RoomDesktop. Portanto, o filtro global também colore o fundo do Toner. A opção restrita ao fundo/paredes atua nas superfícies do quarto, sem aplicar esse filtro global ao fundo externo.

O comportamento já existente em RoomLighting63 foi mantido. Salvar Toner, presets, limite de escuro e preenchimento dos botões de cores continuam iguais à versão funcional anterior.

## Ping

`:ping` envia o pedido nativo LatencyPingRequestMessageComposer e, ao receber a resposta correspondente, calcula o tempo de ida e volta usando getTimer. O resultado entra no fluxo local RoomSessionChatEvent com o índice do próprio avatar, criando um balão visível apenas nesse cliente.

`:pingsay` mede da mesma forma e passa o resultado ao método nativo de fala da RoomSession, para o hotel distribuir a mensagem. Exibição: `Ping: 083`; valores maiores que 999 não são cortados. O sufixo ms não foi acrescentado, conforme o formato solicitado.

As medições têm IDs próprios e não alteram as amostras periódicas do rastreador nativo. Respostas duplicadas, atrasadas ou de uma sessão já encerrada não publicam mensagens. Após dez segundos sem resposta, aparece somente um aviso local traduzido, sem inventar um ping nem publicar o erro. Sair limpa pedidos pendentes.

## Toques e Clicar

O caminho nativo de toque único retira os avatares da seleção. O caminho usado para tocar no piso também ignora a categoria de avatar antes de selecionar ou enviar LookTo, evitando a rotação provocada pelos pés. Seleção de mobis e caminhada continuam nativas. O toque longo conserva os avatares, rótulos e menu nativos. A preferência alternativa que antes usava o toque longo para caminhar também passa a abrir a seleção quando há um avatar sob o toque; mobis e áreas vazias conservam seu fluxo.

O menu do outro personagem ganha Clicar imediatamente acima de Negociar. A ação resolve novamente o usuário da conta para o índice atual do avatar no quarto. Se ele já saiu, nenhuma ação é enviada. Para um alvo válido, envia o mesmo ClickCharacterComposer do Air Plus, cabeçalho 2515 e um inteiro contendo o índice do avatar, seguido do LookTo nativo para sua posição. Isso usa a chamada de clique em personagem que o hotel recebe para o ativador Wired de clique em usuário.

O novo compositor implementa a interface nativa e é registrado apenas para o registro de mensagens do Habbo. Nenhum cabeçalho anterior foi remapeado; compra, troca, inventário e outras mensagens mantêm seus compositores. Clicar é traduzido para os nove hotéis.

## Reprodução e limites

1. `bash work/build_token69.sh` recompõe o SWF a partir da Base33 exata e dos helpers atuais.
2. `python work/regression_token69.py` executa os testes sobre o AVM2 salvo.
3. Com o material original de assinatura restaurado privadamente, `python work/make_token_apk69.py` empacota e assina. O material privado não acompanha os pacotes de fontes ou alterações.
4. `VerifyApkToken61` valida as assinaturas v1/v2 e o fingerprint original. `python work/package_token69.py` gera os arquivos completos e o delta com hashes e caminhos originais.

Os testes executam os parsers, comandos, callbacks e trechos nativos alterados. Fontes/medição de texto, eventos do sistema, transporte do hotel e rasterização GPU/Android são fronteiras explícitas. A aprovação local não substitui a confirmação no aparelho. Não houve acesso a uma conta real, venda, retirada de item, resgate de moedas ou execução Wired em hotel real durante a validação.

O login, a sessão persistente, a saída e reentrada, a máscara inclinada da porta e os horários do console foram preservados. O DEX nativo é idêntico à versão anterior. A migração nativa das versões 34 a 60 continua suspensa.
