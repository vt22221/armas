-- Atualize stats (kills, xp, cases, etc)
function fxwAddKill(player)
    local stats = getElementData(player, "fxw:stats") or {}
    stats.kills = (stats.kills or 0) + 1
    setElementData(player, "fxw:stats", stats)
end

function fxwGetLeaderboard()
    -- Exemplo: retorna top 10 por kills
    local players = getElementsByType("player")
    local leaderboard = {}
    for _,p in ipairs(players) do
        local stats = getElementData(p, "fxw:stats") or {}
        table.insert(leaderboard, {name=getPlayerName(p), kills=stats.kills or 0})
    end
    table.sort(leaderboard, function(a,b) return a.kills > b.kills end)
    return leaderboard
end