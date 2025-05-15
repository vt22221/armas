local draggingSticker = nil

function fxwDrawStickersPanel(x, y, w, h)
    local stickers = getElementData(localPlayer, "fxw:stickers") or {}
    local col, sz = 6, 64
    for i, st in ipairs(allStickers) do
        local cx = x+30+((i-1)%col)*sz*1.2
        local cy = y+30+math.floor((i-1)/col)*sz*1.2
        dxDrawRectangle(cx, cy, sz, sz, tocolor(30,30,40,210))
        dxDrawImage(cx+4, cy+4, sz-8, sz-8, st.img)
        dxDrawText("x"..(stickers[st.id] or 0), cx, cy+sz-18, cx+sz, cy+sz, c.accent, 0.9, c.font, "center")
        if isCursorOnElement(cx, cy, sz, sz) and (stickers[st.id] or 0)>0 then
            if getKeyState("mouse1") and not draggingSticker then draggingSticker = st.id end
        end
    end
    -- Drag & Drop para slots de arma
    if draggingSticker then
        local mx, my = getCursorPosition()
        local sw, sh = guiGetScreenSize()
        mx, my = mx*sw, my*sh
        dxDrawImage(mx-32, my-32, sz, sz, allStickers[draggingSticker] and allStickers[draggingSticker].img or "")
        -- Exemplo: se soltar sobre slot de arma, envia para server
        -- Aqui você desenha os slots das armas do jogador, e se mouse estiver sobre, chama:
        -- triggerServerEvent("fxw:applyStickerToWeapon", resourceRoot, draggingSticker, weaponSlot)
        if not getKeyState("mouse1") then draggingSticker = nil end
    end
end