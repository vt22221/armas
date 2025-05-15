function fxwMintNFT(player, skinId)
    local owner = getPlayerName(player)
    local tokenId = owner.."_"..skinId.."_"..getTickCount()
    local nftItem = {
        tokenId = tokenId,
        skinId = skinId,
        owner = owner,
        history = {
            {event="minted", date=os.date("%Y-%m-%d %H:%M:%S"), by=owner}
        }
    }
    local inv = getElementData(player, "fxw:nft_inventory") or {}
    table.insert(inv, nftItem)
    setElementData(player, "fxw:nft_inventory", inv)
    triggerClientEvent(player,"fxw:notify",resourceRoot,"NFT "..skinId.." mintado! Token: "..tokenId,tocolor(60,220,255),4500)
end

addCommandHandler("mintnft", function(p,_,skin)
    if not skin then outputChatBox("/mintnft skinid",p,255,0,0) return end
    fxwMintNFT(p, skin)
end)

addEvent("fxw:transferNFT",true)
addEventHandler("fxw:transferNFT",root,function(tokenId, toPlayerName)
    local inv = getElementData(client, "fxw:nft_inventory") or {}
    for idx,item in ipairs(inv) do
        if item.tokenId == tokenId then
            table.remove(inv, idx)
            setElementData(client, "fxw:nft_inventory", inv)
            for _,p in ipairs(getElementsByType("player")) do
                if getPlayerName(p) == toPlayerName then
                    local invTo = getElementData(p, "fxw:nft_inventory") or {}
                    item.owner = toPlayerName
                    table.insert(item.history, {event="transfer", date=os.date("%Y-%m-%d %H:%M:%S"), from=getPlayerName(client), to=toPlayerName})
                    table.insert(invTo, item)
                    setElementData(p, "fxw:nft_inventory", invTo)
                    triggerClientEvent(p,"fxw:notify",resourceRoot,"NFT "..item.skinId.." recebido!",tocolor(220,200,90),4200)
                    break
                end
            end
            break
        end
    end
end)