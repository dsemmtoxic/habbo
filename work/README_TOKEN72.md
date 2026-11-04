# Habbo Teste72 / Base33

Atualização de 03/11/2026 sobre a Teste71. Android `2.32.37-t72-b33`, versionCode `2032171`, AIR `2.32.171`.

Na Teste71, a leitura dependia de chegar à ação de uso. O toque curto podia seguir só para caminhada ou seleção. O toque duplo também podia ser resolvido como caminhada, conforme a preferência de gestos. A Teste72 verifica o mobi atingido nos dois gestos e abre a leitura para presentes e troféus com dedicatória.

A referência foi o SWF do Habbo Air Plus fornecido com o projeto. No `FurniturePresentWidgetHandler`, o texto vem de `furniture_data`, o remetente vem de `furniture_purchaser_name` e a opção de desembrulhar depende do dono do próprio mobi. A Teste72 também aceita o mapa estruturado já usado pelo cliente e entrega as opções nativas de abertura ao dono identificado no modelo.

No `FurnitureTrophyWidgetHandler`, os dois primeiros separadores de tabulação dividem autor, data e dedicatória. A Teste71 encaminhava o evento do motor até a interface, que não o tratava. A Teste72 conecta esse evento à janela e aceita dedicatória sem separadores. A leitura é local. Abrir o conteúdo de um presente é uma ação explícita do dono.

Compile com `bash work/build_token72.sh` e valide com `python work/regression_token72.py`. O empacotamento em `work/make_token_apk72.py` usa o certificado da versão anterior. `VerifyApkToken61` verifica a assinatura e `work/package_token72.py` gera o ZIP de alterações com caminhos originais.

Os testes executam o bytecode dos gestos e dos pedidos de interface. Os candidatos do toque, a renderização do Android e o transporte do hotel são fronteiras de teste. O APK ainda precisa de teste em aparelho conectado ao hotel.
