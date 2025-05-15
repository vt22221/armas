local inspectState = {open=false, rot=0, tick=0, weapon=nil}

function fxwOpenInspect(weapon)
    inspectState.open = true
    inspectState.weapon = weapon
    inspectState.rot = 0
    inspectState.tick = getTickCount()
    addEventHandler("onClientRender", root, fxwDrawInspectPanel)
end
function fxwCloseInspect()
    inspectState.open = false
    removeEventHandler("onClientRender", root, fxwDrawInspectPanel)
end

function fxwDrawInspectPanel()
    local sw,sh = guiGetScreenSize()
    local x,y,W,H = sw*0.5-220, sh*0.5-220, 440, 440
    local t = (getTickCount()-inspectState.tick)/1500
    local alpha = math.min(255, t*255)
    dxDrawRectangle(x,y,W,H,tocolor(20,25,40,alpha))
    dxDrawText("Inspecionando: "..inspectState.weapon.name, x, y-36, x+W, y, fxwConfig.ui.accent, 1.5, fxwConfig.ui.font, "center")
    inspectState.rot = (inspectState.rot+1.3)%360
    -- Preview 3D animado: dxDrawImage3D/dxDrawMaterialLine3D/engineRenderModel
    -- Exemplo (substitua por seu render personalizado):
    dxDrawImage(x+60, y+60, 320, 320, "img/skins/"..inspectState.weapon.paint..".png", inspectState.rot)
    -- Efeitos: highlight, brilho, partículas DX, etc
    if isCursorOnElement(x+W-50,y+14,36,36) then
        if getKeyState("mouse1") then fxwCloseInspect() end
    end
    dxDrawRectangle(x+W-50,y+14,36,36,tocolor(255,60,60,220))
    dxDrawText("X",x+W-50,y+14,x+W-14,y+50,tocolor(255,255,255,alpha),1.2,fxwConfig.ui.font,"center","center")
end