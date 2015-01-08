	

    -- CLIENT SIDE SCRIPT
    spawnx, spawny, spawnz = 2363.24341, 403.88696, 6.08523 -- THIS IS DEFAULT SPAWN COORDS (USE YOURS)
     
    function savePlayer(playerped)
            local possave = table.pack(GetCharCoordinates(GetPlayerPed(), _f, _f, _f))
            local angle = GetCharHeading(GetPlayerPed(), _f)
            TriggerServerEvent('savePlayer',
            round(possave[1],2),
            round(possave[2],2),
            round(possave[3],2),
            round(angle,2))
    end
     
    function round(num, idp)
            local mult = 10^(idp or 0)
            return math.floor(num * mult + 0.5) / mult
    end
     
    AddEventHandler('updPlayer', function(part1, part2, part3,part4)
            spawnx = part1
            spawny = part2
            spawnz = part3
            spawna = part4
            RespPlayer(spawnx, spawny, spawnz, spawna)
    end)
     
    function RespPlayer(x, y, z, a) --[[ alternative spawner (you HAVE TO disable 'spawnmanager' in your server.yml before use this one ]]
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
                    -- model --
                    local lmod = GetHashKey('ig_brucie', _r) -- spawns a brucie model
                    LoadModel(lmod)
                    ChangePlayerModel(GetPlayerId(), lmod)
                    SetCharDefaultComponentVariation(GetPlayerPed())
                    MarkModelAsNoLongerNeeded(lmod)
                    SetCharHeading(GetPlayerPed(), spawna)
                    DoScreenFadeIn(500)
                    freezePlayer(GetPlayerId(), false)
            end)
    end
     
    function LoadModel(modelid)
            if not HasModelLoaded(modelid) then
                    RequestModel(modelid)
                    while not HasModelLoaded(modelid) do
                            Wait(0)
                    end
            end
    end
     
    function respawnDeath(spawner, timercount)
            CreateThread(function()
                    Wait(timercount)
                    TriggerServerEvent('loadPlayer')
            end)
    end
     
    AddEventHandler('playerActivated', function()
            TriggerServerEvent('loadPlayer')
    end)
     
    AddEventHandler('onPlayerDied', function(playerId, reason, position)
            savePlayer(GetPlayerPed())
            respawnDeath(GetPlayerPed(), 10000) -- set re-spawn (id, timer)
    end)

