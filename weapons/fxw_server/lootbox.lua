local config = fxwGetConfig()

function fxwHasCurrency(player, amount, mode)
    if mode == "vip" then
        return (getElementData(player, "fxw:vip_balance") or 0) >= amount
    else
        return (getPlayerMoney(player) or 0) >= amount
    end
end

function fxwTakeCurrency(player, amount, mode)
    if mode == "vip" then
        setElementData(player, "fxw:vip_balance", (getElementData(player, "fxw:vip_balance") or 0) - amount)
    else
        takePlayerMoney(player, amount)
    end
end

addEvent("fxw:buyLootbox",true)
addEventHandler("fxw:buyLootbox",root,function(tipo,mode)
    local box = config.lootboxes[tipo]
    if not box then return end
    local preco = (mode=="vip") and box.price_vip or box.price_game
    if not fxwHasCurrency(client, preco, mode) then
        triggerClientEvent(client, "fxw:notify", resourceRoot, "Saldo insuficiente.", tocolor(255,60,60), 3500)
        return
    end
    fxwTakeCurrency(client, preco, mode)
    local pool = box.rewards
    local choice = pool[math.random(#pool)]
    fxwGiveItem(client, "skin", choice)
    triggerClientEvent(client, "fxw:notify", resourceRoot, "Você ganhou: "..choice, tocolor(box.color[1],box.color[2],box.color[3]), 4200)
end)