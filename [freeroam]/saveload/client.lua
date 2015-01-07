spawnx, spawny, spawnz = 2363.24341, 403.88696, 6.08523 -- THIS IS DEFAULT SPAWN COORDS (USE YOURS)
RegisterServerEvent('savePlayer')
RegisterServerEvent('loadPlayer')

AddEventHandler('updPlayer', function(part1, part2, part3)
	spawnx = part1
	spawny = part2
	spawnz = part3
	
	-- HERE WRITE YOUR SPAWN COMMAND (ex. exports.spawnmanager.spawnPlayer({blablabla}). I use my custom spawnmanager, because of speciality of gamemode. 
	RespPlayer(part1, part2, part3, 1)	
end)
function savePlayer(playerped)
	local possave = table.pack(GetCharCoordinates(GetPlayerPed(), _f, _f, _f))
	TriggerServerEvent('savePlayer',
	round(possave[1],2),
	round(possave[2],2),
	round(possave[3],2))
end



function round(num, idp)
  local mult = 10^(idp or 0)
  return math.floor(num * mult + 0.5) / mult
end

function RespPlayer(x, y, z, a) -- оптимизация
	CreateThread(function()
		----- spawn -----
		RequestCollisionAtPosn(x, y, z)
		ResurrectNetworkPlayer(GetPlayerId(), x, y, z, a)
		-----
		ClearCharTasksImmediately(GetPlayerPed())
		SetCharHealth(GetPlayerPed(), 200) 
		RemoveAllCharWeapons(GetPlayerPed())
		ClearWantedLevel(GetPlayerId())
		-----
		SetCharWillFlyThroughWindscreen(GetPlayerPed(), false)
		CamRestoreJumpcut(GetGameCam())
		-----
		ForceLoadingScreen(true)
		ForceLoadingScreen(false)
		----- model -- if you want to load with model
		--[[
		local lmod = GetHashKey('YOURMODELNAME', _r)
		LoadModel(lmod)
		ChangePlayerModel(GetPlayerId(), lmod)
		SetCharDefaultComponentVariation(GetPlayerPed())
		]]
		MarkModelAsNoLongerNeeded(lmod)
		SetCharHeading(GetPlayerPed(), spawna)
		DoScreenFadeIn(500)
		freezePlayer(GetPlayerId(), false)
	end)
end