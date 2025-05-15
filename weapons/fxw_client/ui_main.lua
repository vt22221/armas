local c = fxwConfig.ui
local panel = {visible=false, tab="battlepass"}

-- Dados dinâmicos para UI (recebidos do servidor ou via exports)
local bpTiers = {}
local allBadges = {}
local allStickers = {}
local allCrafting = {}

-- Atualiza dados dinâmicos
addEvent("fxw:updateBattlepassTiers", true)
addEventHandler("fxw:updateBattlepassTiers", root, function(tiers)
    bpTiers = tiers
end)
addEvent("fxw:updateBadges", true)
addEventHandler("fxw:updateBadges", root, function(badges)
    allBadges = badges
end)
addEvent("fxw:updateStickers", true)
addEventHandler("fxw:updateStickers", root, function(stickers)
    allStickers = stickers
end)
addEvent("fxw:updateCrafting", true)
addEventHandler("fxw:updateCrafting", root, function(recipes)
    allCrafting = recipes
end)

-- Painel principal
function fxwShowPanel(tab)
    panel.visible = true
    panel.tab = tab or "battlepass"
    showCursor(true)
    addEventHandler("onClientRender", root, fxwDrawMainPanel)
end
function fxwHidePanel()
    panel.visible = false
    showCursor(false)
    removeEventHandler("onClientRender", root, fxwDrawMainPanel)
end

-- Tabs
local tabs = {
    {id="battlepass", label="Battlepass"},
    {id="badges", label="Badges"},
    {id="stickers", label="Stickers"},
    {id="crafting", label="Crafting"},
    {id="inventory", label="Inventário"}
}

function fxwDrawMainPanel()
    local sw, sh = guiGetScreenSize()
    local x, y, w, h = sw * 0.15, sh * 0.13, sw * 0.70, sh * 0.74
    dxDrawRectangle(x, y, w, h, c.bg, true)
    dxDrawText("ForgeX Weapons NextGen", x, y-38, x+w, y, c.accent, 2, c.font, "center", "center", true)
    -- Tabs
    for i,tab in ipairs(tabs) do
        local tx = x + 20 + (i-1)*150
        local sel = (panel.tab == tab.id)
        dxDrawRectangle(tx, y+16, 140, 44, sel and c.accent or tocolor(45,55,75,190), true)
        dxDrawText(tab.label, tx, y+16, tx+140, y+60, tocolor(255,255,255), 1.15, c.font, "center", "center", true)
        if isCursorOnElement(tx, y+16, 140, 44) and getKeyState("mouse1") then
            panel.tab = tab.id
        end
    end
    -- Painéis individuais
    if panel.tab == "battlepass" then fxwDrawBattlePassPanel(x+20, y+80, w-40, h-100)
    elseif panel.tab == "badges" then fxwDrawBadgesPanel(x+20, y+80, w-40, h-100)
    elseif panel.tab == "stickers" then fxwDrawStickersPanel(x+20, y+80, w-40, h-100)
    elseif panel.tab == "crafting" then fxwDrawCraftingPanel(x+20, y+80, w-40, h-100)
    elseif panel.tab == "inventory" then fxwDrawInventoryPanel(x+20, y+80, w-40, h-100)
    end
    -- Botão fechar
    dxDrawRectangle(x+w-60, y+20, 36, 36, tocolor(255,60,60,230), true)
    dxDrawText("X", x+w-60, y+20, x+w-24, y+56, tocolor(255,255,255), 1.2, c.font, "center", "center", true)
    if isCursorOnElement(x+w-60, y+20, 36, 36) and getKeyState("mouse1") then
        fxwHidePanel()
    end
end

-- Utilitário para área do mouse
function isCursorOnElement(x, y, w, h)
    if not isCursorShowing() then return false end
    local mx, my = getCursorPosition()
    local sw, sh = guiGetScreenSize()
    mx, my = mx * sw, my * sh
    return mx >= x and mx <= x + w and my >= y and my <= y + h
end

-- Recebe dados dinâmicos na abertura do painel
addCommandHandler("fxwpanel", function()
    triggerServerEvent("fxw:requestBattlepassTiers", resourceRoot)
    triggerServerEvent("fxw:requestBadges", resourceRoot)
    triggerServerEvent("fxw:requestStickers", resourceRoot)
    triggerServerEvent("fxw:requestCrafting", resourceRoot)
    fxwShowPanel()
end)

-- Atalhos para abrir o painel
bindKey("F5", "down", function() executeCommandHandler("fxwpanel") end)

-- Notificações (centralizadas)
addEvent("fxw:notify", true)
addEventHandler("fxw:notify", root, function(msg, color, tempo)
    -- Implemente aqui seu sistema de notificação, já centralizado!
    outputChatBox("[ForgeX] "..msg, color or c.accent)
end)