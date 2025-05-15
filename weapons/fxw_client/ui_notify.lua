local c = fxwConfig.ui
local notifications = {}
function showNotify(text,color,tempo)
    playSoundFrontEnd(12)
    table.insert(notifications,{text=text,color=color or c.accent,expire=getTickCount()+(tempo or 4000),alpha=0})
end
addEvent("fxw:notify",true)
addEventHandler("fxw:notify",root,showNotify)

addEventHandler("onClientRender",root,function()
    local y=265
    for _,v in ipairs(notifications) do
        if getTickCount()<v.expire then
            v.alpha=math.min(210,v.alpha+10)
            dxDrawRectangle(70,y,640,44,tocolor(0,0,0,v.alpha))
            dxDrawText(v.text,88,y+10,690,y+50,v.color,1.19,c.font)
            y=y+49
        end
    end
end)