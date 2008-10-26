--[[
**********************************************************************************
**********************************************************************************
**				Class Spell Trainer	  			**
**			   Scripted by Nightblizard   				**
**										**
**			-Gibt alle verbuggten Classpells			**
**										**
**										**
**										**
**										**
**********************************************************************************
**********************************************************************************
]]--

-----------------------------
-----------------------------
---------!!Wichtig!!---------
-----------------------------
-----------------------------

local Trainerid = 1234


-----------------------------
----------ab jetzt-----------
--------!!Unichtig!!---------
-----------------------------
-----------------------------

function Class_main_menu(pUnit, player)
   pUnit:GossipCreateMenu(3543, player, 0)
   pUnit:GossipMenuAddItem(7, "Krieger", 600, 0) 
   pUnit:GossipMenuAddItem(7, "Magier", 601, 0) 
   pUnit:GossipMenuAddItem(7, "Paladin", 602, 0) 
   pUnit:GossipMenuAddItem(7, "Hexenmeister", 603, 0)
   pUnit:GossipMenuAddItem(7, "Schurke", 605, 0) 
   pUnit:GossipMenuAddItem(7, "Druide", 606, 0) 
   pUnit:GossipMenuAddItem(7, "Schamane", 607, 0) 
   pUnit:GossipMenuAddItem(7, "J\195\164ger", 608, 0) 
   pUnit:GossipMenuAddItem(7, "Tsch\195\188ss", 100, 0)     
   pUnit:GossipSendMenu(player)
end


function Class_on_gossip_talk(pUnit, event, player)
   Class_main_menu(pUnit, player)
end


function Class_on_gossip_select(pUnit, event, player, id, intid, code)

if(intid == 600) then
	if(player:GetPlayerClass() == "Warrior") then
		pUnit:SendChatMessage(12, 0, "Willkommen Krieger!")
   		pUnit:GossipCreateMenu(3543, player, 0)
   		pUnit:GossipMenuAddItem(7, "F\195\164higkeiten", 607, 0) 
  		pUnit:GossipMenuAddItem(7, "Tsch\195\188ss", 100, 0)   
  		pUnit:GossipSendMenu(player)
	else
		pUnit:SendChatMessage(12, 0, "Du bist kein Krieger!")
		player:GossipComplete()
	end
end

if(intid == 601) then
	if(player:GetPlayerClass() == "Mage") then
		pUnit:SendChatMessage(12, 0, "Willkommen Magier!")
   		pUnit:GossipCreateMenu(3543, player, 0)
   		pUnit:GossipMenuAddItem(7, "Zauber", 612, 0) 
  		pUnit:GossipMenuAddItem(7, "Tsch\195\188ss", 100, 0)   
  		pUnit:GossipSendMenu(player)
	else
		pUnit:SendChatMessage(12, 0, "Du bist kein Magier!")
		player:GossipComplete()
	end
end

if(intid == 602) then
	if(player:GetPlayerClass() == "Paladin") then
		pUnit:SendChatMessage(12, 0, "Willkommen Paladin!")
   		pUnit:GossipCreateMenu(3543, player, 0)
   		pUnit:GossipMenuAddItem(7, "F\195\164higkeiten", 613, 0)
  		pUnit:GossipMenuAddItem(7, "Tsch\195\188ss", 100, 0)   
  		pUnit:GossipSendMenu(player)
	else
		pUnit:SendChatMessage(12, 0, "Du bist kein Paladin!")
		player:GossipComplete()
	end
end

if(intid == 603) then
	if(player:GetPlayerClass() == "Warlock") then
		pUnit:SendChatMessage(12, 0, "Willkommen Hexenmeister!")
   		pUnit:GossipCreateMenu(3543, player, 0)
   		pUnit:GossipMenuAddItem(7, "Zauber", 616, 0) 
  		pUnit:GossipMenuAddItem(7, "Tsch\195\188ss", 100, 0)   
  		pUnit:GossipSendMenu(player)
	else
		pUnit:SendChatMessage(12, 0, "Du bist kein Hexenmeister!")
		player:GossipComplete()
	end
end

if(intid == 605) then
	if(player:GetPlayerClass() == "Rogue") then
		pUnit:SendChatMessage(12, 0, "Willkommen Schurke!")
   		pUnit:GossipCreateMenu(3543, player, 0)
   		pUnit:GossipMenuAddItem(7, "F\195\164higkeiten", 614, 0)
  		pUnit:GossipMenuAddItem(7, "Tsch\195\188ss", 100, 0)   
  		pUnit:GossipSendMenu(player)
	else
		pUnit:SendChatMessage(12, 0, "Du bist kein Schurke!")
		player:GossipComplete()
	end
end

if(intid == 606) then
	if(player:GetPlayerClass() == "Druid") then
		pUnit:SendChatMessage(12, 0, "Willkommen Druide!")
   		pUnit:GossipCreateMenu(3543, player, 0)
   		pUnit:GossipMenuAddItem(7, "Zauber", 609, 0) 
  		pUnit:GossipMenuAddItem(7, "Tsch\195\188ss", 100, 0)    
  		pUnit:GossipSendMenu(player)
	else
		pUnit:SendChatMessage(12, 0, "Du bist kein Druide!")
		player:GossipComplete()
	end
end

if(intid == 607) then
	if(player:GetPlayerClass() == "Shaman") then
   		pUnit:GossipCreateMenu(3543, player, 0)
		pUnit:SendChatMessage(12, 0, "Willkommen Schamane!")
   		pUnit:GossipMenuAddItem(7, "Totems", 615, 0) 
  		pUnit:GossipMenuAddItem(7, "Tsch\195\188ss", 100, 0)   
  		pUnit:GossipSendMenu(player)
	else
		pUnit:SendChatMessage(12, 0, "Du bist kein Schamane!")
		player:GossipComplete()
	end
end

if(intid == 608) then
	if(player:GetPlayerClass() == "Hunter") then
		pUnit:SendChatMessage(12, 0, "Willkommen J\195\164ger!")
   		pUnit:GossipCreateMenu(3543, player, 0)
   		pUnit:GossipMenuAddItem(7, "F\195\164higkeiten", 611, 0)
  		pUnit:GossipMenuAddItem(7, "Tsch\195\188ss", 100, 0)   
  		pUnit:GossipSendMenu(player)
	else
		pUnit:SendChatMessage(12, 0, "Du bist kein J\195\164ger!")
		player:GossipComplete()
	end
end

if(intid == 609) then --Druide
	player:LearnSpell(5487) --Bear Form
	player:LearnSpell(18960) --Teleport: Moonglade
	player:LearnSpell(1066) --Wasser Form
	player:LearnSpell(768) --Cat Form
	player:LearnSpell(783) --Travel Form
	player:LearnSpell(9634) --Dire Bear Form
	player:LearnSpell(33943) --Flight Form
	player:LearnSpell(40120) --Swift Flight Form
	player:GossipComplete()
end

if(intid == 611) then --Hunter
	player:LearnSpell(883) --Call Pet
	player:LearnSpell(2641) --Dismiss Pet
	player:LearnSpell(6991) --Feed Pet
	player:LearnSpell(982) --Revive Pet
	player:LearnSpell(1515) --Tame Beast
	player:LearnSpell(136) --Mend Pet
	player:GossipComplete()
end

if(intid == 612) then --Mage
	player:LearnSpell(5505)
	player:LearnSpell(597)
	player:LearnSpell(5505)
	player:LearnSpell(597)
	player:LearnSpell(5506)
	player:LearnSpell(990)
	player:LearnSpell(6127)
	player:LearnSpell(6129)
	player:LearnSpell(10138)
	player:LearnSpell(10144)
	player:LearnSpell(10139)
	player:LearnSpell(10145)
	player:LearnSpell(28612)
	player:LearnSpell(10140)
	player:LearnSpell(37420)
	player:LearnSpell(33717)
	player:LearnSpell(27090)
	player:GossipComplete()
end

if(intid == 613) then --Pala
	player:LearnSpell(13819)
	player:LearnSpell(7328)
	player:LearnSpell(23214)
	player:GossipComplete()
end

if(intid == 614) then --Rogue
	player:LearnSpell(1804)
	player:LearnSpell(8681)
	player:LearnSpell(2842)
	player:GossipComplete()
end

if(intid == 615) then --Shaman
	player:AddItem(5175, 1)
	player:AddItem(5176, 1)
	player:AddItem(5177, 1)
	player:AddItem(5178, 1)
	player:GossipComplete()
end

if(intid == 616) then --Warlock
	player:LearnSpell(688)
	player:LearnSpell(697)
	player:LearnSpell(712)
	player:LearnSpell(691)
	player:LearnSpell(5784)
	player:LearnSpell(1122)
	player:LearnSpell(18540)
	player:LearnSpell(23161)
	player:GossipComplete()
end

if(intid == 617) then --Warrior
	player:LearnSpell(2458)
	player:LearnSpell(71)
	player:LearnSpell(7386)
	player:LearnSpell(355)
	player:GossipComplete()
end

if(intid == 100) then
   	intid = 0
	player:GossipComplete()
end
end

RegisterUnitGossipEvent(Trainerid, 1, "Class_on_gossip_talk")
RegisterUnitGossipEvent(Trainerid, 2, "Class_on_gossip_select")