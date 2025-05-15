local api_url = "http://localhost:3100/api/"
local config = fxwGetConfig()

addCommandHandler("fxw_api", function(player,cmd,token,action,arg)
    if not config.api.enable then return end
    if token ~= config.api_key then outputChatBox("API key inválida",player,255,0,0) return end
    if action == "inventory" and config.api.allow_inventory then
        local inv = getElementData(player,"fxw:weapons") or {}
        outputChatBox("Inventory: "..toJSON(inv),player,0,220,255)
    elseif action == "stats" and config.api.allow_stats then
        local xp = getElementData(player,"fxw:xp") or {}
        outputChatBox("Stats: "..toJSON(xp),player,0,220,255)
    elseif action == "badges" then
        local badges = getElementData(player,"fxw:badges") or {}
        outputChatBox("Badges: "..toJSON(badges),player,0,220,255)
    end
end)

function fxwSaveInventory(player)
    local inv = getElementData(player,"fxw:weapons") or {}
    local name = getPlayerName(player)
    fetchRemote(api_url.."inventory/"..urlEncode(name), {
        postData=toJSON({inventory=inv}),
        method="POST",
        headers={["Content-Type"]="application/json"}
    })
end

function fxwGetInventory(player, cb)
    local name = getPlayerName(player)
    fetchRemote(api_url.."inventory/"..urlEncode(name), function(data, err)
        if data then
            local inv = fromJSON(data).inventory
            cb(inv)
        end
    end)
end