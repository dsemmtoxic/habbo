# Teste61 — base Teste33, login por token

Atualização de 01/11/2026. O número61 identifica esta entrega; o jogo foi reconstruído a partir do SWF exato do Teste33. As versões34–60 de login automático/adaptador nativo foram retiradas da base ativa por solicitação do usuário.

## Comportamento desta entrega

- A entrada do quarto usa o piso normal, sem a superfície especial que mantinha a sombra. As coordenadas, máscaras de parede e o movimento da porta continuam no caminho original do Teste33.
- O console apresenta `dd/MM/aaaa HH:mm` junto às mensagens enviadas e recebidas. A data vem do tempo decorrido informado no pacote e do relógio local do aparelho; o texto original não é alterado. Mensagens sem data válida não recebem uma data inventada.
- O histórico do console carrega páginas sem requisições simultâneas, reduz a espera entre páginas e preenche automaticamente listas curtas com até duas páginas adicionais. Há uma repetição limitada no primeiro timeout. Os leitores, IDs, deduplicação, mensagens não lidas e posição de rolagem são preservados.
- O Toner de fundo abre a configuração de Matiz, Saturação e Luminosidade (0–255), com amostra da cor, Aplicar e Ligar/Desligar. Exige controle do quarto e fecha se o objeto, quarto ou direito mudar.
- O fundo acompanha a atualização do Toner recebida do servidor no próximo quadro, incluindo desligar/religar, no mesmo quarto e na mesma View3D. A configuração é enviada pelo compositor nativo; não depende de reentrar. A amostra acompanha a edição dos valores; a cor do quarto acompanha a configuração efetivada pelo servidor.
- Os controles de ocultação, atualização imediata da visibilidade dos mobis, geometria e cache de avatares do Teste33 são preservados.

## Estado e limites

As três solicitações estão implementadas e o APK está gerado e assinado com o mesmo certificado das versões anteriores. Quatro suítes locais passaram, além da assinatura v1/v2. Falta confirmar no Android real: aparência da entrada; console com mensagens reais e datas; Toner configurado, desligado e religado no mesmo quarto, mantendo os mobis visíveis. GPU/Android, medição visual Feathers, eventos da plataforma e servidor real são limites explícitos dos testes locais.

A migração nativa e as pendências34–60 permanecem suspensas. A antiga porcentagem e os256 itens daquela migração não representam o progresso desta entrega. Não atribuir porcentagem ao projeto inteiro sem novo escopo e confirmação dos testes no aparelho.

## Origem da base

O SWF33 original foi recuperado e verificado pelo SHA256 `de8dd00c53bd9ece24563558ce7a19ad6183e94bad2ec651c06fd20f46d3e901`. O APK33 completo antigo não estava disponível. O invólucro Android foi restaurado ao código anterior ao callback48 a partir do fonte retido: somente o construtor documentado de AndroidWebView e as duas classes do callback posterior foram removidos. As2760 classes resultantes foram remontadas, decompiladas e comparadas; o DEX não contém esse callback. Os recursos, bibliotecas, permissões e fullscreen foram preservados.

`inputs/Habbo_Android_BaseToken33.zip` é esse invólucro Android sem assinatura e sem o jogo SWF; não é um APK instalável. Seu manifesto de origem fica em `inputs/base_token33.json`. O jogo instalado é exclusivamente o SWF33 com as14 alterações revisadas e os dois helpers desta entrega. A auditoria conservou37618 métodos existentes.

## Arquivos e reprodução

O ZIP completo contém todos os fontes Java necessários à compilação61, os dois helpers ActionScript, SWFs de referência24/32/33/Plus, SWF61 final, invólucro Android neutro e evidências. Os arquivos Java antigos incluídos são dependências dos utilitários de compilação/verificação; seus comandos antigos não são o fluxo de geração61. Os fontes decompilados de `feature61/research/baseline33` são referências obtidas novamente do SWF33, sem copiar os helpers posteriores de login automático.

O ZIP de alterações mantém os caminhos `work/...` e contém os arquivos novos/modificados desta entrega e o SWF final. Ele não duplica referências, invólucro Android e dependências antigas. Para reconstrução isolada, use o ZIP completo. As chaves privadas não integram nenhum pacote.

Requisitos: Linux ou ambiente com classpath `:`, Java17 ou superior, Python3.9 ou superior e pacote Python `cryptography`. As ferramentas públicas são FFDec26.4.0, Apktool3.0.3 e apksig8.10.1. Seus URLs oficiais e hashes estão em `work/feature61/dependencies61.json`.

Na raiz extraída:

```sh
python3 work/setup_token61.py
bash work/build_token61.sh
python3 work/regression_token61.py
```

O primeiro comando baixa e verifica as ferramentas públicas. `python3 work/setup_token61.py --check` apenas valida uma instalação existente. O build recusa um SWF33 com hash diferente e acrescenta os dois helpers, sem recompilar o login original inteiro. As verificações executam os métodos AVM2 salvos, preservação de corpos/máscaras/leitores/tabelas, carregamento e datas do console, envio nativo do Toner e a limpeza de cor do Stage3DProxy no quadro real. As primitivas de relógio, timers, GPU e eventos da plataforma são substituições explícitas do harness; os testes não representam uma sessão Android real.

Depois de restaurar temporariamente a chave e o certificado originais nos caminhos `work/fullscreen-signing-key.pem` e `work/fullscreen-signing-cert.der`, execute:

```sh
python3 work/make_token_apk61.py
java -XX:-UsePerfData -m jdk.compiler/com.sun.tools.javac.Main -cp .task-tools/apksig61.jar -d work/classes work/VerifyApkToken61.java
java -XX:-UsePerfData -cp .task-tools/apksig61.jar:work/classes VerifyApkToken61 output/Habbo_2.32.26_Teste61_Base33.apk
```

O empacotador exige o certificado original e o hash do SWF aprovado pelas suítes. Não gere outra chave. Ele também aceita como argumento o APK33 original exato, SHA256 `ee3e24588c73c28dd9f687ffa411dd309156508eed5a75c49d4d8f28f39e20ee`, em lugar do invólucro neutro. Apague os arquivos temporários da assinatura após concluir. O utilitário herdado `make_fullscreen.py` é importado apenas para empacotar/assinar; não execute seu comando legado para produzir esta versão.

Android: `2.32.26-t61-b33`, versionCode2032160; AIR: `2.32.160`. O versionCode sobe para permitir atualização das instalações recentes com a mesma assinatura. A nova versão numérica não significa reaproveitar o login automático.

APK entregue: `Habbo_2.32.26_Teste61_Base33.apk`,32613075 bytes, SHA256 `3b0a37f5d47035c5d1ea7aaefc8c80cae5a4d00b4cfc595a1ef2c7b84f46091d`.

As evidências de validação e empacotamento estão em `work/feature61/validation61.json`, `release61.json` e logs das quatro suítes/assinatura. Os scripts `restore_token_android61.py` e `check_token_android61.py` registram a reconstrução histórica do invólucro; a reprodução normal utiliza o invólucro pronto incluído, pois aqueles scripts exigem o antigo arquivo completo60 e suas pastas de decompilação.
