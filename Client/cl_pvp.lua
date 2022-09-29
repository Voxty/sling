Citizen.CreateThread(function()
         while true do
            Citizen.Wait(10)
            SetCanAttackFriendly(GetPlayerPed(-1), true, false)
            NetworkSetFriendlyFireOption(true)
         end
end)