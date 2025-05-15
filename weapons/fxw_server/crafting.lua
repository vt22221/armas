local craftingData = {}

-- Lê receitas do JSON
function loadCraftingData()
    local filePath = "fxw_data/crafting.json"
    craftingData = {}
    if fileExists(filePath) then
        local f = fileOpen(filePath)
        local raw = fileRead(f, fileGetSize(f))
        fileClose(f)
        local ok, data = pcall(fromJSON, raw)
        if ok and type(data) == "table" then
            for _, recipe in ipairs(data) do
                craftingData[recipe.id] = recipe -- {id=, name=, requires={...}, result={type=,id=}}
            end
        end
    end
end
addEventHandler("onResourceStart", resourceRoot, loadCraftingData)

-- Conta quantidade de um item específico no inventário
local function countInInventory(inv, typ, id)
    local c = 0
    for _,item in ipairs(inv) do
        if item.type == typ and item.id == id then c = c + 1 end
    end
    return c
end

-- Checa se o jogador tem todos requisitos para craftar a receita
function fxwCanCraft(player, recipeId)
    local recipe = craftingData[recipeId]
    if not recipe then return false, "Receita inválida" end
    local inv = getElementData(player, "fxw:inventory") or {}
    for _, req in ipairs(recipe.requires) do
        if countInInventory(inv, req.type, req.id) < (req.count or 1) then
            return false, "Faltam itens: "..req.type.." "..req.id
        end
    end
    return true
end

-- Remove os itens necessários (apenas se todos presentes)
local function consumeForCraft(player, recipe)
    local inv = getElementData(player, "fxw:inventory") or {}
    local toRemove = {}
    -- Mapeia itens a serem removidos
    for _, req in ipairs(recipe.requires) do
        local found = 0
        for idx, item in ipairs(inv) do
            if found >= (req.count or 1) then break end
            if item.type == req.type and item.id == req.id and not toRemove[idx] then
                toRemove[idx] = true
                found = found + 1
            end
        end
        if found < (req.count or 1) then return false end -- aborta se não houver todos
    end
    -- Remove todos de uma vez, do fim pro começo
    for idx = #inv, 1, -1 do if toRemove[idx] then table.remove(inv, idx) end end
    setElementData(player, "fxw:inventory", inv)
    return true
end

-- Crafta um item (server-side seguro)
function fxwCraft(player, recipeId)
    local recipe = craftingData[recipeId]
    if not recipe then
        triggerClientEvent(player, "fxw:notify", resourceRoot, "Receita inválida!", tocolor(255,80,80), 3400)
        return
    end
    local can, reason = fxwCanCraft(player, recipeId)
    if not can then
        triggerClientEvent(player, "fxw:notify", resourceRoot, reason, tocolor(255,80,80), 3400)
        return
    end
    if not consumeForCraft(player, recipe) then
        triggerClientEvent(player, "fxw:notify", resourceRoot, "Erro ao consumir itens!", tocolor(255,60,60), 3400)
        return
    end
    -- Dá o item/resultado
    fxwGiveItem(player, recipe.result.type, recipe.result.id)
    -- Atualiza stat de crafting (para badges)
    local stats = getElementData(player, "fxw:stats") or {}
    stats.crafting = (stats.crafting or 0) + 1
    setElementData(player, "fxw:stats", stats)
    if fxwCheckBadges then fxwCheckBadges(player) end
    triggerClientEvent(player, "fxw:notify", resourceRoot, "Craft concluído: "..(recipe.result.id), tocolor(80,220,255), 4200)
end

addEvent("fxw:craftItem", true)
addEventHandler("fxw:craftItem", root, function(recipeId)
    fxwCraft(client or source, recipeId)
end)