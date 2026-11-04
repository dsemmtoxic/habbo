# Habbo Teste64 / Base33

Atualização de 02/11/2026 sobre a Teste63, usando o SWF33 exato. O protocolo e o mecanismo de autenticação do jogo continuam os da base33. A migração nativa34–60 permanece suspensa. O novo login no site foi solicitado expressamente nesta rodada e apenas fornece um código Launcher novo ao login33.

## Alterações

- **Entrada:** máscara original da porta restaurada em RoomLogic; piso, altura, coordenadas e guia de paredes originais mantidos. A imagem PNG escura e o clip do avatar continuam desativados no canvas3D. Restaurar o recorte e ocultar a sombra são operações independentes.
- **Toner:** corrigido o botão Aplicar sem callback causado pela variável local `save` com o mesmo nome da função. O botão agora chama explicitamente RoomLighting63.save. A prévia não altera o estado confirmado; o editor espera a atualização do modelo do quarto antes de fechar. Cancelar restaura o estado recebido. Timeout informa falta de confirmação e permite tentar novamente.
- **Regulador:** sete cores e intensidade76–255 iguais ao Air Plus20.9 (referência byte a byte). Mínimo aplicado também à prévia e ao payload, inclusive preto. Três presets, modo somente piso/paredes e modo completo; o modo completo mantém a integração com o fundo do quarto. Presets editados têm rascunhos separados do estado recebido. O pacote contém os sete campos nativos, com intensidade do tipo int. A resposta de presets consome o Boolean e o ID sem acessar propriedade inexistente do wrapper.
- **Console:** corpo da mensagem intacto; hora HH:mm em label menor e cor própria. Selo centralizado somente na primeira mensagem de cada dia: Hoje, Ontem ou dd/MM (com ano quando necessário). Reavalia agrupamento após paginação/reciclagem e mudança de dia. Paginação, deduplicação, cursores e estado de leitura anteriores preservados.
- **Login:** cartão centralizado de tamanho intermediário; moldura nativa ampliada de3 para7 unidades. Abas Conta/Token e engrenagem de preferências permanentes. A opção Token continua usando a validação e conexão33.
- **Conta pelo site:** WebView do sistema, site HTTPS oficial do hotel selecionado, login e2FA preenchidos pelo usuário no próprio site. O leitor reconhece o código Launcher e encaminha ao login33. Cada toque em Entrar abre a sessão do site e solicita/identifica um código atual; códigos anteriores não são guardados. Nome/figure do avatar são os únicos dados salvos pelo helper; a imagem da cabeça vem do serviço oficial. A tela informa “Sessão salva neste aparelho”, sem tratar o cache de avatar como confirmação de autenticação atual. Gerenciar conta abre o próprio site. Cookies e DOM storage ficam no perfil do WebView, com flush ao fechar. Sessão expirada pede nova autenticação no site.

## Validação e limites

Onze verificações locais em `work/feature64/validation64.json`: porta, iluminação, console, login em8 dimensões, preferências, renderização, auditoria, regressões33, vínculo2059, script do navegador e roundtrip das2760 classes Android. A falha do callback Aplicar foi reproduzida no SWF63. O teste64 invoca o listener realmente registrado no botão, com entrega do evento simulada; não chama diretamente uma função escolhida pelo teste.

A auditoria compara todos os métodos anteriores: somente três métodos existentes fora dos helpers mudam (máscara, decoração do console e ação do link no login); dois getters de leitura e o helper WebSession64 foram acrescentados. Todos os outros métodos de gameplay e as tabelas de protocolo ficam preservados. No Android, somente o construtor e destroyInternals de AndroidWebView mudam; classes2.dex/classes3.dex são mantidos byte a byte.

**Não houve execução em Android/GPU nem login em conta real.** O site oficial bloqueou a inspeção anônima automatizada. O leitor tem fallback para o código/links apresentados pelo próprio site, mas os seletores e endpoints da sessão atual,2FA, cookies após reinício, rasterização de porta/bordas e confirmação real do servidor precisam ser testados no aparelho. As verificações usam primitivas explícitas para rede, eventos, fontes, GPU e armazenamento. Não comprovam esses limites físicos.

## Reprodução

Requisitos: Java17+, Python3.9+, Node e cryptography. Ferramentas públicas pinadas no manifesto63.

```sh
python3 work/setup_token63.py
bash work/build_token64.sh
python3 work/build_native64.py
python3 work/check_native64.py > work/feature64/test-native.log
python3 work/regression_token64.py
```

Restaure temporariamente a chave e certificado originais nos caminhos usados pelo empacotador. Eles não estão nos fontes nem no ZIP de alterações. Execute `python3 work/make_token_apk64.py` e verifique a assinatura usando VerifyApkToken61 com apksig61.jar. Não gere uma chave nova. Remova os arquivos temporários da assinatura ao terminar.

Android2.32.29-t64-b33, versionCode2032163; AIR2.32.163. APK `Habbo_2.32.29_Teste64_Base33.apk`. Certificado original33, atualização sobre63. Hashes e validação da assinatura em `work/feature64/release64.json`.

## Roteiro no aparelho

1. Instalar sobre63. Conferir tamanho do cartão, moldura, abas, seletor de hotel e engrenagem.
2. Conferir recorte da porta sem sombra em entradas90/180 e ambos os lados das paredes; testar mobis/janelas com máscaras e piso isolado.
3. No Toner, mudar HUE/saturação/luminosidade ou hexadecimal, tocar Aplicar e aguardar fechar. Reabrir o editor, sair/reentrar no quarto e reiniciar o app para confirmar o valor recebido. Testar Cancelar e ON/OFF.
4. No regulador, selecionar cor/intensidade nos três presets, aplicar e confirmar após reentrada; repetir modo completo, somente piso/paredes e OFF/ON. Conferir fundo, mobis luminosos e brilho mínimo.
5. No console, conferir horas pequenas, selo único por dia e mensagens antigas ao paginar; enviar/receber mensagens de tamanhos diferentes.
6. Em Conta, tocar Entrar na conta; preencher e-mail/senha/2FA no site. Se o site não abrir automaticamente o Launcher, tocar Jogar no próprio site. Confirmar entrada, nome/head; fechar/reabrir o app e tocar Entrar novamente. Testar sessão expirada, Gerenciar conta e hotéis diferentes. Token manual permanece disponível.
