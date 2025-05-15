function fxwDrawBadgesPanel(x, y, w, h)
    local badges = getElementData(localPlayer, "fxw:badges") or {}
    local col, sz = 6, 64
    for i, badge in ipairs(allBadges) do
        local cx = x+30+((i-1)%col)*sz*1.4
        local cy = y+30+math.floor((i-1)/col)*sz*1.4
        local unlocked = badges[badge.id] == true
        dxDrawImage(cx, cy, sz, sz, badge.icon, 0, 0, 0, unlocked and c.accent or tocolor(70,70,70,180))
        dxDrawText(badge.name, cx, cy+sz, cx+sz, cy+sz+18, unlocked and c.accent or tocolor(120,120,120), 0.85, c.font, "center")
    end
end