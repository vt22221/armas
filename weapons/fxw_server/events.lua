function fxwStartEvent(eventId)
    -- Ative bônus, altere drops, expanda lootboxes, etc
    triggerClientEvent(root, "fxw:eventStarted", resourceRoot, eventId)
end
addCommandHandler("startevent", function(p,_,eid)
    fxwStartEvent(eid)
end)