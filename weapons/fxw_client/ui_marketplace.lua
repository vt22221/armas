local auctions = {} -- List from server

function fxwDrawMarketplacePanel(x, y, w, h)
    dxDrawText("Marketplace de Skins", x, y, x+w, y+36, fxwConfig.ui.accent, 1.5, fxwConfig.ui.font, "center")
    for i,auction in ipairs(auctions) do
        local ay = y+50+(i-1)*56
        dxDrawRectangle(x+12, ay, w-24, 48, tocolor(28,32,44,220))
        dxDrawImage(x+22, ay+6, 36, 36, fxwGetItemImage(auction.item))
        dxDrawText(auction.item.id, x+70, ay+5, x+200, ay+45, tocolor(255,255,255), 1, fxwConfig.ui.font, "left")
        dxDrawText("Vendedor: "..auction.seller, x+210, ay+5, x+370, ay+45, tocolor(180,210,255), 1, fxwConfig.ui.font, "left")
        dxDrawText("Lance: "..auction.price.." "..fxwConfig.economy.coin_name, x+400, ay+5, x+w-34, ay+45, tocolor(200,255,120), 1, fxwConfig.ui.font, "right")
        if isCursorOnElement(x+12, ay, w-24, 48) then
            dxDrawText("Clique para dar lance ou comprar!", x, ay+49, x+w, ay+75, tocolor(255,255,180), 1, fxwConfig.ui.font, "center")
            if getKeyState("mouse1") then
                triggerServerEvent("fxw:marketBid", resourceRoot, auction.id)
            end
        end
    end
end