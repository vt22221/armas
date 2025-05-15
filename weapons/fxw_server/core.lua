local config = fxwGetConfig()
local allowedMarkers = {
    ["modshop"] = {}, ["paintshop"] = {}, ["craftarma"] = {}, ["lootbox"] = {}, ["market"] = {}, ["admin"] = {acl=config.permissions.admin_acl}
}

function fxwDiscordLog(title, desc, color)
    fetchRemote(config.discord_webhook, {
        postData = toJSON({embeds = {{title = title, description = desc, color = color or 16760576}}}),
        headers = {["Content-Type"] = "application/json"}
    })
end

addEvent("fxw:tryPanel", true)
addEventHandler("fxw:tryPanel", root, function(panel)
    if not isElement(client) or not allowedMarkers[panel] then return end
    local last = getElementData(client, "fxw:lastPanelTry") or 0
    if getTickCount()-last < 700 then return end
    setElementData(client, "fxw:lastPanelTry", getTickCount())
    local acl = allowedMarkers[panel].acl
    if acl then
        local acc = getAccountName(getPlayerAccount(client))
        if not acc or not isObjectInACLGroup("user."..acc, aclGetGroup(acl)) then
            triggerClientEvent(client, "fxw:notify", resourceRoot, "Permissão negada!", tocolor(255,50,50), 3500)
            return
        end
    end
    triggerClientEvent(client, "fxw:openPanel", resourceRoot, panel)
end)

addCommandHandler("criar", function(p,_,tipo)
    local acc = getAccountName(getPlayerAccount(p))
    if not acc or not isObjectInACLGroup("user."..acc, aclGetGroup(config.permissions.admin_acl)) then
        outputChatBox("Sem permissão!",p,255,0,0) return
    end
    if not allowedMarkers[tipo] then outputChatBox("Tipos: modshop, paintshop, craftarma, lootbox, market",p,255,0,0) return end
    local x,y,z = getElementPosition(p)
    local m = createMarker(x,y,z-1,"cylinder",2,60,180,255,120)
    setElementData(m,"fxw:type",tipo)
    outputChatBox("Marker '"..tipo.."' criado.",p,0,255,0)
end)

-- Sistema de saldo real
function fxwAddRealFunds(player, amount)
    setElementData(player, "fxw:real_balance", (getElementData(player, "fxw:real_balance") or 0) + amount)
    triggerClientEvent(player, "fxw:notify", resourceRoot, "Você recebeu +"..amount.." "..config.economy.real_name, tocolor(0,255,120), 4000)
end

addCommandHandler("addfunds", function(p,_,nick,valor)
    if not nick or not valor then outputChatBox("/addfunds nick valor",p,255,0,0) return end
    local acc = getAccountName(getPlayerAccount(p))
    if not acc or not isObjectInACLGroup("user."..acc, aclGetGroup(config.permissions.addfunds_acl)) then
        outputChatBox("Sem permissão!",p,255,0,0) return
    end
    local alvo = getPlayerFromName(nick)
    if alvo then
        fxwAddRealFunds(alvo, tonumber(valor))
        fxwDiscordLog("Saldo real adicionado", "Admin "..getPlayerName(p).." adicionou +"..valor.." "..config.economy.real_name.." para "..getPlayerName(alvo), 16760576)
        outputChatBox("Saldo adicionado.", p, 50,255,50)
    end
end)