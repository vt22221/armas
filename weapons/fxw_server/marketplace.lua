local config = fxwGetConfig()
local listings = {}

function fxwListItem(player, uniqueId, price)
    if price < config.marketplace.min_price then
        triggerClientEvent(player,"fxw:notify",resourceRoot,"Preço mínimo não atingido.",tocolor(255,70,70),3400) return
    end
    if not fxwPlayerHasItem(player, uniqueId) then
        triggerClientEvent(player,"fxw:notify",resourceRoot,"Item não existe no seu inventário.",tocolor(255,70,70),3400) return
    end
    local item = fxwFindItem(player, uniqueId)
    local id = tostring(getTickCount())..getPlayerName(player)
    listings[id] = {item=item,price=price,seller=getPlayerName(player)}
    fxwRemoveItem(player, uniqueId)
    triggerClientEvent(player,"fxw:notify",resourceRoot,"Item listado no marketplace!",tocolor(0,255,120),3400)
end

function fxwFindItem(player, uniqueId)
    local inv = getElementData(player, "fxw:inventory") or {}
    for _,v in ipairs(inv) do
        if v.uniqueId == uniqueId then return v end
    end
end

addEvent("fxw:listMarketItem",true)
addEventHandler("fxw:listMarketItem",root,function(uniqueId, price)
    fxwListItem(client, uniqueId, price)
end)

addEvent("fxw:buyMarketItem",true)
addEventHandler("fxw:buyMarketItem",root,function(listingId)
    local l = listings[listingId]
    if l and fxwHasCurrency(client, l.price, "coins") then
        fxwTakeCurrency(client, l.price, "coins")
        local sellerP = getPlayerFromName(l.seller)
        if sellerP then
            setElementData(sellerP, "fxw:vip_balance", (getElementData(sellerP, "fxw:vip_balance") or 0) + math.floor(l.price*(1-config.marketplace.fee_percent/100)))
            triggerClientEvent(sellerP,"fxw:notify",resourceRoot,"Seu item foi vendido!",tocolor(120,220,255),3400)
        end
        fxwGiveItem(client, l.item.type, l.item.id)
        listings[listingId] = nil
        triggerClientEvent(client,"fxw:notify",resourceRoot,"Compra realizada, item transferido!",tocolor(60,255,60),3400)
    end
end)

addEvent("fxw:getMarketListings",true)
addEventHandler("fxw:getMarketListings",root,function()
    triggerClientEvent(client,"fxw:marketListings",resourceRoot,listings)
end)