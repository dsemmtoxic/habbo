# Habbo Teste65 / Base33

Atualização de 02/11/2026 sobre a Teste64, mantendo o código de jogo/autenticação da Base33. Android `2.32.30-t65-b33`, versionCode `2032164`, AIR `2.32.164`. A migração nativa34–60 continua suspensa.

O usuário confirmou em aparelho que o Toner e os reguladores da64 funcionam. Esta atualização muda somente a apresentação das sete cores; o salvamento, confirmação do servidor, presets, limite76/255, prévia, cancelar e integração da iluminação com o fundo permanecem iguais à64.

## Alterações

- Sete botões de cor preenchidos por uma skin arredondada na cor escolhida, com borda de seleção. Removido o ícone quadrado interno.
- Login transparente, sem moldura/cartão opaco. Botões novos com cantos arredondados, abas Conta/Token, seletor de hotel e engrenagem. Textos principais brancos com contorno preto. Layout em duas colunas na horizontal e reorganizado na vertical.
- Avatar obtido pelo próprio serviço `imager` do site, com pose `s-2.g-1.d-2.h-2.a-0`, igual ao exemplo enviado. Remoção apenas da margem transparente, escala proporcional e ampliação inteira de pixels quando possível. Bitmap retido para recuperação de contexto gráfico.
- `Alternar personagem` abre `/settings/avatars` no hotel selecionado. A resposta bem-sucedida da seleção atualiza nome/figure/head e fecha o navegador. Falha de seleção mantém a janela aberta.
- A primeira vinculação encerra o navegador assim que `Session.user` estiver disponível após as verificações do site, sem precisar de JOGAR. Depois, Entrar solicita um novo código do Launcher pelo serviço oficial em WebView oculta e o entrega à autenticação33. Login expirado ou verificação adicional torna o navegador visível.
- Navegador com aceleração por hardware habilitada no Manifest e no descritor AIR. JavaScript usa `evaluateJavascript` no Android19+, sem interface Java exposta. Removidas varreduras contínuas do corpo da página, reinjeção a cada segundo e redimensionamento idêntico repetido. A taxa de frames não foi medida nesta máquina.
- Recorte real na malha3D das paredes usando a máscara nativa da porta, seus offsets/flips e dimensões do caminho3D do Habbo. A máscara existe na64, mas o caminho3D desenhava um retângulo inteiro. A nova geometria divide a parede em retângulos fora do vão e preserva o mapeamento da textura. O PNG escuro e o clip de avatar continuam desativados. O traçado e a validação de piso conectado da33 permanecem.

## Sessão oficial

O script consulta os serviços Angular da página oficial, verificados em `https://images.habbo.com/habbo-web/america/pt/scripts.f4ce8f82.js` em02/11/2026. Evidências pontuais e hash em `work/feature65/site-evidence65.json`; o código de terceiros completo não faz parte dos fontes.

| Operação | Serviço do site |
| --- | --- |
| Perfil selecionado após login/verificação | `Session.user` |
| Novo código Launcher | `nativeHotelService.stop()` e `.start()`; POST `/api/client/clientnative/url` |
| Confirmação da troca de personagem | Sucesso do POST `/api/user/avatars/select`, ou mudança de `Session.user.uniqueId` |
| Head oficial | `imager.generatePose()` e `.getImagerUrl()` |

A senha e o2FA são preenchidos no site. O helper não lê esses campos, cookies ou armazenamento completo da página. O perfil local contém somente nome, figure, id e URL da head; a chave `habboBrowserProfile64` é conservada para atualizar a instalação64 sem apagar o vínculo. O código Launcher fica apenas no fluxo transitório de entrada. As verificações oficiais, inclusive bloqueio de segurança e idade, continuam exigidas quando o Habbo as solicita. Mudanças futuras do site podem exigir adaptação.

## Reprodução

Na raiz do projeto, com Java e Python/Node disponíveis:

```bash
bash work/build_token65.sh
python work/build_native65.py
python work/check_native65.py
python work/regression_token65.py
python work/make_token_apk65.py
java -cp .task-tools/apksig61.jar:work/classes VerifyApkToken61 output/Habbo_2.32.30_Teste65_Base33.apk
python work/package_token65.py
```

`make_token_apk65.py` requer temporariamente o material original de assinatura nos caminhos usados por `make_fullscreen.py`; ele não é distribuído. Não gerar certificado novo. O portador Android neutro preserva recursos e permissões; somente classes.dex, Manifest, descritor AIR e SWF ativo mudam. classes2.dex/classes3.dex permanecem byte a byte iguais à base.

Os nomes históricos `Login62`, `RoomLighting63`, `WebSession64` e `session64.js` são mantidos para compatibilidade, mas seus fontes atuais pertencem à65. A fonte ativa é recompilada sempre a partir do SWF33 exato. Os registros e scripts anteriores servem como histórico; a reprodução desta entrega usa os comandos65 acima.

## Validação e limites

Doze verificações locais executam o AVM2 salvo e o script realmente embutido, com limites explícitos para serviços de rede, UI/GPU e APIs do sistema. Incluem Apply/ack do Toner/regulador, sete cores e limite de brilho; oito tamanhos de login, contorno e proporção da head; recorte/área de triângulos/UV nas duas orientações; máscaras/piso isolado; console; comandos;2059 vínculos de cor; regressões da33; auditoria dos demais métodos e protocolo; fluxo do site com serviços simulados; roundtrip das2760 classes do dex principal. Relatórios em `work/feature65/validation65.json` e logs associados.

Ainda depende de teste no aparelho: renderização real da porta e fonte, fluidez/FPS do WebView, persistência de cookies após reiniciar, vinculação/2FA e troca de personagem com conta real. Não houve acesso a uma conta do usuário nem emulador Android nesta máquina. Os testes locais não comprovam esses resultados visuais ou a resposta real do hotel.

Roteiro no aparelho: instalar65 sobre64; vincular sem JOGAR; reabrir o app e tocar Entrar; trocar personagem e conferir nome/head; navegar e rolar o site; conferir porta nas duas paredes com piso conectado e ausência de sombra; conferir preenchimento das cores e Aplicar/reabrir o regulador.

O ZIP `Habbo_Teste65_Base33_Alteracoes.zip` contém somente alterações em caminhos originais. `Habbo_Token65_Base33_Fontes.zip` contém os fontes completos e dependências da linha Base33. Ambos possuem manifesto de hashes e excluem assinatura privada.
