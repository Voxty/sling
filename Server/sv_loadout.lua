RegisterServerEvent("weaponUnracked", weaponName, userName)
RegisterServerEvent("weaponRacked", userName)

AddEventHandler("weaponUnracked", function(weaponName, userName)
    TriggerClientEvent("chatMessage", -1, "[SYSTEM]", {255,0,0},"^1" ..userName..  " has unracked " ..weaponName.." from their vehicle")
end)

AddEventHandler("weaponRacked", function(userName)
    TriggerClientEvent("chatMessage", -1, "[SYSTEM]", {255,0,0},"^1" ..userName.. " has racked a weapon in their vehicle.")
end)

RegisterCommand('unrack', function (source, args)
    local userName = GetPlayerName(source)
    TriggerClientEvent('unrack',source, userName, args)
end)

RegisterCommand('rack', function (source)
    local userName = GetPlayerName(source)
    TriggerClientEvent('rack',source, userName)
end)