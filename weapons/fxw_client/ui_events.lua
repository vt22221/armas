function fxwDrawEventBanner(event)
    dxDrawRectangle(0, 0, 320, 52, tocolor(50,0,80,240))
    dxDrawText("Evento: "..event.name, 10, 10, 310, 42, tocolor(255,210,0), 1.25, "default-bold", "center")
end