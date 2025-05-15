function fxwDrawCraftingPanel(x, y, w, h)
    for i, recipe in ipairs(allCrafting) do
        local cy = y+40+(i-1)*90
        dxDrawRectangle(x+20, cy, w-40, 80, tocolor(25,30,38,190))
        dxDrawText(recipe.name, x+36, cy+8, x+w-40, cy+38, c.accent, 1.1, c.font, "left")
        local reqs = {}
        for _, r in ipairs(recipe.requires) do
            table.insert(reqs, (r.count or 1).."x "..r.type..":"..r.id)
        end
        dxDrawText("Requisitos: "..table.concat(reqs, ", "), x+36, cy+36, x+w-40, cy+66, tocolor(210,210,210), 1, c.font, "left")
        dxDrawRectangle(x+w-120, cy+24, 100, 32, tocolor(50,150,250,220))
        dxDrawText("Craftar", x+w-120, cy+24, x+w-20, cy+56, c.accent, 1.1, c.font, "center", "center")
        if isCursorOnElement(x+w-120, cy+24, 100, 32) and getKeyState("mouse1") then
            triggerServerEvent("fxw:craftItem", resourceRoot, recipe.id)
        end
    end
end