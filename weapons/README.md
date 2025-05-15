# ForgeX Weapons NextGen — Resource Modular Premium para MTA

## Descrição Geral

Este resource traz o sistema mais completo e moderno de skins, colecionáveis, battlepass, badges, stickers, crafting e marketplace para MTA:SA, 100% in-game, expansível e seguro.  
Ideal para servidores roleplay, PvP, competitivo, colecionáveis, RP ou monetização via saldo VIP.

---

## Instalação

1. **Baixe ou clone o resource para a pasta `resources/` do seu servidor.**
2. **Adicione `start fxw` em seu `mtaserver.conf`.**
3. **Garanta permissão ACL aos administradores para comandos VIP/admin (ver `config.lua`).**
4. **Reinicie o servidor ou use `/refresh` e `/start fxw`.**

---

## Personalizando e Expandindo o Resource

### 1. **Adicionando/Modificando Skins, Stickers, Badges, Receitas de Crafting e Battlepass**

#### **Skins**
- Adicione suas imagens em `img/skins/`.
- Para adicionar skins ao lootbox, battlepass ou crafting, basta referenciar o nome da skin na configuração ou JSON.

#### **Stickers**
- Edite `fxw_data/stickers.json`:
    ```json
    [
        {"id":"dragon", "name":"Dragão", "img":"stickers/dragon.png"},
        {"id":"skull", "name":"Caveira", "img":"stickers/skull.png"}
    ]
    ```
- Coloque a imagem do sticker em `img/stickers/`.

#### **Badges**
- Edite `fxw_data/badges.json`:
    ```json
    [
        {"id":"badge_kill10", "name":"10 Kills", "stat":"kills", "value":10},
        {"id":"badge_craft1", "name":"Primeiro Craft", "stat":"crafting", "value":1}
    ]
    ```
- Coloque a imagem do badge em `img/badges/`.

#### **Battlepass**
- Edite `fxw_data/battlepass.json`:
    ```json
    {
        "tiers": [
            {"xp":100, "reward":{"type":"skin", "id":"ouro"}},
            {"xp":250, "reward":{"type":"lootbox", "id":"premium"}},
            {"xp":500, "reward":{"type":"sticker", "id":"dragon"}},
            {"xp":1000, "reward":{"type":"badge", "id":"bp_season1"}}
        ]
    }
    ```
- Altere/add tiers, XP e recompensas livremente.

#### **Crafting**
- Edite `fxw_data/crafting.json`:
    ```json
    [
        {
            "id":"rainbow",
            "name":"Skin Rainbow",
            "requires":[
                {"type":"skin","id":"neon","count":1},
                {"type":"skin","id":"ouro","count":1},
                {"type":"fragment","id":"fragmento","count":2}
            ],
            "result":{"type":"skin","id":"rainbow"}
        }
    ]
    ```
- Adicione/remova receitas conforme desejar.

---

### 2. **Adicionando novas Lootboxes ou Modificando as Existentes**

- Edite `config.lua` na tabela `lootboxes`:
    ```lua
    lootboxes = {
        ["premium"] = {
            price_game = 120000,
            price_vip = 25,
            rewards = {"neon", "inferno", "gelo"}
        }
    }
    ```
- Para adicionar uma lootbox, basta criar uma nova entrada.

---

### 3. **Alterando Economia, XP, Permissões, Visuais**

- Edite `config.lua` para:
    - Alterar saldo inicial, nomes de moedas, XP por ação.
    - Alterar permissões (ACL) para comandos/admin.
    - Modificar cores, fontes e estilo do painel.

---

### 4. **Comandos Administrativos**

- `/addvip nick valor` — adiciona saldo VIP ao jogador.
- `/criar tipo` — cria marker de loja/painel no mapa.
- Outros comandos podem ser adicionados facilmente em `admin.lua`.

---

### 5. **Funcionamento da UI**

- Pressione `F5` (ou configure outro atalho) para abrir o painel completo.
- Use as abas para acessar Battlepass, Badges, Stickers, Crafting e Inventário.
- Use drag&drop para aplicar stickers, organizar inventário, etc.
- Todas operações são seguras e validadas no servidor.

---

### 6. **Como adicionar novos módulos ou funcionalidades?**

- Crie um novo arquivo Lua na pasta `fxw_server/` ou `fxw_client/`.
- Importe/exporte dados pelo JSON correspondente em `fxw_data/`.
- Use o padrão de eventos e handlers já existente (validação server-side, notificação via evento, sincronização via trigger).
- Para badges, stickers e crafting, basta adicionar no JSON e garantir que as imagens correspondentes existam em `img/`.

---

### 7. **Dicas para Expansão Avançada**

- **Marketplace:** Siga o padrão do módulo de inventário para permitir vendas/trocas.
- **Missões/Quests:** Crie novos stats (ex: `missions`) e badges correspondentes.
- **Ranking:** Use as stats já acumuladas (`fxw:stats`) para gerar rankings diários/semanal.
- **Personalização visual:** Edite o CSS/cores/fonte em `config.lua` para deixar o painel com a cara do seu servidor.

---

## Suporte e Dúvidas

- Qualquer dúvida, problema ou sugestão, basta abrir um ticket no Discord do seu servidor ou procurar a equipe ForgeX.
- O código é modular e comentado, facilitando para admins e scripters de todos os níveis.

---

## **Resumo**
- **Totalmente modular, seguro, expansível e editável.**
- **Nenhum dado crítico é alterado apenas no client.**
- **Tudo pode ser expandido editando arquivos JSON, imagens e configurações.**
- **Pronto para servidores roleplay, competitivo, monetização e colecionáveis.**

---

**Se precisar de exemplos de expansão para outros sistemas (marketplace, tickets, analytics, ranking, eventos sazonais, etc), só pedir!**
