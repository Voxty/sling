local displayText = true
local RequireInVehicleToUnrack = false
local RequireInVehicleToRack = false


local weaponTaken = false

RegisterNetEvent('unrack', userName, args)
RegisterNetEvent('rack', userName)

RegisterCommand("loadout", function ()
    RemoveAllPedWeapons(GetPlayerPed(-1), true)
    giveWeapon("weapon_combatpistol")
    weaponComponent("weapon_combatpistol", "COMPONENT_AT_PI_FLSH")
    giveWeapon("weapon_flashlight")
    giveWeapon("weapon_nightstick")
    giveWeapon("weapon_stungun")
    AddArmourToPed(GetPlayerPed(-1), 100)
    notify("~b~Police loadout has been loaded.")
    notify("~r~To receive a rifle or shotgun, you must type /unrack by a police vehicle.")
end)

AddEventHandler('unrack', function(userName, args)
    local player = GetPlayerPed(-1)
    if RequireInVehicleToUnrack == true then
        if IsPedInAnyVehicle(player, true) then
            if args[1] == "1" and weaponTaken == false then
                GiveAR(userName)
            elseif args[1] == "2" and weaponTaken == false then
                giveShotgun(userName)
            elseif args[1] == nil and weaponTaken == false  then
                notify("~r~Please specify a weapon type. /unrack 1 or 2 (1 = Carbine Rifle, 2 = Shotgun)")
            elseif weaponTaken == true then
                notify("~r~You already have a weapon unracked.")
            end
        else
            notify('~r~You must be in a vehicle to unrack your weapon.')
        end
    else
        if args[1] == "1" and weaponTaken == false then
            GiveAR(userName)
        elseif args[1] == "2" and weaponTaken == false then
            giveShotgun(userName)
        elseif args[1] == nil and weaponTaken == false  then
            notify("~r~Please specify a weapon type. /unrack 1 or 2 (1 = Carbine Rifle, 2 = Shotgun)")
        elseif weaponTaken == true then
            notify("~r~You already have a weapon unracked.")
        end
    end
end)

function GiveAR(userName)
    removeWeapon("weapon_pumpshotgun")
    removeWeapon("weapon_carbinerifle")
    giveWeapon("weapon_carbinerifle")
    weaponComponent("weapon_carbinerifle", "COMPONENT_AT_AR_FLSH")
    weaponComponent("weapon_carbinerifle", "COMPONENT_AT_SCOPE_MEDIUM")
    weaponComponent("weapon_carbinerifle", "COMPONENT_AT_AR_AFGRIP")
    if displayText == true then
        TriggerServerEvent("weaponUnracked", "assault rifle", userName)
    end
    notify('~b~Rifle has been unracked.')
    weaponTaken = true
end

function giveShotgun(userName)
    removeWeapon("weapon_pumpshotgun")
    removeWeapon("weapon_carbinerifle")
    giveWeapon("weapon_pumpshotgun")
    weaponComponent("weapon_pumpshotgun", "COMPONENT_AT_AR_FLSH")
    TriggerServerEvent("weaponUnracked", "shotgun", userName)
    notify('~b~Shotgun has been unracked.')
    weaponTaken = true
end

AddEventHandler("rack", function(userName)
    local ped = GetPlayerPed(-1)
    if RequireInVehicleToRack == true then
        if IsPedInAnyVehicle(ped) then
            if weaponTaken == true then
                notify("~b~Weapons racked.")
                removeWeapon("weapon_pumpshotgun")
                removeWeapon("weapon_carbinerifle")
                TriggerServerEvent("weaponRacked", userName)
                weaponTaken = false
            else
                notify('~r~You do not have a weapon unracked.')
            end
        else
            notify('~r~You must be in a vehicle to rack your weapon')
        end
    else
        if weaponTaken == true then
            notify("~b~Weapons racked.")
            removeWeapon("weapon_pumpshotgun")
            removeWeapon("weapon_carbinerifle")
            TriggerServerEvent("weaponRacked", userName)
            weaponTaken = false
        else
            notify('~r~You do not have a weapon unracked.')
        end
    end
end)