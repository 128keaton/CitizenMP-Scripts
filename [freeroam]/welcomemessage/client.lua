RegisterServerEvent('loadPlayer')

AddEventHandler('loadPlayer', function()
	DrawCurvedWindow(0.32,0.080,0.32,0.01,255)
 	displaytext(0.33,0.085,"Teleport: /tp [id] or [name]",255, 255, 255,255)
end)