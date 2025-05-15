function fxwGiveItem(player, itemType, itemId)
    local inv = getElementData(player, "fxw:inventory") or {}
    table.insert(inv, {type=itemType, id=itemId, uniqueId=fxwGenerateUniqueId(player, itemType, itemId)})
    setElementData(player, "fxw:inventory", inv)
end

function fxwGenerateUniqueId(player, t, id)
    return getPlayerSerial(player).."_"..t.."_"..id.."_"..getTickCount()
end

function fxwRemoveItem(player, uniqueId)
    local inv = getElementData(player, "fxw:inventory") or {}
    for i,v in ipairs(inv) do
        if v.uniqueId == uniqueId then table.remove(inv, i) break end
    end
    setElementData(player, "fxw:inventory", inv)
end

function fxwPlayerHasItem(player, uniqueId)
    local inv = getElementData(player, "fxw:inventory") or {}
    for _,v in ipairs(inv) do if v.uniqueId == uniqueId then return true end end
    return false
end