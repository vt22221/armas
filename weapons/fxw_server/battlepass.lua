local config = fxwGetConfig()
local bpData = {}

-- Lê tiers do arquivo para fácil expansão
function loadBattlePassData()
    local filePath = "fxw_data/battlepass.json"
    if fileExists(filePath) then
        local f = fileOpen(filePath)
        local raw = fileRead(f, fileGetSize(f))
        fileClose(f)
        local ok, data = pcall(fromJSON, raw)
        if ok and data and type(data.tiers) == "table" then
            bpData.tiers = data.tiers
        else
            bpData.tiers = {}
        end
    else
        -- fallback/legacy
        bpData.tiers = {
            {xp=100, reward={type="skin", id="ouro"}},
            {xp=250, reward={type="lootbox", id="premium"}},
            {xp=500, reward={type="sticker", id="dragon"}},
            {xp=1000, reward={type="badge", id="bp_season1"}}
        }
    end
end
addEventHandler("onResourceStart", resourceRoot, loadBattlePassData)

-- Adiciona XP ao Battlepass do jogador e verifica recompensas
function fxwAddBattlePassXP(player, amount)
    if not isElement(player) then return end
    local xp = getElementData(player, "fxw:bp_xp") or 0
    xp = xp + amount
    setElementData(player, "fxw:bp_xp", xp)
    fxwCheckBattlePassTiers(player, xp)
end

-- Verifica e concede recompensas de tiers
function fxwCheckBattlePassTiers(player, xp)
    if not bpData.tiers then return end
    for idx, t in ipairs(bpData.tiers) do
        if xp >= t.xp and not getElementData(player,"fxw:bp_tier_"..idx) then
            setElementData(player,"fxw:bp_tier_"..idx, true)
            local r = t.reward
            if r.type == "skin" then
                fxwGiveItem(player, "skin", r.id)
            elseif r.type == "lootbox" then
                fxwGiveItem(player, "lootbox", r.id)
            elseif r.type == "sticker" then
                fxwGiveItem(player, "sticker", r.id)
            elseif r.type == "badge" then
                triggerEvent("fxw:addBadge", player, r.id)
            end
            triggerClientEvent(player, "fxw:notify", resourceRoot, "Battlepass: Tier "..idx.." desbloqueado!", tocolor(255,220,0), 4300)
            -- LOG: você pode adicionar logs aqui
        end
    end
end

-- Triggers automáticos de XP por ações
addEvent("fxw:battlepassAddXP", true)
addEventHandler("fxw:battlepassAddXP", root, function(amount)
    fxwAddBattlePassXP(client or source, amount)
end)

-- Exemplo de integração (matar um player dá XP no battlepass)
addEvent("onPlayerKillBattlepass", true)
addEventHandler("onPlayerKillBattlepass", root, function(killer)
    if killer and isElement(killer) then
        fxwAddBattlePassXP(killer, config.battlepass.xp_per_action or 50)
    end
end)

-- Idem para crafting, lootbox, etc: chame fxwAddBattlePassXP quando necessário.