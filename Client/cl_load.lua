function msg(text)
    TriggerEvent("chatMessage", "[SYSTEM]", {255,0,0}, text)
end

function log(text)
    TriggerEvent("chatMessage", "[LOCAL LOG]", {0,0,255}, text)
end

function notify(msg)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(msg)
    DrawNotification(true,false)
end

function removeWeapon(hash)
    RemoveWeaponFromPed(GetPlayerPed(-1), GetHashKey(hash))
end

function giveWeapon(hash)
    GiveWeaponToPed(GetPlayerPed(-1), GetHashKey(hash), 100, false, true)
end

function weaponComponent(weapon, comp)
    if HasPedGotWeapon(GetPlayerPed(-1), GetHashKey(weapon), false) then
        GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey(weapon), GetHashKey(comp))
    end
end
