--[[
   Original Code: Kenuvis
   Build 213 user_version
   KI Build 1
   ----------------------
   Dont delete my Credits!!!
-------------------------------------------------------------------------------
   LUAppArc Scripting Project.
   SVN: http://svn.assembla.com/svn/LUAppArc
   LOG: http://burning-azzinoth.de/arcemu/new/frontend/?t=2
-------------------------------------------------------------------------------
  LUAppArc at rev5 or higher is needed by this script!! Else it WILL NOT WORK
-----------------------------------------------------------------------------]]

--User Area
------------

--if someone wins, he would random get one of these items
Reward_Items = {1360,1359}

--size of one chessfield (developed for 6)
size = 6

--If all Units stop working, whatever happened, after this time,
--it should be work again. (reset = true/false; time in ms)
reset = true
auto_reset_timer = 180000

--i hope, its clear (autosave = true/false; time in ms)
autosave = false
autosave_timer = 180000

--Max.count of Saves. If the limit is exceeded, the oldest save would be delete.
max_save = 20

--Time in milliseconds, until a Unit would be selected, during stand in the Unit
Select_Timer = 3000

--Time in seconds to move a NPC or select another
Pawn_Timer = 8
Castle_Timer = 10
Horse_Timer = 8
Bishop_Timer = 10
Queen_Timer = 10
King_Timer = 8

--NPC to start the Event (gossiptalk)
Start_NPC = 198765
--little Eventmanager (only for holding some functions)
Manage_NPC = 198766

------------------------
--User Area ends here!--
------------------------

RegisterUnitEvent(Manage_NPC, 18, "EventManage")
RegisterUnitGossipEvent(Start_NPC, 1, "EventStart")
RegisterUnitGossipEvent(Start_NPC, 2, "GossipSelect")

RegisterUnitEvent(17469, 18, "Horde_Bauer")    --1
RegisterUnitEvent(21726, 18, "Horde_Turm")     --2
RegisterUnitEvent(21748, 18, "Horde_Pferd")    --3
RegisterUnitEvent(21747, 18, "Horde_Laufer")   --4
RegisterUnitEvent(21750, 18, "Horde_Konigin")  --5
RegisterUnitEvent(21752, 18, "Horde_Konig")    --6

RegisterUnitEvent(17211, 18, "Allianz_Bauer")  --7
RegisterUnitEvent(21160, 18, "Allianz_Turm")   --8
RegisterUnitEvent(21664, 18, "Allianz_Pferd")  --9
RegisterUnitEvent(21682, 18, "Allianz_Laufer") --10
RegisterUnitEvent(21683, 18, "Allianz_Konigin")--11
RegisterUnitEvent(21684, 18, "Allianz_Konig")  --12

RegisterUnitEvent(21752, 4, "Horde_Konig_Dead")
RegisterUnitEvent(21684, 4, "Allianz_Konig_Dead")

Schachspiel = 0
Schachbrett = {}
Pos = {}
Pos2 = {}
Move = {}
en_passant = {}
Player_list = {}
Players = {}
game_mode = {0}
Ply = 0
Game_over_timer = 30
KI = false

KI_Chess = {}
Wertigkeit = {2,10,6,6,20,100,2,10,6,6,20,100}
KI_Wert = {}

print ("################################")
print ("# ChessEventScript B211uv KI1 ")
print ("# Code by Kenuvis")
print ("# LUAppArc Scripting Project")
print(string.format("# StartNPC %s", Start_NPC))
print ("################################")

function EventManage(Unit)
	Schachbrett[9][4] = Unit
	Unit:RegisterEvent("auto_reset", auto_reset_timer, 0)
	Unit:RegisterEvent("auto_save", autosave_timer, 0)
end

function EventStart(Unit, Event, Player)
    if (Schschspiel == -1) then return end
	
	if (game_mode[1] ~= 0) then
		Unit:GossipCreateMenu(20013, game_mode[2], 0)
		Unit:GossipMenuAddItem(30, "...annehmen. (ich will Allianz)", 2000, 0)
		Unit:GossipMenuAddItem(30, "...annehmen. (ich will Horde)", 2001, 0)
		Unit:GossipMenuAddItem(30, "...ablehnen.", 2002, 0)
		Unit:GossipSendMenu(game_mode[2])
		return
	end	
	
	Unit:GossipCreateMenu(20010, Player, 0)

	if (table.getn(read_file("scripts/chess_gamesave.txt")) > 0) or (table.getn(read_file("scripts/chess_autosave.txt")) > 0) then
		Unit:GossipMenuAddItem(19, "Load", 1, 0)
	end

	if (Schachspiel ~= 0) then
  		Unit:GossipMenuAddItem(19, "Save", 2, 1)
    	Unit:GossipMenuAddItem(19, "Restart", 3, 0)
    	Unit:GossipMenuAddItem(16, "Quit", 4, 0)
	else
	    Unit:GossipMenuAddItem(17, "Start", 5, 0)
	end

    Unit:GossipMenuAddItem(19, "Script Reset", 12, 0)
	Unit:GossipSendMenu(Player)
end

function GossipSelect(Unit, Event, Player, MenuId, id, Code)
	if(id == 0) then
		Player_list = {}
		EventStart(Unit,Event, Player)
		return
	else
        Unit:GossipCreateMenu(20011, Player, 0)
        Unit:GossipMenuAddItem(21, "[..]", 0, 0)
	end

	if (id == 1) then
        if (table.getn(read_file("scripts/chess_gamesave.txt")) > 0) then
			Unit:GossipMenuAddItem(30, "Gamesave", 6, 0)
		end
        if (table.getn(read_file("scripts/chess_autosave.txt")) > 0) then
			Unit:GossipMenuAddItem(30, "Autosave", 7, 0)
		end
        Unit:GossipSendMenu(Player)
	elseif (id == 2) then
  		game_save("scripts/chess_gamesave.txt", Code)
		Player:SendBroadcastMessage("Game saved")
		Unit:GossipComplete(Player)
	elseif (id == 3) then
        Unit:GossipMenuAddItem(30, "Yes, of course. I'm sure.", 8, 0)
        Unit:GossipMenuAddItem(30, "No!!!!", 0, 0)
        Unit:GossipSendMenu(Player)
    elseif (id == 4) then
        Unit:GossipMenuAddItem(30, "Quit and save", 10, 1)
        Unit:GossipMenuAddItem(30, "Quit without save", 11, 0)
        Unit:GossipSendMenu(Player)
	elseif (id == 5) then
		if (table.getn(Player_list) > 0) then
			Player:SendBroadcastMessage("Es steht noch eine Herausforderung offen.")
			Unit:GossipMenuAddItem(30, "Herausforderung zur\195\188ckziehen!", 1600, 0)
			Unit:GossipSendMenu(Player)
		else
			
			Unit:GossipCreateMenu(20012, Player, 0)
	        Unit:GossipMenuAddItem(21, "[..]", 0, 0)
	        --Unit:GossipMenuAddItem(30, "Gegen Computer antreten", 1550, 0)
	        
			for a = 1,20,1 do
				target = Player:GetRandomPlayer(0)	
				if not already_see(target, Player_list) then
					table.insert(Player_list, target)
					Unit:GossipMenuAddItem(30, target:GetName(), 1000+table.getn(Player_list), 0)
				end
			end
			table.insert(Player_list, 1, Player)
			Unit:GossipSendMenu(Player)
		end
	elseif (id > 1000) and (id < 1500) then
		Player:SendBroadcastMessage("Herausforderung wird gesendet. Das Spiel beginnt, wenn die Herausforderung vom Gegner innerhalb von 30 Sekunden angenommen wird.")
		Unit:RegisterEvent("Batlle_Timer", 30000, 0)

		Player_list[id-999]:SendBroadcastMessage("Du wurdest von "..Player:GetName().." zu einer Partie Schach herausgefordert. Sprich den Schachmeister an, um sie anzunehmen.")
		game_mode[1] = 1
		game_mode[2] = Player_list[id-999]
	elseif (id == 1550) then
        Unit:GossipComplete(Player)
		--Players = {Player, "ki"}
		Players = {Player, Player}
		Players[1]:SendBroadcastMessage("Du bist Horde.")
		game_new(Unit)
		Schachspiel = 1	
		Unit:MoveTo(Unit:GetX() - 4 * size, Unit:GetY(), Unit:GetZ(), 6.235291)
		Unit:SpawnCreature(Manage_NPC, Unit:GetX() - 4 * size-0.5, Unit:GetY()-0.5, Unit:GetZ(), 6.235291, 35, 0)
	elseif (id == 1600) then
		game_mode[1] = 0
		Player_list = {}
		
		Player:SendBroadcastMessage("Die Herausforderung wurde zur\195\188ckgezogen!")
		game_mode[2]:SendBroadcastMessage("Die Herausforderung wurde zur\195\188ckgezogen!")	
	
	elseif (id == 2000) then
		Players = {Player_list[1], Player}        
        Players[1]:SendBroadcastMessage("Du bist Horde.")
        Players[2]:SendBroadcastMessage("Du bist Allianz.")
		        
        if (game_mode[1] == 1) then
			-- Position des Schachfeld
			Schachbrett[9] = {}
			Schachbrett[9][1] = Unit:GetX() - 3.5 * size
			Schachbrett[9][2] = Unit:GetY() - 3.5 * size
			Schachbrett[9][3] = Unit:GetZ()
			
			game_new(Unit)
			
			Unit:MoveTo(Unit:GetX() - 4 * size, Unit:GetY(), Unit:GetZ(), 6.235291)
			Unit:SpawnCreature(Manage_NPC, Unit:GetX() - 4 * size-0.5, Unit:GetY()-0.5, Unit:GetZ(), 6.235291, 35, 0)
			
		elseif (game_mode[1] == 2) then	
			
			if (Schachbrett[9] == nil) then
				-- Position des Schachfeld
				Schachbrett[9] = {}
				Schachbrett[9][1] = Unit:GetX() - 3.5 * size
				Schachbrett[9][2] = Unit:GetY() - 3.5 * size
				Schachbrett[9][3] = Unit:GetZ()
	            Unit:MoveTo(Unit:GetX() - 4 * size, Unit:GetY(), Unit:GetZ(), 6.235291)
				Unit:SpawnCreature(Manage_NPC, Unit:GetX() - 4 * size-0.5, Unit:GetY()-0.5, Unit:GetZ(), 6.235291, 35, 0)
			else
				clear_field()
			end
		    game_load(loc[1], loc[2])
		
	    end		
		
	    Unit:GossipComplete(Player)
	    Unit:GossipComplete(game_mode[2])
	    
	    Player_list = {}
	    game_mode[1] = 0
	elseif (id == 2001) then
		Players = {Player, Player_list[1]} 
        Players[1]:SendBroadcastMessage("Du bist Horde.")
        Players[2]:SendBroadcastMessage("Du bist Allianz.")
		        
        if (game_mode[1] == 1) then			
			game_new(Unit)
			
			Unit:MoveTo(Unit:GetX() - 4 * size, Unit:GetY(), Unit:GetZ(), 6.235291)
			Unit:SpawnCreature(Manage_NPC, Unit:GetX() - 4 * size-0.5, Unit:GetY()-0.5, Unit:GetZ(), 6.235291, 35, 0)
			
		elseif (game_mode[1] == 2) then	
			
			if (Schachbrett[9] == nil) then
				-- Position des Schachfeld
				Schachbrett[9] = {}
				Schachbrett[9][1] = Unit:GetX() - 3.5 * size
				Schachbrett[9][2] = Unit:GetY() - 3.5 * size
				Schachbrett[9][3] = Unit:GetZ()
	            Unit:MoveTo(Unit:GetX() - 4 * size, Unit:GetY(), Unit:GetZ(), 6.235291)
				Unit:SpawnCreature(Manage_NPC, Unit:GetX() - 4 * size-0.5, Unit:GetY()-0.5, Unit:GetZ(), 6.235291, 35, 0)
			else
				clear_field()
			end
		    game_load(loc[1], loc[2])
		
	    end
		
	    Unit:GossipComplete(Player)
	    Unit:GossipComplete(game_mode[2])
	    Player_list = {}
	    game_mode[1] = 0
	elseif (id == 2002) then
		Player:SendBroadcastMessage("Du hast die Herausforderung abgelehnt!")
		Player_list[1]:SendBroadcastMessage("Herausforderung wurde von "..Player:GetName().." abgelehnt!")
		Player_list = {}
		Unit:RemoveEvents()
		Unit:GossipComplete(Player)
	elseif (id == 6) then
	    local _table = read_file("scripts/chess_gamesave.txt")
	    
        for a, index in ipairs(_table) do
            temp = os.date("*t", index[2])
            Unit:GossipMenuAddItem(30, index[1].." / "..temp.day.."."..temp.month.." - "..temp.hour..":"..temp.min, 20+a, 0)
		end
		Unit:GossipSendMenu(Player)
	elseif (id == 7) then
	    local _table = read_file("scripts/chess_autosave.txt")

        for a, index in ipairs(_table) do
            temp = os.date("*t", a)
            Unit:GossipMenuAddItem(30, temp.day.."."..temp.month.." - "..temp.hour..":"..temp.min, 20+a+max_save, 0)
		end
		Unit:GossipSendMenu(Player)
	elseif (id == 8) then
      	clear_field()
      	game_new(Unit)
      	Unit:GossipComplete(Player)
	elseif (id == 10) then
  		game_save("scripts/chess_gamesave.txt", Code)
  		Player:SendBroadcastMessage("Game saved")
		Unit:GossipComplete(Player)
		Schachbrett[9][4]:Despawn(1,0)
		Players = {}
		clear_field()
		Unit:MoveTo(Unit:GetX() + 4 * size, Unit:GetY(), Unit:GetZ(), 6.235291)
		Unit:GossipComplete(Player)
	elseif (id == 11) then
	    clear_field()
		Schachbrett[9][4]:Despawn(1,0)
		Players = {}
	    Unit:MoveTo(Unit:GetX() + 4 * size, Unit:GetY(), Unit:GetZ(), 6.235291)
	    Unit:GossipComplete(Player)
	elseif (id == 12) then
		if (table.getn(Schachbrett) >= 9) then
			auto_reset(Schachbrett[9][4])
		else
			Player:SendBroadcastMessage("Es gibt kein Feld zu resetten")
		end
	    Unit:GossipComplete(Player)
	end
	
	if (id > 20) and (id < 20+max_save) then
		loc = {"scripts/chess_gamesave.txt", id-20}
	elseif (id > 20+max_save) and (id < 20+2*max_save) then
		loc = {"scripts/chess_autosave.txt", id-20+max_save}
	end
	
	if (id > 20) and (id < 20-2*max_save) then
		if (table.getn(Player_list) > 0) then
			Player:SendBroadcastMessage("Es steht noch eine Herausforderung offen.")
			Unit:GossipComplete(Player)
		else
			
			Unit:GossipCreateMenu(20012, Player, 0)
	        Unit:GossipMenuAddItem(21, "[..]", 0, 0)
	        
			for a = 1,20,1 do
				target = Unit:GetRandomPlayer(0)	
				if not already_see(target, Player_list) then
					table.insert(Player_list, target)
					Unit:GossipMenuAddItem(30, target:GetName(), 3000+table.getn(Player_list), 0)
				end
			end
			table.insert(Player_list, 1, Player)
			Unit:GossipSendMenu(Player)
		end
	elseif (id > 3000) and (id < 3500) then
		Player:SendBroadcastMessage("Herausforderung wird gesendet. Das Spiel beginnt, wenn die Herausforderung vom Gegner innerhalb von 30 Sekunden angenommen wird.")
		Unit:RegisterEvent("Batlle_Timer", 30000, 0)
		
		Player_list[id-2999]:SendBroadcastMessage("Du wurdest von "..Player:GetName().." zu einer Partie Schach herausgefordert. Sprich den Schachmeister an, um sie anzunehmen.")

		game_mode[1] = 2
		game_mode[2] = Player_list[id-2999]
	end 	
end

function game_new(Unit)
	print "Schachevent start..."
	
	local x = Unit:GetX()
	local y = Unit:GetY()
	local z = Unit:GetZ()
	
	-- Spieleranfang
	math.randomseed(os.time())
	for i=1,math.random(10,50),1 do
		Schachspiel = math.random(1,2)
	end
	if (Schachspiel == 1) then
		print "Horde start"
	else
	    print "Allianz start"
	end
	
	for a = 1,8,1 do
	    Schachbrett[a] = {}
	    for b = 1,8,1 do
	        Schachbrett[a][b] = {0,0}
		end
	end

	-- Position des Schachfeld
	Schachbrett[9] = {}
	Schachbrett[9][1] = Unit:GetX() - 3.5 * size
	Schachbrett[9][2] = Unit:GetY() - 3.5 * size
	Schachbrett[9][3] = Unit:GetZ()

	print "Virtuelles Schachbrett init..."

	e1 = 3.5 * size
	e2 = 2.5 * size
	e3 = 1.5 * size
	e4 = 0.5 * size
    -- spawn horde seite
	-- bauern
	Unit:SpawnCreature(17469, x+e1, y+e2, z, 4.680203, 35, 0)
	Unit:SpawnCreature(17469, x+e2, y+e2, z, 4.680203, 35, 0)
	Unit:SpawnCreature(17469, x+e3, y+e2, z, 4.680203, 35, 0)
	Unit:SpawnCreature(17469, x+e4, y+e2, z, 4.680203, 35, 0)
	Unit:SpawnCreature(17469, x-e4, y+e2, z, 4.680203, 35, 0)
	Unit:SpawnCreature(17469, x-e3, y+e2, z, 4.680203, 35, 0)
	Unit:SpawnCreature(17469, x-e2, y+e2, z, 4.680203, 35, 0)
	Unit:SpawnCreature(17469, x-e1, y+e2, z, 4.680203, 35, 0)
	-- t?rme
	Unit:SpawnCreature(21726, x+e1, y+e1, z, 4.680203, 35, 0)
	Unit:SpawnCreature(21726, x-e1, y+e1, z, 4.680203, 35, 0)
	-- pferd
	Unit:SpawnCreature(21748, x+e2, y+e1, z, 4.680203, 35, 0)
	Unit:SpawnCreature(21748, x-e2, y+e1, z, 4.680203, 35, 0) 
	-- l?ufer
	Unit:SpawnCreature(21747, x+e3, y+e1, z, 4.680203, 35, 0)
	Unit:SpawnCreature(21747, x-e3, y+e1, z, 4.680203, 35, 0) 
	-- k?nigin
	Unit:SpawnCreature(21750, x+e4, y+e1, z, 4.680203, 35, 0) 
	-- k?nig
	Unit:SpawnCreature(21752, x-e4, y+e1, z, 4.680203, 35, 0)
	
	-- spawn allianz seite
	-- bauern
	Unit:SpawnCreature(17211, x+e1, y-e2, z, 1.562182, 35, 0)
	Unit:SpawnCreature(17211, x+e2, y-e2, z, 1.562182, 35, 0)
	Unit:SpawnCreature(17211, x+e3, y-e2, z, 1.562182, 35, 0)
	Unit:SpawnCreature(17211, x+e4, y-e2, z, 1.562182, 35, 0)
	Unit:SpawnCreature(17211, x-e4, y-e2, z, 1.562182, 35, 0)
	Unit:SpawnCreature(17211, x-e3, y-e2, z, 1.562182, 35, 0)
	Unit:SpawnCreature(17211, x-e2, y-e2, z, 1.562182, 35, 0)
	Unit:SpawnCreature(17211, x-e1, y-e2, z, 1.562182, 35, 0) 
	-- t?rme
	Unit:SpawnCreature(21160, x+e1, y-e1, z, 1.562182, 35, 0)
	Unit:SpawnCreature(21160, x-e1, y-e1, z, 1.562182, 35, 0)
	-- pferd
	Unit:SpawnCreature(21664, x+e2, y-e1, z, 1.562182, 35, 0)
	Unit:SpawnCreature(21664, x-e2, y-e1, z, 1.562182, 35, 0)
	-- l?ufer
	Unit:SpawnCreature(21682, x+e3, y-e1, z, 1.562182, 35, 0)
	Unit:SpawnCreature(21682, x-e3, y-e1, z, 1.562182, 35, 0)
	-- k?nigin
	Unit:SpawnCreature(21683, x+e4, y-e1, z, 1.562182, 35, 0) 
	-- k?nig
	Unit:SpawnCreature(21684, x-e4, y-e1, z, 1.562182, 35, 0)
		
	print "Alle Schachfiguren gespawnt..."
end

function game_over(Unit)
	if Game_over_timer == 30 then
		Unit:SendChatMessage(12, 0, string.format("%s seconds, until game over.", Game_over_timer))
	elseif Game_over_timer == 20 then
        Unit:SendChatMessage(12, 0, string.format("%s seconds, until game over.", Game_over_timer))
    elseif Game_over_timer == 15 then
        Unit:SendChatMessage(12, 0, string.format("%s seconds, until game over.", Game_over_timer))
    elseif Game_over_timer == 10 then
        Unit:SendChatMessage(12, 0, string.format("%s seconds, until game over.", Game_over_timer))
    elseif Game_over_timer < 10 then
        Unit:SendChatMessage(12, 0, string.format("%s seconds, until game over.", Game_over_timer))
    end
    
    Game_over_timer = Game_over_timer -1
    
    if (Game_over_timer == 0) then
    	clear_field()
		Schachbrett[9][4]:Despawn(1,0)
		Schachspiel = 0
		Player_List = {}
		game_mode = {0}
	end
end

--------------------------------------------------
------       private functions Anfang       ------
--------------------------------------------------

function comparing(_x1, _y1, _x2, _y2)
	if (_x1 == _x2) and (_y1 == _y2) then
		return true
	else
		return false
	end
end

function xyi_Output(_Unit)
	if (_Unit == nil) or (type(_Unit) ~= "userdata") then
		return 0,0,0
	end

	x = 0
	repeat
		x = x+1
		
		if (x > 8) then
			x = 0
			break
		end
	until (_Unit:GetX() < (Schachbrett[9][1]-size) + (x*size)+(size/2)) and (_Unit:GetX() > (Schachbrett[9][1]-size) + (x*size)-(size/2))

	y = 0
	repeat
		y = y+1
		
		if (y > 8) then
			y = 0
			break
		end	
	until(_Unit:GetY() > (Schachbrett[9][2]-size) + (y*size)-(size/2)) and (_Unit:GetY() < (Schachbrett[9][2]-size) + (y*size)+(size/2))
	
	i = 0
	if (x ~= 0) and (y ~= 0) then                     
		if (table.getn(Schachbrett[x][y]) > 1) then
			if (Schachbrett[x][y][2] < 7) and (Schachbrett[x][y][2] > 0) then
				i = 1
			elseif (Schachbrett[x][y][2] > 6) and (Schachbrett[x][y][2] < 13) then
				i = 2
			end
		end
	end
	
	return x, y, i
end

function Check_Feld_AR(_x, _y, _array)
	if (_x < 1) or (_y < 1) or (_x > 8) or (_y > 8) then
		return 3
	end
	
	if (_array[_x][_y] == 0) then
		return 0
	end
	
	if (_array[_x][_y] < 7) then
		return 1
	end
	
	if (_array[_x][_y] > 6) then
		return 2
	end
	
	return 0
end

function Check_Feld(_x, _y)
	if (_x < 1) or (_y < 1) or (_x > 8) or (_y > 8) then
		return 3
	end
	
	if (Schachbrett[_x][_y][2] == 0) then
		return 0
	end
	
	if (Schachbrett[_x][_y][2] < 7) then
		return 1
	end
	
	if (Schachbrett[_x][_y][2] > 6) then
		return 2
	end
	
	return 0
end

function display_board(_Unit, _time)
	for a=-(size/2),(7.5*size),size do
		for b=-(size/2),(7.5*size),size do
			_Unit:SpawnGameObject(1607, Schachbrett[9][1]+a, Schachbrett[9][2]+b, _Unit:GetZ(), 4.71, _time)
		end
	end
	
	c = 0
	
	for a = 0, 7*size, size do
		c = math.abs(c - size)
		for b = c, 7*size, size*2 do
			_Unit:SpawnGameObject(183320, Schachbrett[9][1]+a, Schachbrett[9][2]+b, _Unit:GetZ(), 4.71, _time)
		end
	end	
end	

function Select(_Unit)
	_Unit:CastSpell(32261)
		display_board(_Unit, 3000)
end

function game_save(dir, str)
	if (io.open(dir,"r") == nil) then
		io.open(dir,"w")
	end	
	
	local f = assert(io.open(dir,"r"))
	
	temp = ""
	for a = 1,8,1 do
	    for b = 1,8,1 do
	        if (type(Schachbrett[a][b][1]) == "userdata") then
	            temp = string.format("%s%s%s%s ", temp, a, b, Schachbrett[a][b][2])
			end
		end
	end
	
	save = string.format("%s %s %s %s", str, os.time(), Schachspiel, temp)

	save_table = {}
 	temp = f:read("*l")
	
	while temp ~= nil do
		table.insert(save_table, temp)
		temp = f:read("*l")
 	end
 	
  	table.insert(save_table, save)
	
	while (table.getn(save_table) > max_save) do
		save_table[max_save+1] = nil
	end
	
	f:close()
	local f = assert(io.open(dir,"w+"))
	
	str = ""
	for i, l in pairs(save_table) do
		str = string.format("%s%s%s", str,l,"\n")
	end
	f:write(str)
	f:close() 
end

function game_load(dir, ID)
	for a = 1,8,1 do
	    Schachbrett[a] = {}
	    for b = 1,8,1 do
	        Schachbrett[a][b] = {0,0}
		end
	end
     
	local _table = read_file(dir)
	Schachspiel = _table[ID][3]
	Schachspiel = math.abs(Schachspiel)
	
    for i=4,table.getn(_table[ID])-1,1 do
   		a = string.sub(_table[ID][i], 1, 1)
        b = string.sub(_table[ID][i], 2, 2)
        c = string.sub(_table[ID][i], 3)

        a = Schachbrett[9][1]+(a-1)*size
        b = Schachbrett[9][2]+(b-1)*size
        c = math.abs(c)

        if (c == 1) then
        	Schachbrett[9][4]:SpawnCreature(17469, a, b, Schachbrett[9][3], 4.680203, 35, 0)
		elseif (c == 2) then
            Schachbrett[9][4]:SpawnCreature(21726, a, b, Schachbrett[9][3], 4.680203, 35, 0)
		elseif (c == 3) then
		    Schachbrett[9][4]:SpawnCreature(21748, a, b, Schachbrett[9][3], 4.680203, 35, 0)
		elseif (c == 4) then
		    Schachbrett[9][4]:SpawnCreature(21747, a, b, Schachbrett[9][3], 4.680203, 35, 0)
		elseif (c == 5) then
		    Schachbrett[9][4]:SpawnCreature(21750, a, b, Schachbrett[9][3], 4.680203, 35, 0)
		elseif (c == 6) then
		    Schachbrett[9][4]:SpawnCreature(21752, a, b, Schachbrett[9][3], 4.680203, 35, 0)
		elseif (c == 7) then
		    Schachbrett[9][4]:SpawnCreature(17211, a, b, Schachbrett[9][3], 1.562182, 35, 0)
		elseif (c == 8) then
		    Schachbrett[9][4]:SpawnCreature(21160, a, b, Schachbrett[9][3], 1.562182, 35, 0)
		elseif (c == 9) then
		    Schachbrett[9][4]:SpawnCreature(21664, a, b, Schachbrett[9][3], 1.562182, 35, 0)
		elseif (c == 10) then
		    Schachbrett[9][4]:SpawnCreature(21682, a, b, Schachbrett[9][3], 1.562182, 35, 0)
		elseif (c == 11) then
		    Schachbrett[9][4]:SpawnCreature(21683, a, b, Schachbrett[9][3], 1.562182, 35, 0)
		elseif (c == 12) then
		    Schachbrett[9][4]:SpawnCreature(21684, a, b, Schachbrett[9][3], 1.562182, 35, 0)
  		end

	end

	who_is(Schachbrett[9][4])
end

function read_file(dir)
	if (io.open(dir,"r") == nil) then
		return {}
	end

	local f = io.open(dir, "r")
    local count = 1
    local return_value = {}

    t = f:read("*line")
  	while t ~= nil do
  	    local a = 1
  	    return_value[count] = {}

		i =0
		repeat
   			i = i+1
   			
       		if (string.sub(t, i, i) == " ") then
			    temp = string.sub(t, 1, i-1)
			    t = string.sub(t, i+1)
			    i = 1
			    return_value[count][a] = temp
			    a = a +1
			end

		until (string.len(t) < i)

		return_value[count][a] = string.sub(t, 1, string.len(t)-1)

		count = count + 1
		t = f:read("*line")
  	end

  	return return_value
end

function clear_field()
	Schachspiel = 0

	for a=1,8,1 do
		for b=1,8,1 do
			if (type(Schachbrett[a][b][1]) == "userdata") then
			    Schachbrett[a][b][1]:Despawn(1,0)
			end
			Schachbrett[a][b] = {0,0}
		end
	end
end

function already_see(_target, _list)
	if _target == nil then
		return true
	end
	
	for i,k in pairs(_list) do
	    if k == _target then
	        return true
		end
	end
	
	return false
end

--------------------------------------------------
------		private functions Ende			------
--------------------------------------------------

--------------------------------------------------
------				Steuerung 				------
--------------------------------------------------

function Check(Unit)
	if (Schachspiel > 0) then
	
		Ply = Unit:GetClosestPlayer()
		Ply = Players[Schachspiel]
		local x,y = xyi_Output(Unit)
		
		if ((Schachbrett[x][y][2] < 7) and (Schachspiel == 1)) or ((Schachbrett[x][y][2] > 6) and (Schachspiel == 2)) then
			if (Ply ~= nil) then
			    xp,yp = xyi_Output(Ply)
			    x,y = xyi_Output(Unit)
				if comparing(xp, yp, x, y) then
					Schachbrett[x][y][1]:RemoveEvents()
					Schachbrett[x][y][1]:RegisterEvent("Timer", Select_Timer, 1)
				end
			end
		end
	end
end

function Timer(Unit)
	local x,y  = xyi_Output(Unit)
	local xp,yp = xyi_Output(Ply)
	
	if comparing(xp, yp, x, y) then
		Schachspiel = 0
		Select(Unit)
	    zahler = 0
	    
	    Unit:RemoveEvents()
	    Unit:RegisterEvent(Schachbrett[x][y][3][1], 1000, Schachbrett[x][y][3][2])
	    
		a = Schachbrett[x][y][3][2]/5
		if (math.floor(a+0.5) > 1) then
	       Unit:RegisterEvent("Select", 2000, math.floor(a+0.5))
		end
		
	else
		Unit:RegisterEvent("Check", 500, 0)
	end
end

function GoTo_Timer(Unit)
	if KI then
		xp = Pos[1]
		yp = Pos[2]
	else
		xp = Ply:GetX()
		yp = Ply:GetY()
	end

	if (xp == Pos[1]) and (yp == Pos[2]) then
	   	local x, y = xyi_Output(Unit)

	    Schachbrett[9][4]:RemoveEvents()
	    Schachbrett[9][4]:RegisterEvent("auto_reset", auto_reset_timer, 0)		
		
		Unit:RemoveEvents()
		
		Unit:RegisterEvent("GoTo_Emote_Timer", 1000, 0)
  		select_emote = Schachbrett[x][y][5]
  		
  		if (type(select_emote) == "table") then
  			select_emote = select_emote[math.random(table.getn(select_emote))]
  		end
  		
		Unit:Emote(select_emote,900)
  	end
end

function GoTo_Emote_Timer(Unit)
	local x, y, f = xyi_Output(Unit)
	
    Unit:RemoveEvents()
	enemy = -f+3
	
	move = {Unit:GetX()+(Pos[3]*size), Unit:GetY()+(Pos[4]*size), 0, 0, x, y}
	
	if (Check_Feld(x+Pos[3], y+Pos[4]) == enemy) then
        Schachbrett[x+Pos[3]][y+Pos[4]][1]:RemoveEvents()
        
        if (Schachbrett[x][y][6] == 1) then
	        if Pos[3] < 0 then
	        	move[3] = move[1]+1.5
	        else
	        	move[3] = move[1]-1.5
	        end
	        
	        if Pos[4] < 0 then
	        	move[4] = move[2]+1.5
	        else
	        	move[4] = move[2]-1.5
	        end
	        
	        Unit:MoveTo(move[3], move[4], Unit:GetZ(), Unit:GetO())
	        Unit:RegisterEvent("GoTo_Emote_Fight_Timer", 500, 0)
	    elseif (Schachbrett[x][y][6] == 2) then
	    	Unit:CastSpellOnTarget(Schachbrett[x][y][7], Schachbrett[x+Pos[3]][y+Pos[4]][1])
	    	
	    	if Schachbrett[x+Pos[3]][y+Pos[4]][9] then
	    		Schachbrett[x+Pos[3]][y+Pos[4]][1]:CastSpell(Schachbrett[x+Pos[3]][y+Pos[4]][10])
			end
			
			Unit:Kill(Schachbrett[x+Pos[3]][y+Pos[4]][1])
			Unit:RegisterEvent("GoTo_Move_Timer", 1000, 0)
		elseif (Schachbrett[x][y][6] == 3) then 	
			Unit:CastSpell(Schachbrett[x][y][7])
			Schachbrett[x+Pos[3]][y+Pos[4]][1]:CastSpell(Schachbrett[x][y][8])
			
            Unit:Kill(Schachbrett[x+Pos[3]][y+Pos[4]][1])
            Unit:RegisterEvent("GoTo_Move_Timer", 1000, 0)
        end
	else
		Unit:RegisterEvent("GoTo_Move_Timer", 1000, 0)
	end
end

function GoTo_Emote_Fight_Timer(Unit)
	if (Unit:GetX() == move[3]) and (Unit:GetY() == move[4]) then
		Unit:RemoveEvents()
		Unit:RegisterEvent("GoTo_Move_Timer", 1000, 0)
		attack_emote = Schachbrett[x][y][7]
		if (type(attack_emote) == "table") then
  			attack_emote = attack_emote[math.random(table.getn(attack_emote))]
  		end
		if Schachbrett[x+Pos[3]][y+Pos[4]][9] then
			Schachbrett[x+Pos[3]][y+Pos[4]][1]:CastSpellOnTarget(Schachbrett[x+Pos[3]][y+Pos[4]][10], Schachbrett[x+Pos[3]][y+Pos[4]][1])
		end		
		Unit:Kill(Schachbrett[x+Pos[3]][y+Pos[4]][1])
		Unit:Emote(attack_emote,900)
	end
end
	
function GoTo_Move_Timer(Unit)
	Unit:RemoveEvents()
	Unit:MoveTo(move[1], move[2], Unit:GetZ(), Unit:GetO())
	
	Schachbrett[move[5]][move[6]][4] = false
	Schachbrett[move[5]+Pos[3]][move[6]+Pos[4]] = Schachbrett[move[5]][move[6]]
	Schachbrett[move[5]][move[6]] = {0,0}
	
	move = {}
         
	if (Pos[5] == "en passant input") then
	    en_passant = {Pos[6], Pos[7]}
	elseif (Pos[5] == "en passant kickout") then
		Schachbrett[en_passant[1]][en_passant[2]-Pos[4]][1]:RemoveEvents()
		Unit:Kill(Schachbrett[en_passant[1]][en_passant[2]-Pos[4]][1])
		Schachbrett[en_passant[1]][en_passant[2]-Pos[4]] = {0,0}
		en_passant = {}
	else
		en_passant = {}
	end

	Schachspiel = enemy
	who_is(Schachbrett[9][4])
	
	Pos = {}

	if (Players[Schachspiel] == "ki") then
	    Schachspiel = Schachspiel * -1
        Schachbrett[9][4]:RegisterEvent("KI_Start", 500, 1)
	end
	Unit:RegisterEvent("Check", 500, 0)
	
	Unit:Emote(0,1000)
end

function RegUnit(_Unit, _table)
	if (Schachspiel > 0) then
		_Unit:RegisterEvent("Check", 500, 0)
		_Unit:CastSpell(32261)

        x, y = xyi_Output(_Unit)
		Schachbrett[x][y] = _table
		
		--_Unit:RegisterEvent("who_is", 500, 1)
	end
end

function who_is(_Unit)
	if Players[2] == "ki" then
	    return
	end

	Players[2]:SendBroadcastMessage(Players[Schachspiel]:GetName().." ist am Zug.")
	Players[1]:SendBroadcastMessage(Players[Schachspiel]:GetName().." ist am Zug.")
end

function auto_reset(Unit)
	if reset and (Schachspiel ~= 0) then
	
		for a=1,8,1 do
			for b=1,8,1 do
			    temp = Schachbrett[a][b]
			    Schachbrett[a][b] = {0,0}
				
				if (type(temp[1]) == "userdata") then
					Schachbrett[a][b] = temp
					Schachbrett[a][b][1]:RemoveEvents()
					Schachbrett[a][b][1]:RegisterEvent("Check", 500, 0)
				end
			end
		end
	end
end

function auto_save(Unit)
	if autosave then
	    game_save("scripts/chess_autosave.txt", os.time())
	end
end

--------------------------------------------------
------			Movements @ testing			------
--------------------------------------------------

function Queen_GoTo(Queen)
 	local x,y,f = xyi_Output(Queen)
 	local xp,yp = xyi_Output(Ply)

	zahler = zahler+1

	if comparing(xp, yp, x, y) then
		Check(Queen)
	else
		if (xp < x) then
			xort = -1
		elseif (xp > x) then 
			xort = 1
		else
			xort = 0
		end
		
		if (yp < y) then
			yort = -1
		elseif (yp > y) then
			yort = 1
		else
			yort = 0
		end
	
		for i=1,7,1 do
			if (Check_Feld(x+(i*xort),y+(i*yort)) ~= f) and (comparing(x+(i*xort),y+(i*yort), xp, yp)) then
				Pos[1] = Ply:GetX()
				Pos[2] = Ply:GetY()
				Pos[3] = i*xort
				Pos[4] = i*yort
				Queen:RegisterEvent("GoTo_Timer", 900, 1)
				break
			elseif (Check_Feld(x+(i*xort),y+(i*yort)) ~= 0) then
				break
			end
		end
	end

	if (Schachspiel == 0) and (zahler == Schachbrett[x][y][3][2]) then
		Schachspiel = f
		Queen:RemoveEvents()
		Queen:RegisterEvent("Check", 500, 0)
	end
end

function Pawn_GoTo(Pawn)
 	local x, y, f = xyi_Output(Pawn)
  	local xp,yp = xyi_Output(Ply)
	zahler = zahler+1
	
	i = f-(2*(1/f))
	
	if comparing(xp, yp, x, y) then
		Check(Pawn)
	elseif comparing(xp, yp, x-1, y+i) and (Check_Feld(x-1, y+i) == 2*(1/f)) then
		Pos[1] = Ply:GetX()
		Pos[2] = Ply:GetY()
		Pos[3] = -1
		Pos[4] = i
		Pawn:RegisterEvent("GoTo_Timer", 900, 1)
	elseif comparing(xp, yp, x+1, y+i) and (Check_Feld(x+1, y+i) == 2*(1/f)) then
		Pos[1] = Ply:GetX()
		Pos[2] = Ply:GetY()
		Pos[3] = 1
		Pos[4] = i
		Pawn:RegisterEvent("GoTo_Timer", 900, 1)
	elseif comparing(xp, yp, x, y+i) and (Check_Feld(x, y+i) == 0) then
  		Pos[1] = Ply:GetX()
		Pos[2] = Ply:GetY()
     	Pos[3] = 0
     	Pos[4] = i
		Pawn:RegisterEvent("GoTo_Timer", 900, 1)
	elseif (Schachbrett[x][y][4]) and comparing(xp, yp, x, y+2*i) and (Check_Feld(x, y+2*i) == 0) then
  		Pos[1] = Ply:GetX()
		Pos[2] = Ply:GetY()
		Pos[3] = 0
		Pos[4] = 2*i
		Pos[5] = "en passant input"
		Pos[6] = x
		Pos[7] = y+i
		Pawn:RegisterEvent("GoTo_Timer", 900, 1)
	elseif (en_passant ~= {}) then
	    if comparing(xp, yp, en_passant[1], en_passant[2]) and comparing(xp, yp, x-1, y+i) then
            Pos[1] = Ply:GetX()
			Pos[2] = Ply:GetY()
			Pos[3] = -1
			Pos[4] = i
			Pos[5] = "en passant kickout"
   			Pawn:RegisterEvent("GoTo_Timer", 900, 1)
		elseif comparing(xp, yp, en_passant[1], en_passant[2]) and comparing(xp, yp, x+1, y+i) then
            Pos[1] = Ply:GetX()
			Pos[2] = Ply:GetY()
			Pos[3] = 1
			Pos[4] = i
			Pos[5] = "en passant kickout"
   			Pawn:RegisterEvent("GoTo_Timer", 900, 1)
		end
	end
			

	if (Schachspiel == 0) and (zahler == Schachbrett[x][y][3][2]) then
		Schachspiel = f
		Pawn:RemoveEvents()
		Pawn:RegisterEvent("Check", 500, 0)
	end		
end

function Castle_GoTo(Castle)
 	local x,y,f = xyi_Output(Castle)
 	local xp,yp = xyi_Output(Ply)
 	
 	local xort = 0
 	local yort = 0
	zahler = zahler+1
		
	if comparing(xp, yp, x, y) then
		Check(Castle)
	else
		if (x == xp) then
			if (yp < y) then
				yort = -1
			else
				yort = 1
			end
		elseif (yp == y) then
			if (xp < x) then
				xort = -1
			else
				xort = 1
			end
		end
	
		for i=1,7,1 do
			if (Check_Feld(x+(i*xort),y+(i*yort)) ~= f) and (comparing(x+(i*xort),y+(i*yort), xp, yp)) then
				Pos[1] = Ply:GetX()
				Pos[2] = Ply:GetY()
				Pos[3] = i*xort
				Pos[4] = i*yort
				Castle:RegisterEvent("GoTo_Timer", 900, 1)
				break
			elseif (Check_Feld(x+(i*xort),y+(i*yort)) ~= 0) then
				break
			end	
		end
	end
	
	if (Schachspiel == 0) and (zahler == Schachbrett[x][y][3][2]) then
		Schachspiel = f
		Castle:RemoveEvents()
		Castle:RegisterEvent("Check", 500, 0)
	end		
end	

function Horse_GoTo(Horse)
 	local x,y,f = xyi_Output(Horse)
 	local xp,yp = xyi_Output(Ply)
	zahler = zahler+1
		
	if comparing(xp, yp, x, y) then
		Check(Horse)
	else
		if (Check_Feld(x+1, y-2) ~= f) and (math.abs(xp-x)+math.abs(yp-y) == 3) and ((math.abs(xp-x) == 1) or (math.abs(xp-x) == 2)) then
			Pos[1] = Ply:GetX()
			Pos[2] = Ply:GetY()
			Pos[3] = xp-x
			Pos[4] = yp-y
			Horse:RegisterEvent("GoTo_Timer", 900, 1)
		end
	end
	
	if (Schachspiel == 0) and (zahler == Schachbrett[x][y][3][2]) then
		Schachspiel = f
		Horse:RemoveEvents()
		Horse:RegisterEvent("Check", 500, 0)
	end		
end	

function Bishop_GoTo(Bishop)
 	local x,y,f = xyi_Output(Bishop)
 	local xp,yp = xyi_Output(Ply)
	zahler = zahler+1

	if comparing(xp, yp, x, y) then
		Check(Bishop)
	else
	    if (xp < x) then
	    	xort = -1
	    else
	    	xort = 1
	    end
	    
	    if (yp < y) then
	    	yort = -1
	    else
	    	yort = 1
	    end
	    
	    for i=1,7,1 do
	    	if (Check_Feld(x+(i*xort),y+(i*yort)) ~= f) and (comparing(x+(i*xort),y+(i*yort), xp, yp)) then
				Pos[1] = Ply:GetX()
				Pos[2] = Ply:GetY()
				Pos[3] = i*xort
				Pos[4] = i*yort
				Bishop:RegisterEvent("GoTo_Timer", 900, 1)
				break
			elseif (Check_Feld(x+(i*xort),y+(i*yort)) ~= 0) then
				break
			end	
		end	    	
	end

	if (Schachspiel == 0) and (zahler == Schachbrett[x][y][3][2]) then
		Schachspiel = f
		Bishop:RemoveEvents()
		Bishop:RegisterEvent("Check", 500, 0)
	end
end

function King_GoTo(King)
 	local x,y,f = xyi_Output(King)
 	local xp,yp = xyi_Output(Ply)
	zahler = zahler+1
	
	if comparing(xp, yp, x, y) then
		Check(King)
	else
		for i=-1,1,1 do
			for o=-1,1,1 do
		    	if (Check_Feld(x+i,y+o) ~= f) and (comparing(x+i,y+o, xp, yp)) then
					Pos[1] = Ply:GetX()
					Pos[2] = Ply:GetY()
					Pos[3] = i
					Pos[4] = o
					King:RegisterEvent("GoTo_Timer", 900, 1)
					break
				end
			end
		end

		if (Schachbrett[x][y][4]) then
			if (f == 1) then
				a = 8
				b = 2
			else
			    a = 1
			    b = 8
			end

			if (Schachbrett[xp][yp][2] == b) then
		        if (xp == 8) then
					if (Schachbrett[5][a][1] == 0) and (Schachbrett[6][a][1] == 0) and (Schachbrett[7][a][1] == 0) then
				        Pos[1] = Ply:GetX()
						Pos[2] = Ply:GetY()
						Pos[3] = 2
						Pos[4] = 0
						
				        Pos2 = {}
						Pos2[1] = Ply:GetX()
						Pos2[2] = Ply:GetY()
						Pos2[3] = -3
						Pos2[4] = 0
						Pos2[5] = Schachbrett[xp][yp]
						
						King:RegisterEvent("GoTo_Timer", 950, 1)
						King:RegisterEvent("Rochade", 900, 1)
					end
				else
				    if (Schachbrett[3][a][1] == 0) and (Schachbrett[2][a][1] == 0) then
				        Pos[1] = Ply:GetX()
						Pos[2] = Ply:GetY()
						Pos[3] = -2
						Pos[4] = 0
						
				        Pos2 = {}
						Pos2[1] = Ply:GetX()
						Pos2[2] = Ply:GetY()
						Pos2[3] = 2
						Pos2[4] = 0
						Pos2[5] = Schachbrett[xp][yp]
						
						King:RegisterEvent("GoTo_Timer", 950, 1)
						King:RegisterEvent("Rochade", 900, 1)
					end
				end 
			end
		end
	end

	if (Schachspiel == 0) and (zahler == Schachbrett[x][y][3][2]) then
		Schachspiel = f
		King:RemoveEvents()
		King:RegisterEvent("Check", 500, 0)
	end
end

function Rochade(Unit)
	local xp,yp = xyi_Output(Ply)
	local x,y = xyi_Output(Schachbrett[xp][yp][1])

	if comparing(Ply:GetX(), Ply:GetY(), Pos2[1], Pos2[2]) then

		xmove = Schachbrett[xp][yp][1]:GetX()+(Pos2[3]*size)
		ymove = Schachbrett[xp][yp][1]:GetY()+(Pos2[4]*size)
		Schachbrett[xp][yp][1]:MoveTo(xmove, ymove, Schachbrett[xp][yp][1]:GetZ(), Schachbrett[xp][yp][1]:GetO())
		
		Schachbrett[x+Pos2[3]][y+Pos2[4]] = {Schachbrett[x][y][1], Schachbrett[x][y][2], Schachbrett[x][y][3], false}
		Schachbrett[x][y] = {0,0}     
	end
end

function Allianz_Konig_Dead(Unit)
	local x,y = xyi_Output(Unit)
	
	math.randomseed(os.time())
	Ply:AddItem(Reward_Items[math.random(1,table.getn(Reward_Items))],1)
	Schachbrett[9][4]:SendChatMessage(14, 0, "Horde wins")
	Schachbrett[9][4]:RemoveEvents()
	Schachspiel = -1
	Game_over_timer = 30
	Schachbrett[9][4]:RegisterEvent("game_over", 1000, 0)
end

function Horde_Konig_Dead(Unit)
	local x,y = xyi_Output(Unit)
	
	math.randomseed(os.time())
	Ply:AddItem(Reward_Items[math.random(1,table.getn(Reward_Items))],1)
	Schachbrett[9][4]:SendChatMessage(14, 0, "Allianz wins")
	Schachbrett[9][4]:RemoveEvents()
	Schachspiel = -1
	Game_over_timer = 30
	Schachbrett[9][4]:RegisterEvent("game_over", 1000, 0)
end
	
--------------------------------------------------
------			Unit Registration	Anfang	------
--------------------------------------------------

-- Unit, SimpleID, {"xx_GoTo", xx_Timer}, true, selectemote, attacktype, spell/emote, targetspell, deathspell, deathspellid, KI_function 
   
function Horde_Bauer(Unit)
	RegUnit(Unit, {Unit, 1, {"Pawn_GoTo", Pawn_Timer}, true, {2,66}, 1, {35,36,37,38,54,60}, 0, false, 0, Pawn_KI})       
end
   
function Horde_Turm(Unit)
	RegUnit(Unit, {Unit, 2, {"Castle_GoTo", Castle_Timer}, true, {15,66} , 1, 51, 0, false, 0, Castle_KI}) 
end

function Horde_Pferd(Unit)
	RegUnit(Unit, {Unit, 3, {"Horse_GoTo", Horse_Timer}, false, 1, 1, 51, 0, false, 0, Horse_KI})
end

function Horde_Laufer(Unit)
	RegUnit(Unit, {Unit, 4, {"Bishop_GoTo", Bishop_Timer}, false, {2, 66}, 1, {51,60}, 0, false, 0, Bishop_KI})
end

function Horde_Konigin(Unit)
	RegUnit(Unit, {Unit, 5, {"Queen_GoTo", Queen_Timer}, false, {2, 66}, 1, {51,60}, 0, false, 0, Queen_KI})
end

function Horde_Konig(Unit)
	RegUnit(Unit, {Unit, 6, {"King_GoTo", King_Timer}, true, {2, 66}, 1, {51,60}, 0, true, 38006, King_KI})
end

function Allianz_Bauer(Unit)                                                      
	RegUnit(Unit, {Unit, 7, {"Pawn_GoTo", Pawn_Timer}, true, {2, 66}, 1, {51,60,54}, 0, false, 0, Pawn_KI})
end
   
function Allianz_Turm(Unit)
	RegUnit(Unit, {Unit, 8, {"Castle_GoTo", Castle_Timer}, true, 1, 1, {35,36,37}, 0, false, 0, Castle_KI})
end

function Allianz_Pferd(Unit)
	RegUnit(Unit, {Unit, 9, {"Horse_GoTo", Horse_Timer}, false, 1, 1, 51, 0, false, 0, Horse_KI})
end

function Allianz_Laufer(Unit)
	RegUnit(Unit, {Unit, 10, {"Bishop_GoTo", Bishop_Timer}, false, {2, 66}, 1, {51,60,54}, 0, false, 0, Bishop_KI})
end

function Allianz_Konigin(Unit)
	RegUnit(Unit, {Unit, 11, {"Queen_GoTo", Queen_Timer}, false, {2, 66}, 1, {51,60,54}, 0, false, 0, Queen_KI})
end

function Allianz_Konig(Unit)
	RegUnit(Unit, {Unit, 12, {"King_GoTo", King_Timer}, true, {2, 66}, 1, {51,60,54}, 0, true, 38006, King_KI})
end 

--------------------------------------------------
------			Unit Registration	Ende	------
--------------------------------------------------

    --------------
---|              |-------------------------------
---| KI Steuerung |--	Build 1	 -----------------
---|              |-------------------------------
    --------------


function KI_Start(Unit)
	Schachspiel = Schachspiel * -1

	local KI_Chess = {}
	
	for x=1,8,1 do
	    KI_Chess[x] = {}
	for y=1,8,1 do
	    KI_Chess[x][y] = {}
		if (Schachbrett[x][y][2] == 0) then
			KI_Chess[x][y] = 0
		else	
			KI_Chess[x][y] = Schachbrett[x][y][2]
		end
	end
	end
	
	for x=1,8,1 do
	for y=1,8,1 do
		if (Check_Feld_AR(x,y,KI_Chess) == math.abs(Schachspiel-3)) then
            KI_Chess[x][y] = {}
            KI_Chess[x][y][9] = {}
			KI_Chess[x][y][9][1] = 0
	
			for x1=1,8,1 do
			for y1=1,8,1 do
			    value = Schachbrett[x][y][11](x, y, x1, y1, math.abs(Schachspiel-3))
                if type(value) == "number" then KI_Chess[x1][y1][9][1] = value end
			end
			end
		end
	end
	end
	
	for x=1,8,1 do
	for y=1,8,1 do
		if (Check_Feld_AR(x,y,KI_Chess) == Schachspiel) then
            KI_Chess[x][y] = {}
			for x1=1,8,1 do
			    KI_Chess[x][y][x1] = {}
			for y1=1,8,1 do
			    KI_Chess[x][y][x1][y1] = {}
			    KI_Chess[x][y][x1][y1] = Schachbrett[x][y][11](x, y, x1, y1, Schachspiel) + KI_Chess[x][y][9][1]
			    table.insert(KI_Wert, {KI_Chess[x][y][x1][y1], x, y, x1, y1})
			end
			end
		end
	end
	end
	
	local fav = {{0}}
	for i,k in pairs(KI_Wert) do
		if (fav[1][1] == k[1]) then
			table.insert(fav, k)
		elseif (k[1] > fav[1][1]) then
			fav[1] = k
		end
	end
	
	fav = fav[math.random(1, table.getn(fav))]

	Pos[1] = fav[4]
	Pos[2] = fav[5]
	Pos[3] = fav[4]-fav[2]
	Pos[4] = fav[5]-fav[3]
	
	if ((Schachbrett[fav[1]][fav[2]][2] == 1) or (Schachbrett[fav[1]][fav[2]][2] == 7)) and (math.abs(Pos[4]) == 2) then
		Pos[5] = "en passant input"	
		Pos[6] = fav[4]
		Pos[7] = fav[5]-(Pos[4]/2)
	end
	if comparing(xp, yp, en_passant[1], en_passant[2]) and (comparing(xp, yp, x-1, y+i) or comparing(xp, yp, x-1, y+i)) then
		Pos[5] = "en passant input"	
	end	 
	
	GoTo_Timer(Schachbrett[fav[1]][fav[2]][1])	
end

function Queen_KI(x, y, xp, yp, f)
 	local xort = 0
 	local yort = 0

	if (xp < x) then
		xort = -1
	elseif (xp > x) then 
		xort = 1
	end
	
	if (yp < y) then
		yort = -1
	elseif (yp > y) then
		yort = 1
	end

	for i=1,7,1 do
		local Feld = Check_Feld(i*xort+x, i*yort+y)
		if (Feld == f) then
			return 0 
		elseif (Feld == math.abs(f-3)) and comparing(i*xort+x, i*yort+y, xp, yp) then
			return Wertigkeit[Schachbrett[xp][yp][2]]
		elseif (Feld == 0) and comparing(i*xort+x, i*yort+y, xp, yp) then
			return 1
		end
	end
	
	return 0	
end 

function Pawn_KI(x, y, xp, yp, f)
	zahler = zahler+1
	
	i = f-(2*(1/f))
	
	if  (comparing(xp, yp, x-1, y+i) or comparing(xp, yp, x+1, y+i)) and (Check_Feld(xp, y+i) == 2*(1/f)) then
		return Wertigkeit[Schachbrett[xp][yp][2]]
	elseif comparing(xp, yp, x, y+i) and (Check_Feld(x, y+i) == 0) then
  		return 1
	elseif (Schachbrett[x][y][4]) and comparing(xp, yp, x, y+2*i) and (Check_Feld(x, y+2*i) == 0) then
		return 1
	elseif (en_passant ~= {}) then
	    if comparing(xp, yp, en_passant[1], en_passant[2]) and comparing(xp, yp, x-1, y+i) then
            return 2
		elseif comparing(xp, yp, en_passant[1], en_passant[2]) and comparing(xp, yp, x+1, y+i) then
            return 2
		end
	end
	
	return 0
end  

function Castle_KI(x, y, xp, yp, f)
 	local xort = 0
 	local yort = 0

	if (x == xp) then
		if (yp < y) then
			yort = -1
		else
			yort = 1
		end
	elseif (yp == y) then
		if (xp < x) then
			xort = -1
		else
			xort = 1
		end
	end
	
	for i=1,7,1 do
		local Feld = Check_Feld(i*xort+x, i*yort+y)
		if (Feld == f) then
			return 0 
		elseif (Feld == math.abs(f-3)) and comparing(i*xort+x, i*yort+y, xp, yp) then
			return Wertigkeit[Schachbrett[xp][yp][2]]
		elseif (Feld == 0) and comparing(i*xort+x, i*yort+y, xp, yp) then
			return 1
		end
	end
	
	return 0
end	

function Horse_KI(x, y, xp, yp, f)
	if (Check_Feld(x+1, y-2) == 0) and (math.abs(xp-x)+math.abs(yp-y) == 3) and ((math.abs(xp-x) == 1) or (math.abs(xp-x) == 2)) then
		return 1	
	elseif (Check_Feld(x+1, y-2) == math.abs(f-3)) and (math.abs(xp-x)+math.abs(yp-y) == 3) and ((math.abs(xp-x) == 1) or (math.abs(xp-x) == 2)) then
		return Wertigkeit[Schachbrett[xp][yp][2]]
	end
	
	return 0
end	

function Bishop_KI(x, y, xp, yp, f)
 	local xort = 0
 	local yort = 0
 	
	if (xp < x) then
		xort = -1
	else
		xort = 1
	end
	
	if (yp < y) then
		yort = -1
	else
		yort = 1
	end
	
	for i=1,7,1 do
		local Feld = Check_Feld(i*xort+x, i*yort+y)
		if (Feld == f) then
			return 0 
		elseif (Feld == math.abs(f-3)) and comparing(i*xort+x, i*yort+y, xp, yp) then
			return Wertigkeit[Schachbrett[xp][yp][2]]
		elseif (Feld == 0) and comparing(i*xort+x, i*yort+y, xp, yp) then
			return 1
		end
	end
	
	return 0	    	
end

function King_KI(x, y, xp, yp, f)
	for i=-1,1,1 do
		for o=-1,1,1 do
	    	if (Check_Feld(x+i,y+o) == math.abs(f-3)) and (comparing(x+i,y+o, xp, yp)) then
				return Wertigkeit[Schachbrett[xp][yp][2]]
			elseif (Check_Feld(x+i,y+o) == 0) and (comparing(x+i,y+o, xp, yp)) then
				return 1
			end				
		end
	end
	
	return 0
end