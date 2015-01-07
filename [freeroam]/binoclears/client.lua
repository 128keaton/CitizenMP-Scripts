pl_state = 0
key_for_use = 18 -- YOU CAN USE YOUR OWN HERE

CreateThread(function()
	while true do
		Wait(0)
		if IsGameKeyboardKeyJustPressed(key_for_use) then
            if pl_state == 0 then
				SetSpritesDrawBeforeFade(1)
				ForceGameTelescopeCam(1)
				bintxd = LoadTxd('binoculars')
				bintexture = GetTexture(bintxd, 'binoculars')
				DisplayRadar(0)
				pl_state = 1
			elseif pl_state == 1 then
				pl_state = 0
				SetSpritesDrawBeforeFade(0)
                            ForceGameTelescopeCam(0) -- actually dont work for now
				ReleaseTexture(bintexture)
				RemoveTxd(bintxd)
				DisplayRadar(1)
			end
		else
			if pl_state == 1 then
				-- this is cycled function
				DrawSprite( bintexture, 0.5, 0.5, 1.37, -1.12, 0.0, 255, 255, 255, 255)
			end
		end
	end
end)