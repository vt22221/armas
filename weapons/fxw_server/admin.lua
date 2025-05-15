local config = fxwGetConfig()

function fxwAddVIPFunds(player, amount)
    setElementData(player, "fxw:vip_balance", (getElementData(player, "fxw:vip_balance") or 0) + amount)
    triggerClientEvent(player, "fxw:notify", resourceRoot, "Você recebeu +"..amount.." "..config.economy.vip_name, config.economy.vip_color, 4000)
end

addCommandHandler("addvip", function(p,_,nick,valor)
    if not nick or not valor then outputChatBox("/addvip nick valor",p,255,0,0) return end
    local acc = getAccountName(getPlayerAccount(p))
    if not acc or not isObjectInACLGroup("user."..acc, aclGetGroup(config.permissions.add_vip_acl)) then
        outputChatBox("Sem permissão!",p,255,0,0) return
    end
    local alvo = getPlayerFromName(nick)
    if alvo then
        fxwAddVIPFunds(alvo, tonumber(valor))
        outputChatBox("VIP adicionado.", p, 50,255,50)
        outputChatBox("Você recebeu +"..valor.." "..config.economy.vip_name, alvo, 255,215,0)
    end
end)