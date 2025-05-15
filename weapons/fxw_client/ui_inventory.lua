local dragging = nil

function fxwDrawInventoryPanel(x, y, w, h)
    local inv = getElementData(localPlayer, "fxw:inventory") or {}
    local sz, margin = 72, 18
    for i=1, math.max(#inv,24) do
        local cx = x + ((i-1)%6)*(sz+margin)
        local cy = y + math.floor((i-1)/6)*(sz+margin)
        dxDrawRectangle(cx, cy, sz, sz, tocolor(30,30,40,210))
        local item = inv[i]
        if item then
            dxDrawImage(cx+8, cy+8, sz-16, sz-16, fxwGetItemImage(item))
            if isCursorOnElement(cx, cy, sz, sz) then
                dxDrawText(item.id, cx, cy+sz, cx+sz, cy+sz+20, fxwConfig.ui.accent, 1, fxwConfig.ui.font, "center")
                if getKeyState("mouse1") and not dragging then
                    dragging = {item=item, from=i}
                end
                if getKeyState("mouse2") then
                    -- Inspecionar item
                    -- triggerEvent("fxw:inspectItem", resourceRoot, item.uniqueId)
                end
            end
        end
        if dragging and isCursorOnElement(cx, cy, sz, sz) then
            dxDrawRectangle(cx, cy, sz, sz, tocolor(120,255,180,120))
            if getKeyState("mouse1") == false and dragging.from ~= i then
                inv[dragging.from], inv[i] = inv[i], inv[dragging.from]
                setElementData(localPlayer, "fxw:inventory", inv)
                dragging = nil
            end
        end
    end
    if dragging then
        local mx,my = getCursorPosition()
        local sw,sh = guiGetScreenSize()
        mx,my = mx*sw, my*sh
        dxDrawImage(mx-32, my-32, sz, sz, fxwGetItemImage(dragging.item))
        if getKeyState("mouse1") == false then dragging = nil end
    end
end

function fxwGetItemImage(item)
    if item.type == "skin" then return "img/skins/"..item.id..".png"
    elseif item.type == "sticker" then return "img/stickers/"..item.id..".png"
    elseif item.type == "lootbox" then return "img/cases/"..item.id..".png"
    elseif item.type == "badge" then return "img/badges/"..item.id..".png"
    end
    return "img/item_default.png"
end