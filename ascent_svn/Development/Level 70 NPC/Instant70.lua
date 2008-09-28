--[[
**********************************************************************************
**********************************************************************************
**				Instant Level 70	  			**
**			   Scripted by Nightblizard   				**
**										**
**			-Instant Level 70					**
**										**
**										**
**										**
**										**
**********************************************************************************
**********************************************************************************
]]--


local Instant70ID = 990000


function Instant_main_menu(pUnit, player)
   	pUnit:GossipCreateMenu(3543, player, 0)
	pUnit:GossipMenuAddItem(1, "Mach mich 70!", 123, 0) 
	pUnit:GossipMenuAddItem(1, "Ich möchte lieber so Leveln", 223, 0)     
  	pUnit:GossipSendMenu(player)
end


function Instant_on_gossip_talk(pUnit, event, player)
   Instant_main_menu(pUnit, player)
end


function Instant_on_gossip_select(pUnit, event, player, id, intid, code)

if(intid == 223) then
   intid = 0
player:GossipComplete()
end


if(intid == 123) then 
player:SetPlayerLevel(70)
player:GossipComplete()
end
end



RegisterUnitGossipEvent(Instant70ID, 1, "Instant_on_gossip_talk")
RegisterUnitGossipEvent(Instant70ID, 2, "Instant_on_gossip_select")