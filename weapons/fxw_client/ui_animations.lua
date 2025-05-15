-- Easing: outQuad
function fxwEaseOutQuad(t, b, c, d)
    t = t/d
    return -c * t*(t-2) + b
end

-- Animation state
local anims = {}
function fxwAnimate(id, from, to, duration)
    anims[id] = {from=from, to=to, startTick=getTickCount(), dur=duration}
end
function fxwGetAnim(id)
    local a = anims[id]
    if not a then return nil end
    local now = getTickCount() - a.startTick
    if now >= a.dur then return a.to end
    return fxwEaseOutQuad(now, a.from, a.to - a.from, a.dur)
end