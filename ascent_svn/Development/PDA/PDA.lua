--[[=========================================
 _     _    _                                      
| |   | |  | |  /\                  /\             
| |   | |  | | /  \   _ __  _ __   /  \   _ __ ___ 
| |   | |  | |/ /\ \ | '_ \| '_ \ / /\ \ | '__/ __|
| |___| |__| / ____ \| |_) | |_) / ____ \| | | (__ 
|______\____/_/    \_\ .__/| .__/_/    \_\_|  \___|
  Scripting Project  | |   | | Improved LUA Engine 
                     |_|   |_|                   
   SVN: http://svn.assembla.com/svn/LUAppArc
   LOG: http://burning-azzinoth.de/arcemu/new/frontend/?t=2
   ----------------------
   Original Code: Kenuvis
   Build 3 ]]

-- Standart Version Config -----------------------------------------------------------------------

--EntryID des PDA-Items
local PDA_Item_ID = 90001

-- -----------------------------------------------------------------------------------------------

--Soll ein Item geaddet werden? Wenn ja, wie hei?t es und welche ID hat es?
local Item_add = true
local Item_Name = "Zeitung"
local Item_ID = 12333

-- -----------------------------------------------------------------------------------------------

--Wo sollen welche Datein gespeichert werden? (geht vom Arcemuordner aus)
--z.B. "pda/note/" = c:/xyz/arcemu/pda/note
local save_notiz = "pda/note/"
local save_news = "pda/"
local save_post = "pda/"

-- -----------------------------------------------------------------------------------------------

--Wie ist das Passwort f?r den administrativen Bereich?
local GM_Code = "1234abc"


RegisterItemGossipEvent(PDA_Item_ID, 1, "PDA_Start")
RegisterItemGossipEvent(PDA_Item_ID, 2, "PDA_Select")

local post_temp = {}
local news_temp = {}

print ("############################################")
print ("# WoWPDA B3")
print ("# Code by Kenuvis")
print ("# LUAppArc Scripting Project")
print ("############################################")

table.find = function (_table, _value, _index)
		for i,k in pairs(_table) do
			if (_index ~= nil) then
				k = k[_index]
			end
			if (k == _value) then return i end
		end
	end

function PDA_already_see(_target, _list)
	if _target == nil then
		return 0
	end

	for i,k in pairs(_list) do
	    if k[1] == _target then
	        return i
		end
	end

	return 0
end

function PDA_read_file(Player, dir)
	if (io.open(dir,"r") == nil) then
		io.open(dir,"w")
	end
	local d = io.open(dir,"r")
	local save_table = {}
    if d == nil then
        Player:SendBroadcastMessage("Datei konnte nicht ge\195\182ffnet werden.")
        return {}
	end
    temp = d:read("*l")
    while temp ~= nil do
		table.insert(save_table, temp)
		temp = d:read("*l")
 	end
    d:close()
 	return save_table
end

function PDA_write_file(dir, save_table)
	local f = assert(io.open(dir,"w"))
	local str = ""
     if f == nil then
        return false
	end
	for i, l in pairs(save_table) do
		str = string.format("%s%s%s", str,l,"\n")
	end
	f:write(str)
	f:close()
	
	return true
end

function PDA_Start(Item, Event, Player)
	Item:GossipCreateMenu(2, Player, 0)
	if (io.open(save_news.."news.txt","r") ~= nil) then
		Item:GossipMenuAddItem(30, "News", 100, 0)
	end
	
	local post_table = PDA_read_file(Player, save_news.."post.txt")
	post_table = post_pars(post_table, Player)
    for i,k in pairs(post_table) do
    	if k[1] == "1" then
    		Item:GossipMenuAddItem(2, "[ungelesene Post] von "..k[2], 800+i, 0)
		end	
	    if (i == 100) then break end
	end	 	
	
	if Item_add then
		Item:GossipMenuAddItem(30, Item_Name, 101, 0)
	end
	Item:GossipMenuAddItem(30, "Login", 200, 0)
	Item:GossipMenuAddItem(30, "GMLogin", 300, 1)
	Item:GossipMenuAddItem(30, "About", 10, 0)
	Item:GossipSendMenu(Player)
end

function PDA_Select(Item, Event, Player, MenuId, id, Code)
	local save_table = {}
	if (id == 0) then
	    PDA_Start(Item, Event, Player)
	    return
	end
	
	if (id == 1) then
	    Custom_Menu(Item, Player, Code)
		return
	end
	
	if (id == 2) then
	    Master_Menu(Item, Player)
	    return
	end
	
	if (id == 10) then
		Player:SendBroadcastMessage("WoWPDA\nBuild 3")
	    PDA_Start(Item, Event, Player)
	    return
	end
	
	if (id == 100) then
        local news_table = PDA_read_file(Player, save_news.."news.txt")
		Item:GossipCreateMenu(2, Player, 0)
		Item:GossipMenuAddItem(0, "[...]", 0, 0)
		for i,k in pairs(news_table) do
	        if (math.floor(i/2 + 0.5) ~= i/2) then
	        	Item:GossipMenuAddItem(2, "[News]"..k, 600+i, 0)
			end
		    if (i == 100) then break end
		end
	  	Item:GossipSendMenu(Player)
	  	return
	end
	
	if (id == 101) then
		Player:AddItem(Item_ID, 1)
		PDA_Start(Item, Event, Player)
	    return
	end
	
	if (id == 102) then
	    Item:GossipCreateMenu(2, Player, 0)
	  	Item:GossipMenuAddItem(0, "[...]", 1, 0)
	  	Item:GossipMenuAddItem(0, "Neue Notiz", 103, 1)
	  	Item:GossipMenuAddItem(0, "Notiz l\195\182schen", 104, 0)
	  	Item:GossipMenuAddItem(0, "Alle Notizen l\195\182schen", 105, 0)
	  	Item:GossipSendMenu(Player)
	  	return
	end
	
	if (id == 103) then
		local note_table = PDA_read_file(Player, string.format("%s%s.txt", save_notiz, Player:GetUInt32Value(16)))
		table.insert(note_table, Code)
		if PDA_write_file(string.format("%s%s.txt", save_notiz, Player:GetUInt32Value(16)), note_table) then
			Player:SendBroadcastMessage("Notizdatei erstellt")
		end
  		PDA_Select(Item, Event, Player, MenuId, 701, Code)
		return
	end
	
	if (id == 104) then
        local note_table = PDA_read_file(Player, string.format("%s%s.txt", save_notiz, Player:GetUInt32Value(16)))
		Item:GossipCreateMenu(2, Player, 0)
		for i,k in pairs(note_table) do
	        if (string.len(k) > 40) then
	            k = string.sub(k, 1,37).."..."
			end
		    Item:GossipMenuAddItem(0, k, 900+i, 0)
		    if (i == 100) then break end
		end
		Item:GossipSendMenu(Player)
	  	return
	end
	
	if (id == 105) then
	    PDA_write_file(string.format("%s%s.txt", save_notiz, Player:GetUInt32Value(16)), {})
	    Player:SendBroadcastMessage("Alle Notizen sind gel\195\182scht")
     	Custom_Menu(Item, Player, Code)
     	return
	end
		
	if (id == 106) then	
		Item:GossipCreateMenu(2, Player, 0)
		Item:GossipMenuAddItem(0, "[...]", 1, 0)
		local post_table = PDA_read_file(Player, save_news.."post.txt")
		post_table = post_pars(post_table, Player)
	    for i,k in pairs(post_table) do
	    	if k[1] == "1" then
	    		t = "[ungelesene Post] von "..k[2]..": "..k[4]
			else
				t = "[Post] von "..k[2]..": "..k[4]
			end	
			if (string.len(t) > 40) then
	            t = string.sub(t, 1,37).."..."
			end
			Item:GossipMenuAddItem(2, t, 1000+i, 0)
		    if (i == 100) then break end
		end
		Item:GossipSendMenu(Player)
	end 	

	if (id == 200) then
		Custom_Menu(Item, Player, Code)
		return
	end
	
	if (id == 300) then
	    if (Code == GM_Code) then
	        Player:SendBroadcastMessage("Masterlogin erfolgreich")
	        
	        Master_Menu(Item, Player)
		else
		    Player:SendBroadcastMessage("Masterlogin fehlgeschlagen")
		    Item:GossipComplete(Player)
		end
		return
	end
	
	if (id == 400) then
        Item:GossipCreateMenu(2, Player, 0)
        Item:GossipMenuAddItem(0, "[...]", 1, 0)
		i = PDA_already_see(Player:GetUInt32Value(16), post_temp)
		if (i == 0) then
			table.insert(post_temp, {Player:GetUInt32Value(16), "<Empf\195\164nger eingeben>", "<Nachricht eingeben>"})
            Item:GossipMenuAddItem(30, "<Empf\195\164nger eingeben>", 401, 1)
			Item:GossipMenuAddItem(30, "<Nachricht eingeben>", 402, 1)
			Item:GossipSendMenu(Player)
		else
            if (post_temp[i][2] == nil) then post_temp[i][2] = "<Empf\195\164nger eingeben>" end
			if (post_temp[i][3] == nil) then post_temp[i][3] = "<Nachricht eingeben>" end
            Item:GossipMenuAddItem(30, post_temp[i][2], 401, 1)
			Item:GossipMenuAddItem(30, post_temp[i][3], 402, 1)
			Item:GossipMenuAddItem(30, "[Nachricht an "..post_temp[i][2].." senden]", 403, 0)
			Item:GossipSendMenu(Player)
		end
		return
	end
	
	if (id == 401) then
	    i = PDA_already_see(Player:GetUInt32Value(16), post_temp)
	    post_temp[i][2] = Code
	    post_temp[i][2] = string.upper(string.sub(post_temp[i][2],1,1))..string.lower(string.sub(post_temp[i][2],2))
	    PDA_Select(Item, Event, Player, MenuId, 400, Code)
	    return
	end
	
	if (id == 402) then
	    i = PDA_already_see(Player:GetUInt32Value(16), post_temp)
	    post_temp[i][3] = Code
	    PDA_Select(Item, Event, Player, MenuId, 400, Code)
	    return
	end
	
	if (id == 403) then
	    i = PDA_already_see(Player:GetUInt32Value(16), post_temp)

		save_table = PDA_read_file(Player, save_post.."post.txt")
		
	 	table.insert(save_table, string.format("1 %s %s %s", Player:GetName(), post_temp[i][2], post_temp[i][3]))

		if PDA_write_file(save_post.."post.txt", save_table) then
		    Player:SendBroadcastMessage("Nachricht wurde abgesendet")
		    table.remove(post_temp, i)
		else
            Player:SendBroadcastMessage("Nachricht konnte nicht gesendet werden.")
		end

		Custom_Menu(Item, Player, Code)
		return
	end
	
	if (id == 500) then
	    if (string.lower(Code) == "true") or (Code == "1") then
	        Item_add = true
		else
		    Item_add = false
		end
    	if Item_add then Item_a = "true" else Item_a = "false" end
		Player:SendBroadcastMessage(string.format("Item_add = %s", Item_a))
		Master_Menu(Item, Player)
	end
	
	if (id == 501) then
	    Item_Name = Code
	    Player:SendBroadcastMessage("Item_Name = "..Code)
	    Master_Menu(Item, Player)
	end
	
	if (id == 502) then
	    post_temp = {}
	    Player:SendBroadcastMessage("Nachrichten-Zwischenspeicher geleert.")
	    news_temp = {}
	    Player:SendBroadcastMessage("News-Zwischenspeicher geleert.")
	    Master_Menu(Item, Player)
	end
	
	if (id == 503) then
		Player:SendBroadcastMessage(Player:GetUInt32Value(Code))
		Master_Menu(Item, Player)
	end
	
	if (id == 504) then
	    Item_ID = Code
	    Player:SendBroadcastMessage("Item_ID = "..Code)
	    Master_Menu(Item, Player)
	end

	if (id == 510) then
	    i = PDA_already_see(Player:GetUInt32Value(16), news_temp)
        Item:GossipCreateMenu(2, Player, 0)
        Item:GossipMenuAddItem(0, "[...]", 2, 0)
		if (i == 0) then
			table.insert(news_temp, {Player:GetUInt32Value(16), "<\195\156berschrift eingeben>", "<News eingeben>"})
            Item:GossipMenuAddItem(30, "<\195\156berschrift eingeben>", 511, 1)
			Item:GossipMenuAddItem(30, "<News eingeben>", 512, 1)
			Item:GossipSendMenu(Player)
		else
			if (news_temp[i][2] == nil) then news_temp[i][2] = "<\195\156berschrift eingeben>" end
			if (news_temp[i][3] == nil) then news_temp[i][3] = "<News eingeben>" end
			Item:GossipMenuAddItem(30, news_temp[i][2], 511, 1)
			Item:GossipMenuAddItem(30, news_temp[i][3], 512, 1)
			Item:GossipMenuAddItem(30, "[News senden]", 513, 0)
			Item:GossipSendMenu(Player)
		end
		return
	end

	if (id == 511) then
	    i = PDA_already_see(Player:GetUInt32Value(16), news_temp)
	    news_temp[i][2] = Code
	    PDA_Select(Item, Event, Player, MenuId, 510, Code)
	    return
	end
	
	if (id == 512) then
	    i = PDA_already_see(Player:GetUInt32Value(16), news_temp)
	    news_temp[i][3] = Code
	    PDA_Select(Item, Event, Player, MenuId, 510, Code)
	    return
	end

	if (id == 513) then
		save_table = PDA_read_file(Player, save_news.."news.txt")

	 	table.insert(save_table, 1, news_temp[i][3])
        table.insert(save_table, 1, news_temp[i][2])
        
		if PDA_write_file(save_news.."news.txt", save_table) then
		    Player:SendBroadcastMessage("News wurde abgesendet")
		    table.remove(news_temp, i)
		else
            Player:SendBroadcastMessage("Newsdatei konnte nicht ge\195\164ndert werden.")
		end

		Master_Menu(Item, Player)

		return
	end
	
	if (id == 520) then
        Item:GossipCreateMenu(2, Player, 0)
		local f = io.open(save_news.."news.txt","r")
	    local count = 1

	    t = f:read("*line")
	  	while t ~= nil do
            Item:GossipMenuAddItem(30, t, 520+count, 0)
			count = count + 2
			t = f:read("*line")
			t = f:read("*line")
	  	end
	  	Item:GossipSendMenu(Player)
	  	return
	end
	
	if (id > 520) and (id < 600) then
     	save_table = PDA_read_file(Player, save_news.."news.txt")
	 	table.remove(save_table, id-520)
        table.remove(save_table, id-520)
		if PDA_write_file(save_news.."news.txt", save_table) then
		    Player:SendBroadcastMessage("News wurde gel\195\182scht")
		else
            Player:SendBroadcastMessage("Newsdatei konnte nicht ge\195\164ndert werden.")
		end

		Master_Menu(Item, Player)

		return
	end
	
 	if (id > 600) and (id < 700) then
		local news_table = PDA_read_file(Player, save_news.."news.txt")

		if (math.floor(id/2 + 0.5) == id/2) and (id-600 ~= 1) then
			PDA_Select(Item, Event, Player, MenuId, 100, Code)
		else
			Item:GossipCreateMenu(2, Player, 0)
			Item:GossipMenuAddItem(0, "[...]", 0, 0)
			for i,k in pairs(news_table) do
		        if (math.floor(i/2 + 0.5) ~= i/2) then
					Item:GossipMenuAddItem(2, "[News]"..k, 600+i, 0)
				elseif (i == id-600+1) then
				    Item:GossipMenuAddItem(30, "[-->>]"..k, 600+i, 0)
				end
			    if (i == 100) then break end
			end
			Item:GossipSendMenu(Player)
		end
	end
	
	if (id > 700) and (id < 800) then
        Item:GossipCreateMenu(2, Player, 0)
        Item:GossipMenuAddItem(0, "[...]", 1, 0)
 	  	Item:GossipMenuAddItem(0, "Neue Notiz", 103, 1)
	  	Item:GossipMenuAddItem(0, "Notiz l\195\182schen", 104, 0)
	  	Item:GossipMenuAddItem(0, "Alle Notizen l\195\182schen", 105, 0)
		local note_table = PDA_read_file(Player, string.format("%s%s.txt", save_notiz, Player:GetUInt32Value(16)))
        for i,k in pairs(note_table) do
            t = "[Notiz]"..k
	        if (string.len(t) > 33) and (i ~= id-700) then
	            t = string.sub(t, 1,30).."..."
			end
			
			Item:GossipMenuAddItem(0, t, 700+i, 0)
		    if (i == 100) then break end
		end
		Item:GossipSendMenu(Player)
	end
	
	if (id > 800) and (id < 900) then	
		Item:GossipCreateMenu(2, Player, 0)
		Item:GossipMenuAddItem(0, "[...]", 1, 0)
		local _post_table = PDA_read_file(Player, save_news.."post.txt")
		post_table = post_pars(_post_table, Player)
	    for i,k in pairs(post_table) do
	    	if k[1] == "1" then t = "[ungelesene Post] von " else t = "[Post] von " end
			if (i == id-800) then
  	    		if k[1] == "1" then
					_in = "1 "..k[2].." "..k[3].." "..k[4]
					_in = table.find(_post_table, _in)
					_post_table[_in] = "0 "..k[2].." "..k[3].." "..k[4]
	                if not PDA_write_file(save_post.."post.txt", _post_table) then
	                    Player:SendBroadcastMessage("Fehler - Postdatei konnte nicht ge\195\164ndert werden")
					else
					    t = "[Post] von "
					end
				end
				
				Item:GossipMenuAddItem(2, t..k[2]..": "..k[4], 800+i, 0)
				
			else
				Item:GossipMenuAddItem(2, t..k[2], 800+i, 0)
			end	
		    if (i == 100) then break end
		end
		Item:GossipSendMenu(Player)
	end

	if (id > 900) and (id < 1000) then
	    local note_table = PDA_read_file(Player, string.format("%s%s.txt", save_notiz, Player:GetUInt32Value(16)))
		table.remove(note_table, id-900)
		if PDA_write_file(string.format("%s%s.txt", save_notiz, Player:GetUInt32Value(16)), note_table) then
			Player:SendBroadcastMessage("Notiz gel\195\182scht")
		end
    	PDA_Select(Item, Event, Player, MenuId, 701, Code)
		return
	end
	
	if (id > 1000) and (id < 1100) then
		local post_table = PDA_read_file(Player, save_news.."post.txt")
		local pars_table = post_pars(post_table, Player)
		local i = table.find(post_table, pars_table[id-1000][1].." "..pars_table[id-1000][2].." "..pars_table[id-1000][3].." "..pars_table[id-1000][4]) 
		table.remove(post_table, i)
		if not PDA_write_file(save_post.."post.txt", post_table) then
            Player:SendBroadcastMessage("Fehler - Postdatei konnte nicht ge\195\164ndert werden")
		end
    	PDA_Select(Item, Event, Player, MenuId, 106, Code)
		return
	end
end

function post_pars(_table, _Player)
	local return_value = {}
	
	for i,k in pairs(_table) do
		local b = {}
		local a = 1
		local l = 0
		repeat
   			l = l+1
   			
       		if (string.sub(k, l, l) == " ") then
			    temp = string.sub(k, 1, l-1)
			    k = string.sub(k, l+1)
			    l = 1
			    b[a] = temp
			    a = a +1
			end
    	until (string.len(k) < l) or (a == 4)
				
		
		if (b[3] == _Player:GetName()) then
			b[a] = k
			table.insert(return_value, b)
		end
	end
	return return_value			
end		

function Custom_Menu(Item, Player, Code)
	local note_table = PDA_read_file(Player, string.format("%s%s.txt", save_notiz, Player:GetUInt32Value(16)))
	local news_table = PDA_read_file(Player, save_news.."news.txt")
	local post_table = PDA_read_file(Player, save_news.."post.txt")
	post_table = post_pars(post_table, Player)
	Item:GossipCreateMenu(2, Player, 0)
    Item:GossipMenuAddItem(2, "Logout", 0, 0)
    
    if (note_table[1] == nil) then
		if PDA_write_file(string.format("%s%s.txt", save_notiz, Player:GetUInt32Value(16)), {}) then
		end
	end
	
    Item:GossipMenuAddItem(2, "Notizen bearbeiten", 102, 0)
	Item:GossipMenuAddItem(2, "Post senden", 400, 0)
	if (table.getn(post_table) > 0) then
		Item:GossipMenuAddItem(2, "Post l\195\182schen", 106, 0)
	end
	
    for i,k in pairs(post_table) do
    	if k[1] == "1" then
    		Item:GossipMenuAddItem(2, "[ungelesene Post] von "..k[2], 800+i, 0)
		else
			Item:GossipMenuAddItem(2, "[Post] von "..k[2], 800+i, 0)
		end	
	    if (i == 100) then break end
	end    
    
	for i,k in pairs(note_table) do
		t = "[Notiz]"..k
        if (string.len(t) > 33) then
            t = string.sub(t, 1,30).."..."
		end
	    Item:GossipMenuAddItem(0, t, 700+i, 0)
	    if (i == 100) then break end
	end

	for i,k in pairs(news_table) do
        if (math.floor(i/2 + 0.5) ~= i/2) then
        	Item:GossipMenuAddItem(2, "[News]"..k, 600+i, 0)
		end
	    if (i == 100) then break end
	end

	Item:GossipSendMenu(Player)
end

function Master_Menu(Item, Player)
    Item:GossipCreateMenu(2, Player, 0)
    Item:GossipMenuAddItem(2, "Logout", 0, 0)
    if Item_add then Item_a = "true" else Item_a = "false" end
	Item:GossipMenuAddItem(2, string.format("ItemAdd: %s",Item_a), 500, 1)
    Item:GossipMenuAddItem(2, string.format("ItemName: %s",Item_Name), 501, 1)
    Item:GossipMenuAddItem(2, string.format("ItemId: %s",Item_ID), 504, 1)
    Item:GossipMenuAddItem(2, "Zwischenspeicher leeren", 502, 0)
    Item:GossipMenuAddItem(2, "News hinzuf\195\188gen", 510, 0)
    Item:GossipMenuAddItem(2, "News l\195\182schen", 520, 0)
    Item:GossipMenuAddItem(2, "UInt32 Value anzeigen", 503, 1)
    Item:GossipSendMenu(Player)
end