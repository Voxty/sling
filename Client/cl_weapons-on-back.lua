local SETTINGS = {
    back_bone = 24816,
	x = 0.10,
	y = 0.28,
	z = -0.05,
    x_rotation = 0.0,
    y_rotation = 165.0,
    z_rotation = 0.0,
    compatable_weapon_hashes = {
    ["w_ar_carbinerifle"] = -2084633992,
   
    }
}

local attached_weapons = {}
arsling = false
RegisterCommand("slingon", function(source, args, rawCommand)
	arsling = true
	
end, false)

RegisterCommand("slingoff", function(source, args, rawCommand)
	arsling = false
	
end, false)

Citizen.CreateThread(function()
  while true do
      local me = GetPlayerPed(-1)
      for wep_name, wep_hash in pairs(SETTINGS.compatable_weapon_hashes) do
          if HasPedGotWeapon(me, wep_hash, false) then
			if arsling and not attached_weapons[wep_name]then 
				 AttachWeapon(wep_name, wep_hash, SETTINGS.back_bone, SETTINGS.x, SETTINGS.y, SETTINGS.z, SETTINGS.x_rotation, SETTINGS.y_rotation, SETTINGS.z_rotation)
              
             end
			 
          end
      end
	 
      for name, attached_object in pairs(attached_weapons) do
          if arsling == false or GetSelectedPedWeapon(me) ==  attached_object.hash or not HasPedGotWeapon(me, attached_object.hash, false) then -- equipped or not in weapon wheel
            DeleteObject(attached_object.handle)
            attached_weapons[name] = nil
          end
		 
		  
      end
  Wait(0)
  end
end)

function AttachWeapon(attachModel,modelHash,boneNumber,x,y,z,xR,yR,zR)
	local bone = GetPedBoneIndex(GetPlayerPed(-1), boneNumber)
	RequestModel(attachModel)
	while not HasModelLoaded(attachModel) do
		Wait(100)
	end

  attached_weapons[attachModel] = {
    hash = modelHash,
    handle = CreateObject(GetHashKey(attachModel), 1.0, 1.0, 1.0, true, true, false)
  }

 
	AttachEntityToEntity(attached_weapons[attachModel].handle, GetPlayerPed(-1), bone, x, y, z, xR, yR, zR, 1, 1, 0, 0, 2, 1)
end
