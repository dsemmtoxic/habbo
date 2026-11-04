# Habbo Teste71 / Base33

Atualização de 03/11/2026 sobre a Teste70. Android `2.32.36-t71-b33`, versionCode `2032170`, AIR `2.32.170`.

Na Teste70, o gesto curto com :dc consumia o toque assim que encontrava um mobi, mesmo quando o uso não fazia nada. Agora o toque primeiro passa pelo mesmo cálculo de movimento da caminhada nativa, usando uma cópia da coordenada do gesto, e depois solicita um único uso do mobi. O cliente usa a rota nativa de uso para pisos, portas de sentido único e demais mobis. O hotel continua decidindo quais destinos são alcançáveis e quais ações são aceitas. O seletor de construção e colocação conserva sua prioridade. O toque longo não aciona :dc, e a opção desativada usa a rota original.

Digitar :dc confirma com “:dc ativado.” ou “:dc desativado.” em um balão local do próprio avatar, sem mandar a confirmação ao hotel. O comando permanece salvo no aparelho. As mensagens têm tradução para os nove hotéis.

A solicitação RETWE_REQUEST_PRESENT era emitida pelo motor e chegava à interface, mas o RoomDesktop não a tratava. A Teste71 encaminha o pedido do quarto atual, o evento direto, a seleção e a ação de usar para o fluxo de presentes. A leitura usa o mapa nativo e, quando necessário, os campos de texto legados. Visitantes recebem uma janela de leitura com remetente e mensagem, sem envio de ação para abrir ou resgatar o presente. Donos, controladores e administradores recebem o diálogo nativo, com o ID correto do mobi; abrir o conteúdo ainda requer a ação explícita no diálogo.

Reprodução: `bash work/build_token71.sh` compila o SWF sobre Base33; `python work/regression_token71.py` valida a compilação e compara os caminhos problemáticos com a Teste70. `python work/make_token_apk71.py` empacota com o certificado original, usando a chave restaurada privadamente. `VerifyApkToken61` valida a assinatura. `python work/package_token71.py` gera fontes completas e ZIP apenas com arquivos novos ou alterados, preservando caminhos.

Os testes executam o bytecode salvo e verificam o compositor de caminhada, o balão privado e os pontos de entrada dos presentes. Projeção de toque, renderização de interface e servidor são fronteiras de teste. Sem teste físico no Android ou em hotel real. Os três DEX foram mantidos; a assinatura e as tabelas do protocolo não mudaram.
