function fxwDrawBattlePassPanel(x, y, w, h)
    local xp = getElementData(localPlayer, "fxw:bp_xp") or 0
    for i, tier in ipairs(bpTiers) do
        local tx = x + 32 + (i-1) * (w-64) / #bpTiers
        local unlocked = xp >= tier.xp
        dxDrawRectangle(tx, y+40, 32, 32, unlocked and tocolor(255,200,0) or tocolor(80,80,80))
        dxDrawText(tier.xp.."xp", tx, y+76, tx+32, y+96, tocolor(255,255,255), 1, c.font, "center")
        if isCursorOnElement(tx, y+40, 32, 32) then
            dxDrawRectangle(x+w/2-80, y+120, 160, 60, tocolor(30,30,30,220))
            dxDrawText("Recompensa: "..tier.reward.type.." ("..tier.reward.id..")",
                x+w/2-70, y+130, x+w/2+70, y+170, c.accent, 1, c.font, "center")
        end
    end
    -- Barra de progresso
    local lastTier = bpTiers[#bpTiers] or {xp=1000}
    local prog = math.min(xp / lastTier.xp, 1)
    dxDrawRectangle(x+32, y+110, w-64, 18, tocolor(50,50,50,180))
    dxDrawRectangle(x+32, y+110, (w-64)*prog, 18, c.accent)
    dxDrawText("XP: "..xp.."/"..lastTier.xp, x, y+130, x+w, y+150, tocolor(255,255,255), 1, c.font, "center")
end