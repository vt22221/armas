local badgeData = {}

-- Lê milestones/badges do JSON para expansão fácil
function loadBadgeData()
    local filePath = "fxw_data/badges.json"
    badgeData = {}
    if fileExists(filePath) then
        local f = fileOpen(filePath)
        local raw = fileRead(f, fileGetSize(f))
        fileClose(f)
        local ok, data = pcall(fromJSON, raw)
        if ok and type(data) == "table" then
            for _, badge in ipairs(data) do
                badgeData[badge.id] = badge -- badge: {id=, name=, stat=, value=}
            end
        end
    end
end
addEventHandler("onResourceStart", resourceRoot, loadBadgeData)

-- Checa e concede badges ao atingir milestone
function fxwCheckBadges(player)
    local stats = getElementData(player, "fxw:stats") or {}
    local badges = getElementData(player, "fxw:badges") or {}
    for id, badge in pairs(badgeData) do
        if not badges[id] then
            local statVal = stats[badge.stat] or 0
            if statVal >= badge.value then
                fxwGrantBadge(player, id)
            end
        end
    end
end

-- Concede badge de forma segura
function fxwGrantBadge(player, id)
    if not badgeData[id] then return end
    local badges = getElementData(player, "fxw:badges") or {}
    if badges[id] then return end
    badges[id] = true
    setElementData(player, "fxw:badges", badges)
    triggerClientEvent(player,"fxw:notify",resourceRoot,"Conquista desbloqueada: "..(badgeData[id].name or id),tocolor(0,255,120),4300)
    -- LOG: badge concedido
end

-- Função utilitária para checar badge
function fxwHasBadge(player, id)
    local badges = getElementData(player, "fxw:badges") or {}
    return badges[id] == true
end

-- Evento para conceder badge explicitamente
addEvent("fxw:addBadge", true)
addEventHandler("fxw:addBadge", root, function(id)
    fxwGrantBadge(client or source, id)
end)