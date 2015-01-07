RegisterServerEvent('savePlayer')
RegisterServerEvent('loadPlayer')
print 'Loaded Save/Load plugin'
AddEventHandler('savePlayer', function(pos_x, pos_y, pos_z)
	local playername = GetPlayerName(source, _r)
	local f,err = io.open(playername .. ".account","w")
	if not f then return print(err) end
	f:write(pos_x .. "," .. pos_y .. "," .. pos_z)
	print("SERVER: " .. playername .. ".account has been saved")
	f:close()
end)

AddEventHandler('loadPlayer', function()
	local playername = GetPlayerName(source, _r)
	local file = io.open(playername .. ".account", "r")
	if file then
		io.input(file)
		local lines = io.read()
		local parts = lines:Split(",")
		-- file read. Thanks to NTAuthority`s advice
		TriggerClientEvent('updPlayer',source,
		tonumber(parts[0]),
		tonumber(parts[1]),
		tonumber(parts[2])) -- thanks to TheDeadlyDutchi
		print("SERVER: " .. playername .. ".account has been loaded")
	else
		file = io.open(playername .. ".account","w")
		file:write("2363.24,403.88,6.08") -- type in your DEFAULT spawn coords
		print("SERVER: " .. playername .. "`s account didn`t found. Creating new account.")
		TriggerClientEvent('updPlayer',source,2363.24,403.88,6.08)  -- type in your DEFAULT spawn coords
	end
	io.close(file)
end)

function Split(str, pat)
   local t = {}
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
     table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end