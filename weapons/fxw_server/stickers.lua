local stickerData = {}

-- Lê stickers do JSON para expansão fácil
function loadStickerData()
    local filePath = "fxw_data/stickers.json"
    stickerData = {}
    if fileExists(filePath) then
        local f = fileOpen(filePath)
        local raw = fileRead(f, fileGetSize(f))
        fileClose(f)
        local ok, data = pcall(fromJSON, raw)
        if ok and type(data) == "table" then
            for _, sticker in ipairs(data) do
                stickerData[sticker.id] = sticker -- sticker: {id=, name=, img=}
            end
        end
    end
end
addEventHandler("onResourceStart", resourceRoot, loadStickerData)

-- Adiciona sticker ao inventário
function fxwGiveSticker(player, stickerId)
    if not stickerData[stickerId] then return false end
    local stickers = getElementData(player, "fxw:stickers") or {}
    stickers[stickerId] = (stickers[stickerId] or 0) + 1
    setElementData(player, "fxw:stickers", stickers)
    triggerClientEvent(player, "fxw:notify", resourceRoot, "Sticker "..(stickerData[stickerId].name or stickerId).." adicionado ao inventário!", tocolor(210,140,255), 4200)
    return true
end

-- Remove sticker do inventário
function fxwRemoveSticker(player, stickerId)
    local stickers = getElementData(player, "fxw:stickers") or {}
    if (stickers[stickerId] or 0) <= 0 then return false end
    stickers[stickerId] = stickers[stickerId] - 1
    setElementData(player, "fxw:stickers", stickers)
    return true
end

-- Aplica sticker em arma equipada (armaSlot = número da arma)
function fxwApplyStickerToWeapon(player, stickerId, weaponSlot)
    if not stickerData[stickerId] then return false end
    local stickers = getElementData(player, "fxw:stickers") or {}
    if (stickers[stickerId] or 0) <= 0 then
        triggerClientEvent(player, "fxw:notify", resourceRoot, "Você não possui esse sticker!", tocolor(255,60,60), 3500)
        return false
    end
    local wdata = getElementData(player, "fxw:weapons") or {}
    wdata[weaponSlot] = wdata[weaponSlot] or {}
    -- Verifica se já tem sticker: precisa remover antes
    if wdata[weaponSlot].sticker then
        triggerClientEvent(player, "fxw:notify", resourceRoot, "Remova o sticker atual antes.", tocolor(255,220,80), 3200)
        return false
    end
    -- Aplica
    wdata[weaponSlot].sticker = stickerId
    setElementData(player, "fxw:weapons", wdata)
    fxwRemoveSticker(player, stickerId)
    triggerClientEvent(player, "fxw:notify", resourceRoot, "Sticker aplicado!", tocolor(0,200,255), 3200)
    return true
end

-- Remove sticker da arma (devolve para inventário)
function fxwRemoveStickerFromWeapon(player, weaponSlot)
    local wdata = getElementData(player, "fxw:weapons") or {}
    if not wdata[weaponSlot] or not wdata[weaponSlot].sticker then
        triggerClientEvent(player, "fxw:notify", resourceRoot, "Nenhum sticker para remover.", tocolor(255,60,60), 3200)
        return false
    end
    local stickerId = wdata[weaponSlot].sticker
    wdata[weaponSlot].sticker = nil
    setElementData(player, "fxw:weapons", wdata)
    fxwGiveSticker(player, stickerId)
    triggerClientEvent(player, "fxw:notify", resourceRoot, "Sticker removido e devolvido ao inventário.", tocolor(180,220,255), 3200)
    return true
end

-- Eventos
addEvent("fxw:giveSticker", true)
addEventHandler("fxw:giveSticker", root, function(stickerId)
    fxwGiveSticker(client or source, stickerId)
end)

addEvent("fxw:applyStickerToWeapon", true)
addEventHandler("fxw:applyStickerToWeapon", root, function(stickerId, weaponSlot)
    fxwApplyStickerToWeapon(client or source, stickerId, weaponSlot)
end)

addEvent("fxw:removeStickerFromWeapon", true)
addEventHandler("fxw:removeStickerFromWeapon", root, function(weaponSlot)
    fxwRemoveStickerFromWeapon(client or source, weaponSlot)
end)