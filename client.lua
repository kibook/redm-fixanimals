local IsAnimal = false

function SetControlContext(pad, context)
	Citizen.InvokeNative(0x2804658EB7D8A50B, pad, context)
end

-- Change control context to OnMount when an animal ped to fix controls
CreateThread(function()
	local lastPed = 0

	while true do
		local ped = PlayerPedId()

		if ped ~= lastPed then
			if IsPedHuman(ped) then
				SetControlContext(2, 0)
				IsAnimal = false
			else
				SetControlContext(2, `OnMount`)
				IsAnimal = true
			end

			lastPed = ped
		end

		Wait(1000)
	end
end)

-- Disable first person mode as an animal since the camera is glitchy and may cause crashes
CreateThread(function()
	while true do
		if IsAnimal then
			DisableFirstPersonCamThisFrame()
		end

		Wait(0)
	end
end)
