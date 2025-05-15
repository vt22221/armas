local c = fxwConfig.ui

function fxwDrawLeaderboardPanel(x, y, w, h)
    local lb = triggerServerEvent("fxw:getLeaderboard", resourceRoot)
    dxDrawText("Top 10 Jogadores - Kills", x, y, x+w, y+24, c.accent, 1.3, c.font, "center")
    for i=1,math.min(10,#lb) do
        local p = lb[i]
        dxDrawText(i..". "..p.name.." - "..p.kills.." kills", x+40, y+30+i*28, x+w, y+30+(i+1)*28, tocolor(255,255,255), 1, c.font)
    end
end