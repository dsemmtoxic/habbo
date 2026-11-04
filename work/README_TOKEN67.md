# Habbo Teste67 / Base33

Correções após o retorno real sobre66: o navegador permanecia aberto depois do login, Sair no H deixava o carregamento infinito, o personagem na entrada aparecia à frente das paredes/mobis e o horário do console ficava baixo e sem contraste.

Android `2.32.32-t67-b33`, versionCode `2032166`, AIR `2.32.166`. Autenticação e jogo permanecem Base33. A migração nativa34–60 continua suspensa.

## Sessão do site

A66 bloqueava o reconhecimento enquanto `Session.user.force.length` não fosse zero. Esse campo não é um indicador confiável de autenticação concluída: o site pode conservar valores residuais que não representam uma verificação pendente. O script67 reconhece `Session.user` e o evento `securityLogin` do próprio site. O serviço oficial `security.login` só chama `Session.create` depois de concluir sua promessa de verificações.

O script observa a promessa original de `useForce.handleForces` sem alterar seus resultados ou implementar os formulários. Enquanto uma verificação real está aberta, não fecha o navegador nem pede outro ticket. Quando conclui, retoma o fluxo. Cancelar mantém o navegador aberto e não provoca tentativas contínuas. Na vinculação, uma sessão já autenticada fecha a janela e atualiza o perfil, independentemente de o site ter solicitado2FA naquela entrada. Para Entrar, um código novo continua vindo de `nativeHotelService` e do endpoint oficial, que também exige verificações adicionais quando necessário.

Nome, figure, id e head continuam sendo os únicos dados de perfil persistidos pelo helper. Senha, OTP e cookies não são lidos ou exportados por ele. O Habbo decide quando pedir2FA. As verificações de segurança e idade continuam respeitadas; os avisos agora diferenciam sessão encerrada, segurança e idade.

O JavaScript público oficial foi consultado novamente em02/11/2026; URL e hash em `work/feature67/site-source67.json`. O código completo de terceiros permanece fora dos pacotes.

## Sair pelo H

O H chama o reinício nativo do cliente. O estado estático `_ssoSession` permanecia ativo e `ignoreLegacyResponse` descartava o novo `/api/public/info/hello`, impedindo a abertura do login.

A ponte `HabboTicketLogin.clearSession67`, chamada antes do reinício, cancela o timeout, invalida callbacks antigos e limpa as referências e flags transitórias da autenticação. Fecha as janelas ativas e mantém o reinício nativo. O perfil/cookies do navegador e as preferências permanentes dos comandos são preservados. Desconexões inesperadas do servidor continuam mostrando o erro normal.

## Personagem na entrada

A remoção da sombra havia forçado a flag de entrada do canvas a falso. Isso colocava o personagem da porta na camada comum `RSC3D_TOP`, à frente da composição das paredes e dos mobis.

A67 restaura a flag original de visibilidade da parede e a classificação nativa da entrada. O personagem na coordenada da porta usa `RSC3D_DOOR`, a camada traseira, enquanto estiver fora do quarto; ao caminhar para dentro, volta à ordenação comum. Paredes ocultas desativam essa classificação. A imagem escura e o retângulo antigo de clip continuam removidos. O recorte real da malha65 é preservado, permitindo ver o personagem pela abertura.

## Horários do console

O horário estava posicionado na seção inferior da textura que contém a ponta do balão. Agora a linha fica logo abaixo do texto, com espaço antes da borda inferior. Seu tamanho acompanha a fonte da mensagem e o alinhamento é à direita. Balões escuros usam texto claro; balões claros, texto escuro. O contraste contra as cores amostradas do print supera 4,5:1. A reutilização após a medição nativa não aumenta sucessivamente a altura do renderer. Texto, hora enviada, selos por dia e paginação são preservados.

## Validação

Quatorze verificações locais aprovadas:

- Reprodução66 e correção67 do bloqueio da sessão, com/sem2FA, evento de login, desafio pendente/cancelado, ticket novo, seleção de personagem, host exato e ausência de varreduras contínuas da página.
- Reprodução do estado SSO retido no logout; execução do reinício nativo, aceite do novo hello, login visível/inicializado e segunda autenticação33, sem perder o perfil vinculado.
- Execução da preparação nativa da entrada e dos trechos exatos de classificação/reparenting do render. Orientações90/180, entrada/saída, mobis e parede oculta; nenhuma imagem de sombra ou clip antigo.
- Horário fora da ponta, margem inferior, fonte proporcional, contraste, reciclagem, mensagem Unicode, datas e histórico/paginação.
- Luzes/salvamento, malha/UV da porta, configurações, renderização de fundo, correção66 dos slots Label,2059 vínculos de cor e demais regressões33.
- Auditoria:37841 métodos anteriores preservados; quatro métodos limitados alterados e uma ponte de logout adicionada. A mudança do literal JavaScript também é revisada. Cabeçalhos de protocolo e autenticação não mudam; offsets AVM2 válidos. O dex nativo é igual ao APK66; a verificação anterior das2760 classes é retida com seu hash.

Relatórios: `work/feature67/validation67.json`, `investigation67.json`, `release67.json` e logs. Testes de rede, renderização/entrega de eventos Android, conta real e persistência de cookies em aparelho continuam sendo limites explícitos. Não houve acesso à conta do usuário.

## Reprodução

```bash
python work/setup_token63.py
bash work/build_token67.sh
python work/regression_token67.py
python work/make_token_apk67.py
java -m jdk.compiler/com.sun.tools.javac.Main -cp .task-tools/apksig61.jar -d work/classes work/VerifyApkToken61.java
java -cp .task-tools/apksig61.jar:work/classes VerifyApkToken61 output/Habbo_2.32.32_Teste67_Base33.apk
python work/package_token67.py
```

O empacotador requer temporariamente o material de assinatura original nos caminhos usados por `make_fullscreen.py`. Esse material não é distribuído. Não gerar outra chave. O portador Android33, permissões, fullscreen, aceleração do navegador, classes2.dex/classes3.dex e dex65/66 são preservados.

Os nomes históricos dos helpers são mantidos por compatibilidade; os comandos ativos são os67. O ZIP de alterações contém somente arquivos novos/alterados em seus caminhos originais. Os fontes completos incluem as dependências da linha Base33.

No aparelho: vincular com/sem desafio real, conferir que a janela fecha e o perfil atualiza; Entrar, Sair pelo H, entrar novamente; verificar o personagem nas duas entradas com parede/mobi à frente; comparar horários enviados/recebidos em mensagens curtas e longas.
