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
   Build 3
   Funserver Version ]]

-- Standart Version Config -----------------------------------------------------------------------

--EntryID des PDA-Items
local PDA_Item_ID = 90000

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



-- Funserver Version Config ----------------------------------------------------------------------

--Wiederbelebungsnachwirkung entfernen, anzeigen?
local RemoveSickness = true
--Wird daf?r ein Item ben?tigt? (0 = n?, <0 [ID*-1] = Item wird nur ben?tigt, nicht verbraucht, >0 = Item wird verbraucht)
--z.B. Item 1234 soll nur ben?tigt werden, aber nicht verbraucht, dann RemoveSickness_item = -1234
local RemoveSickness_item = 0

-- -----------------------------------------------------------------------------------------------

--Welches LvL soll der NPC machen? (0 = Men?eintrag wird nicht angezeigt)
local UpLvL = 70
local LvL_item = 0

-- -----------------------------------------------------------------------------------------------

--Welche Reittiere soll er bei Reiten adden?
--[Null = Kein Reittier]
local Mount = 33225
local Mount_item = 0
local EpicMount = 33225
local EpicMount_item = 0
local FlyMount = 34092
local FlyMount_item = 0
local EpicFlyMount = 34092
local EpicFlyMount_item = 0

-- -----------------------------------------------------------------------------------------------

--Buffen anzeigen? (Ab LvL 45)
local Buff = true
local Buff_item = 0

-- -----------------------------------------------------------------------------------------------

--Voll Mana und Hp setzen anzeigen?
local VollMpHp = true
local VollMpHp_item = 0 

-- -----------------------------------------------------------------------------------------------

--Reiten lernen anzeigen?
local Reitenlernen = true

-- -----------------------------------------------------------------------------------------------

--Skills erh?hen? (0 = nein, anosnten Wert)
local SkillMax = 300
local SkillMax_item = 0

-- -----------------------------------------------------------------------------------------------

--Verwandeln anzeigen?
local Verwandeln = true
local Verwandeln_item = 0
local morph = {
{15200, "Bot 5000"},
{15327, "Skorpion"},
{14616, "Orc Kind"},
{6297, "Frosch"},
{10045, "Irrwisch"},
{15374, "Moonkin"},
{17158, "Schildkr\195\182te"},
{15800, "Weihnachts-Wichtel"},
{1060, "Kuh"},
{17685, "Astro"},
{19418, "Breakdancer"},
{20171, "Taucher"},
{277, "Proximity"},
{1555, "Dummy"},
{14779, "Schlagen Rot"},
{14778, "Schlange Gr\195\188n"},
{17204, "Nether Drake Whelp"},
{23780, "Paymaster"},
{10729, "Death Lord"},
{17818, "Ikan"},
{14546, "Pack Esel"}
}

-- -----------------------------------------------------------------------------------------------

--Verlorene Spells beibringen anzeigen?
local Spell = true
local Spell_item = 0

-- -----------------------------------------------------------------------------------------------

--Teleportieren?
local Tele = true
local Tele_item = 17031
--F?r das Teleportieren in die Hauptst?dte. (Shatt, OG, UC, TB, SM, SW, IF, Dar, Exo)
local CityTele_item = 17031
teleports = {
{"Blackrock Mountains", 0, -7491.719238, -1074.845947, 265.089935},
{"The Deadmines", 0, -11067.506836, 1527.711304, 43.282364},
{"Gnomeregan", 0, -5182.464355, 607.487427, 408.965881}, 
{"Karazahn", 0, -11121.247070, -2012.714355, 47.096985}, 
{"Magisters' Terrace", 530, 12889.763672, -7326.697266, 65.491798},
{"Naxxramas", 0, 3164.131592, -3747.983887, 132.852615},
{"Scholomance", 0, 1230.314575, -2599.220703, 88.976143},
{"Shadowfang Keep", 0, -246.683914, 1532.607666, 77.124901},
{"Scarlet Monastery", 0, 2843.495605, -692.977295, 139.330276},
{"The Stockade", 0, -8772.176758, 840.297913, 91.003372},
{"Stratholme", 0, 3343.937744, -3379.550781, 144.775574},
{"The Sunken Temple", 0, -10449.789063, -3823.687988, 18.066645},
{"Sunwell Plateau", 530, 12588.159180, -6775.057617, 15.091800},
{"Uldaman", 0, -6071.516133, -2955.536377, 209.783035},
{"Zul'Aman", 530, 6851.177246, -7946.305664, 170},
{"Zul'Gurub", 0, -11915.947266, -1187.432007, 85.137840},
{"Ahn'Qiraj", 1, -8166.177734, 1531.099487, 4.195099},
{"Blackfathom Deeps", 1, 4247.057129, 741.940735, -25.184605},
{"Caverns of Time", 1, -8369.945313, -4253.909820, -204.333389},
{"Dire Maul", 1, -3520.068848, 1113.661337, 161.026123},
{"Maraudon", 1, -1421.904297, 2910.345703, 137.410583},
{"Onyxia's Lair", 1, -4672.532227, -3702.960693, 46.147873},
{"Ragfire Chasm", 1, 1809.329834, -4404.645508, -18.714394},
{"Razorfen Downs", 1, -4651.700684, -2500.510254, 81.400879},
{"Razorfen Kraul", 1, -4473.704102, -1683.995361, 80.525322},
{"Wailing Caverns", 1, -740.448181, -2215.664063, 16.156469},
{"Zul'Farrak", 1, -6808.160645, -2890.859131, 8.885407},
{"Auchindoun", 530, -3329.651855, 4936.043457, -90.39930},
{"Black Temple", 530, -3624.857910, 315.062836, 38.903099},
{"Coilfang Reservoir", 530, 730.947876, 6866.012695, -70.749023},
{"Gruul's Lair", 530, 3523.798340, 5153.760742, -1.424888},
{"Hellfire Citadel", 530, -575.380798, 3119.677734, 5.5155335},
{"Tempest Keep", 530, 3098.487793, 1513.052124, 190.300110},
{"Hellfire Peninsula/ The Dark Portal", 530, -248.431702, 939.013367, 84.379822},
{"Terokkar Forest", 530, -1176.588989, 5336.273926, 29.897034},
{"Nagrand", 530, -526, 8440, 47.426472},
{"Blade's Edge Mountains", 530, 1114.010254, 7090.967285, 122.127274},
{"Netherstorm", 530, 2315.689209, 2535.836670, 119.271622},
{"Shadowmoon Valley", 530, -2847.810791, 3190.677246, 8.136728},
{"Zangarmarsh", 530, 30.284981, 6983.303711, 148.666779}
}

-- -----------------------------------------------------------------------------------------------

RegisterItemGossipEvent(PDA_Item_ID, 1, "PDA_Start")
RegisterItemGossipEvent(PDA_Item_ID, 2, "PDA_Select")

local post_temp = {}
local news_temp = {}

print ("############################################")
print ("# WoWPDA B3")
print ("# Funserver Version")
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
	if Player:IsInCombat() then
		Player:SendAreaTriggerMessage("Nicht im Kampf einsetzbar")
		return
	end
	
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
	if RemoveSickness then
		Item:GossipMenuAddItem(30, "Wiederbelebungsnachwirkung entfernen", 3, 0)
	end
	if VollMpHp then
		Item:GossipMenuAddItem(30, "HP/MP Reset", 4, 0)
    end
	if Spell then
		if (Player:GetPlayerClass() == "Shaman") then
			Item:GossipMenuAddItem(30, "Totems", 6, 0)
	    else
			Item:GossipMenuAddItem(30, "Zauber", 5, 0)
	   	end
    end
	if Reitenlernen then
		Item:GossipMenuAddItem(30, "Reiten", 7, 0)
      end
	if (SkillMax ~= 0) then
		Item:GossipMenuAddItem(30, "Fertigkeiten", 8, 0)
   	end
	if (UpLvL ~= 0) then
		Item:GossipMenuAddItem(30, "Level "..UpLvL, 9, 0)
  	end
	if Verwandeln then
		Item:GossipMenuAddItem(30, "Verwandlung", 10, 0)
 	end
	if Tele then
		Item:GossipMenuAddItem(30, "Teleport!", 13, 0)
	end
	Item:GossipMenuAddItem(30, "GMLogin", 300, 1)
	Item:GossipMenuAddItem(30, "About", 11, 0)
	Item:GossipSendMenu(Player)
end

function PDA_Item_Check(_Item, _Player)
	if (_Item ~= 0) then
		if (_Player:GetItemCount(math.abs(_Item)) >= 1) then 
			if (_Item > 0) then
				_Player:RemoveItem(_Item, 1)
			end 
	    else
			_Player:SendAreaTriggerMessage("Ben\195\182tigtes Item nicht vorhanden.")
			return false
		end
	end
	
	return true
end

function PDA_Select(Item, Event, Player, MenuId, id, Code)
	if Player:IsInCombat() then
		Player:SendAreaTriggerMessage("Nicht im Kampf einsetzbar")
		return
	end
	
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
	
	if (id == 3) then
		if PDA_Item_Check(RemoveSickness_item, Player) then
			Player:AddAuraVisual(15007)
			Player:RemoveAura(15007)
		end
		
		PDA_Start(Item, Event, Player)
		return				
	end
	
	if (id == 4) then
		if PDA_Item_Check(VollMpHp_item, Player) then
			Player:SetHealthPct(100)
			Player:SetMana(Player:GetMaxMana())
		end	
		
		PDA_Start(Item, Event, Player)
		return	
	end	
	
	if (id == 5) then
		if not PDA_Item_Check(Spell_item, Player) then
			PDA_Start(Item, Event, Player)
			return
		end		
		
		if (Player:GetPlayerClass() == "Warrior") then
			if Player:GetUInt32Value(34) > 29 then
				Player:LearnSpell(2458)
            end
			if Player:GetUInt32Value(34) > 9 then
				Player:LearnSpell(71)
            end
			if Player:GetUInt32Value(34) > 19 then
				Player:LearnSpell(7386)
        	end
			if Player:GetUInt32Value(34) > 11 then
				Player:LearnSpell(355)
     		end
    	end
    	
		if (Player:GetPlayerClass() == "Mage") then
			if Player:GetUInt32Value(34) > 69 then
				Player:LearnSpell(27090)
            end
      	end
      	
		if (Player:GetPlayerClass() == "Paladin") then
			if Player:GetUInt32Value(34) > 29 then
				Player:LearnSpell(13819)
            end
			if Player:GetUInt32Value(34) > 59 then
				Player:LearnSpell(23214)
            end
 		end
 		
		if (Player:GetPlayerClass() == "Warlock") then
			if Player:GetUInt32Value(34) > 5 then
				Player:LearnSpell(688)
            end
			if Player:GetUInt32Value(34) > 9 then
				Player:LearnSpell(697)
            end
			if Player:GetUInt32Value(34) > 19 then
				Player:LearnSpell(712)
            end
			if Player:GetUInt32Value(34) > 29 then
				Player:LearnSpell(691)
				Player:LearnSpell(5784)
            end
			if Player:GetUInt32Value(34) > 44 then
				Player:LearnSpell(1122)
				Player:LearnSpell(18540)
		    end
			if Player:GetUInt32Value(34) > 59 then
				Player:LearnSpell(23161)
		   	end
        end
        
		if (Player:GetPlayerClass() == "Rogue") then
			if Player:GetUInt32Value(34) > 9 then
				Player:LearnSpell(1804)
				Player:LearnSpell(8681)
				Player:LearnSpell(2842)
	        end
	    end
    
		if (Player:GetPlayerClass() == "Druid") then
			if Player:GetUInt32Value(34) > 7 then
				Player:LearnSpell(5487)
				Player:LearnSpell(18960)
	   		end
			if Player:GetUInt32Value(34) > 15 then
				Player:LearnSpell(1066)
	       	end
			if Player:GetUInt32Value(34) > 19 then
				Player:LearnSpell(768)
	        end
			if Player:GetUInt32Value(34) > 29 then
				Player:LearnSpell(783)
	      	end
			if Player:GetUInt32Value(34) > 39 then
				Player:LearnSpell(9634)
	        end
			if Player:GetUInt32Value(34) > 69 then
				Player:LearnSpell(33943)
				Player:LearnSpell(40120)
	        end
	    end
    
		if (Player:GetPlayerClass() == "Hunter") then
			if Player:GetUInt32Value(34) > 9 then
				Player:LearnSpell(883)
				Player:LearnSpell(2641)
				Player:LearnSpell(6991)
				Player:LearnSpell(982)
				Player:LearnSpell(1515)
				Player:LearnSpell(136)
	        end
	    end

		PDA_Start(Item, Event, Player)
		return
 	end

	if (id == 6)  then
		if PDA_Item_Check(Spell_item, Player) then
			Player:RemoveItem(5175, 1)
			Player:RemoveItem(5176, 1)
			Player:RemoveItem(5177, 1)
			Player:RemoveItem(5178, 1)
			Player:AddItem(5175, 1)
			Player:AddItem(5176, 1)
			Player:AddItem(5177, 1)
			Player:AddItem(5178, 1)
		end
		
		PDA_Start(Item, Event, Player)
		return
   end
   
   if (id == 7) then		
		if Player:GetUInt32Value(34) > 69 then
			if PDA_Item_Check(EpicFlyMount_item, Player) then
				Player:UnlearnSpell(34090)
				Player:UnlearnSpell(33391)
				Player:UnlearnSpell(33388)
				Player:LearnSpell(34091)
				Player:RemoveItem(EpicFlyMount, 1)
				Player:AddItem(EpicFlyMount, 1)
			end
        elseif Player:GetUInt32Value(34) > 67 then
        	if PDA_Item_Check(FlyMount_item, Player) then
				Player:UnlearnSpell(33388)
				Player:UnlearnSpell(33391)
				Player:LearnSpell(34090)
				Player:RemoveItem(FlyMount, 1)
				Player:AddItem(FlyMount, 1)
			end
		elseif Player:GetUInt32Value(34) > 59 then
			if PDA_Item_Check(EpicMount_item, Player) then
				Player:UnlearnSpell(33388)
				Player:LearnSpell(33391)
				Player:RemoveItem(EpicMount, 1)
				Player:AddItem(EpicMount, 1)
			end
		elseif Player:GetUInt32Value(34) > 29 then
			if PDA_Item_Check(Mount_item, Player) then			
				Player:LearnSpell(33388)
				Player:RemoveItem(Mount, 1)
				Player:AddItem(Mount, 1)
			end
		end 
		
		PDA_Start(Item, Event, Player)
		return
	end
	
	if (id == 8) then
	    if PDA_Item_Check(SkillMax_item, Player) then		
			Player:AdvanceSkill(40, SkillMax)
			Player:AdvanceSkill(43, SkillMax)
			Player:AdvanceSkill(44, SkillMax)
			Player:AdvanceSkill(45, SkillMax)
			Player:AdvanceSkill(46, SkillMax)
			Player:AdvanceSkill(54, SkillMax)
			Player:AdvanceSkill(55, SkillMax)
			Player:AdvanceSkill(95, SkillMax)
			Player:AdvanceSkill(129, SkillMax)
			Player:AdvanceSkill(136, SkillMax)
			Player:AdvanceSkill(160, SkillMax)
			Player:AdvanceSkill(162, SkillMax)
			Player:AdvanceSkill(164, SkillMax)
			Player:AdvanceSkill(165, SkillMax)
			Player:AdvanceSkill(171, SkillMax)
			Player:AdvanceSkill(172, SkillMax)
			Player:AdvanceSkill(173, SkillMax)
			Player:AdvanceSkill(176, SkillMax)
			Player:AdvanceSkill(182, SkillMax)
			Player:AdvanceSkill(185, SkillMax)
			Player:AdvanceSkill(186, SkillMax)
			Player:AdvanceSkill(197, SkillMax)
			Player:AdvanceSkill(202, SkillMax)
			Player:AdvanceSkill(226, SkillMax)
			Player:AdvanceSkill(228, SkillMax)
			Player:AdvanceSkill(229, SkillMax)
			Player:AdvanceSkill(333, SkillMax)
			Player:AdvanceSkill(356, SkillMax)
			Player:AdvanceSkill(393, SkillMax)
			Player:AdvanceSkill(433, SkillMax)
			Player:AdvanceSkill(473, SkillMax)
			Player:AdvanceSkill(633, SkillMax)
			Player:AdvanceSkill(755, SkillMax)
		end
		
		PDA_Start(Item, Event, Player)
		return
	end
	
	if (id == 9) then		
		if PDA_Item_Check(LvL_item, Player) then
			Player:SetPlayerLevel(UpLvL)
			Player:SetHealthPct(100)
			Player:SetMana(Player:GetMaxMana())
		end
		
		PDA_Start(Item, Event, Player)
		return
	end
	
	if (id == 10) then	
	    Item:GossipCreateMenu(1, Player, 0)
	    Item:GossipMenuAddItem(0, "[...]", 0, 0)
	    Item:GossipMenuAddItem(2, "Zur\195\188ck verwandeln", 12, 0)
		for i,k in pairs(morph) do
	        Item:GossipMenuAddItem(30, k[2], i+2000, 0)
	        if (i == 12) then
	       		Item:GossipMenuAddItem(2, "[mehr]", 9001, 0)
				break
			end	
		end
		Item:GossipSendMenu(Player)
		return
	end			
	
	if (id == 11) then
		Player:SendBroadcastMessage("WoWPDA\nBuild 3")
	    PDA_Start(Item, Event, Player)
	    return
	end
	
	if (id == 12) then
	    Player:SetModel(Player:GetUInt32Value(153))
	    PDA_Start(Item, Event, Player)
	    return
	end
	
	if (id == 13) then	
	    Item:GossipCreateMenu(1, Player, 0)
	    Item:GossipMenuAddItem(0, "[...]", 0, 0)
	    Item:GossipMenuAddItem(0, "Hauptst\195\164dte", 14, 0)
		for i,k in pairs(teleports) do
	        Item:GossipMenuAddItem(30, k[1], i+3000, 0)
	        if (i == 12) then
	       		Item:GossipMenuAddItem(2, "[mehr]", 10001, 0)
				break
			end	
		end
		Item:GossipSendMenu(Player)
		return
	end	
	
	if (id == 14) then
		Item:GossipCreateMenu(1, Player, 0)
		Item:GossipMenuAddItem(0, "[...]", 0, 0)
		if Player:GetUInt32Value(34) > 57 then 
			Item:GossipMenuAddItem(0, "Shattrath", 4000, 0)
		end
		
		if (table.find({1,3,4,7,11}, Player:GetPlayerRace()) ~= nil) then
			Item:GossipMenuAddItem(0, "Stormwind", 4001, 0)	
			Item:GossipMenuAddItem(0, "Ironforge", 4002, 0)
			Item:GossipMenuAddItem(0, "Darnassus", 4003, 0)	
			Item:GossipMenuAddItem(0, "Exodar", 4004, 0)
		else
			Item:GossipMenuAddItem(0, "Orgrimmar", 4005, 0)	
			Item:GossipMenuAddItem(0, "Undercity", 4006, 0)
			Item:GossipMenuAddItem(0, "Thunderbluff", 4007, 0)	
			Item:GossipMenuAddItem(0, "Silvermoon", 4008, 0)
		end					
		Item:GossipSendMenu(Player)
		return
	end		
	
	if (id == 100) then
        local news_table = PDA_read_file(Player, save_news.."news.txt")
		Item:GossipCreateMenu(2, Player, 0)
		Item:GossipMenuAddItem(0, "[...]", 0, 0)
		for i,k in pairs(news_table) do
	        if (math.floor(i/2 + 0.5) ~= i/2) then
	        	Item:GossipMenuAddItem(30, "[News]"..k, 600+i, 0)
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

	if (id > 2000) and (id < 3000) then
    	if PDA_Item_Check(Verwandeln_item, Player) then
			Player:SetModel(morph[id-2000][1])
		end
		PDA_Select(Item, Event, Player, MenuId, 10, Code)
		return
	end	

	if (id > 3000) and (id < 3400) then
    	if PDA_Item_Check(Tele_item, Player) then
			Player:Teleport(teleports[id-3000][2],teleports[id-3000][3],teleports[id-3000][4],teleports[id-3000][5])
		end
		PDA_Select(Item, Event, Player, MenuId, 13, Code)
		return
	end
	
	if (id == 4000) then
		PDA_Teleport(Player, 530, -1722.58, 5382.7, 2.47504)
		PDA_Select(Item, Event, Player, MenuId, 14, Code)
		return
	end		

	if (id == 4001) then
		PDA_Teleport(Player, 0, -8913.23, 554.633, 94.7944)
		PDA_Select(Item, Event, Player, MenuId, 14, Code)
		return
	end	

	if (id == 4002) then
		PDA_Teleport(Player, 0, -4981.25, -881.542, 502.66)
		PDA_Select(Item, Event, Player, MenuId, 14, Code)
		return
	end	
	
	if (id == 4003) then
		PDA_Teleport(Player, 1, 8795.8, 969.427, 31.1955)
		PDA_Select(Item, Event, Player, MenuId, 14, Code)
		return
	end	
	
	if (id == 4004) then
		PDA_Teleport(Player, 530, -4014.08, -11895.8, -0.99324)
		PDA_Select(Item, Event, Player, MenuId, 14, Code)
		return
	end	
	
	if (id == 4005) then
		PDA_Teleport(Player, 1, 1371.068970, -4370.801758, 26.052483) 
		PDA_Select(Item, Event, Player, MenuId, 14, Code)
		return
	end	
	
	if (id == 4006) then
		PDA_Teleport(Player, 0, 2050.203125, 285.650604, 56.994549)
		PDA_Select(Item, Event, Player, MenuId, 14, Code)
		return
	end	
	
	if (id == 4007) then
		PDA_Teleport(Player, 1, -1304.569946, 205.285004, 68.681396)  
		PDA_Select(Item, Event, Player, MenuId, 14, Code)
		return
	end	
	
	if (id == 4008) then
		PDA_Teleport(Player, 530, 9400.486328, -7278.376953, 14.206780)   
		PDA_Select(Item, Event, Player, MenuId, 14, Code)
		return
	end	
		
	if (id == 9000) then
		PDA_Select(Item, Event, Player, MenuId, 10, Code)
		return
	end
	
	if (id > 9000) then
		t = (id-9000)*13
		Item:GossipCreateMenu(1, Player, 0)
		Item:GossipMenuAddItem(0, "[...]", 0, 0)
		for i,k in pairs(morph) do
	        if (i >= t) and (i <= 12+t) then
				Item:GossipMenuAddItem(30, k[2], i, 0)
			end
	        if (i == 12+t) then
	       		Item:GossipMenuAddItem(2, "[-->Vor-->]", id+1, 0)
				break
			end	
		end
	    Item:GossipMenuAddItem(2, "[<--Zur\195\188ck<--]", id-1, 0)
	    Item:GossipSendMenu(Player)
	    return
	end
	
	
	if (id == 10000) then
		PDA_Select(Item, Event, Player, MenuId, 13, Code)
		return
	end
	
	if (id > 10000) then
		t = (id-10000)*13
		Item:GossipCreateMenu(1, Player, 0)
		Item:GossipMenuAddItem(0, "[...]", 0, 0)
		for i,k in pairs(teleports) do
	        if (i >= t) and (i <= 12+t) then
				Item:GossipMenuAddItem(30, k[1], i, 0)
			end
	        if (i == 12+t) then
	       		Item:GossipMenuAddItem(2, "[-->Vor-->]", id+1, 0)
				break
			end	
		end
		Item:GossipMenuAddItem(2, "[<--Zur\195\188ck<--]", id-1, 0)
	    Item:GossipSendMenu(Player)
	    return
	end
		
end

function PDA_Teleport(_ply, _mapid, _x, _y, _z)
	if PDA_Item_Check(CityTele_item, _ply) then
		_ply:Teleport(_mapid, _x, _y, _z)
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