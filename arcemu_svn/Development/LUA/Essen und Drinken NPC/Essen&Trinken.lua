--[[
**********************************************************************************
**********************************************************************************
**				Essen & Trinken		  			**
**			   Scripted by Nightblizard   				**
**										**
**			-Gibt 20x Essen						**
**			-Gibt 20x Trinken					**
**			-Essen & Trinken für verschiedene Level			**
**										**
**										**
**********************************************************************************
**********************************************************************************
]]--


local EssenTrinkenID = 990001

function EssenTrinken_main_menu(pUnit, player)
   pUnit:GossipCreateMenu(3543, player, 0)
   pUnit:GossipMenuAddItem(0, "Brauche Essen/Trinken", 2, 0)     
   pUnit:GossipSendMenu(player)
end


function EssenTrinken_on_gossip_talk(pUnit, event, player)
   EssenTrinken_main_menu(pUnit, player)
end


function EssenTrinken_on_gossip_select(pUnit, event, player, id, intid, code)

if(intid == 2) then
pUnit:GossipCreateMenu(3543, player, 0)
pUnit:GossipMenuAddItem(1, "Essen 5+", 15, 0)
pUnit:GossipMenuAddItem(1, "Trinken 5+", 16, 0)
pUnit:GossipMenuAddItem(1, "Essen 15+", 17, 0)
pUnit:GossipMenuAddItem(1, "Trinken 15+", 18, 0)
pUnit:GossipMenuAddItem(1, "Essen 25+", 19, 0)
pUnit:GossipMenuAddItem(1, "Trinken 25+", 20, 0)
pUnit:GossipMenuAddItem(1, "Essen 35+", 21, 0)
pUnit:GossipMenuAddItem(1, "Trinken 35+", 22, 0)
pUnit:GossipMenuAddItem(1, "Essen 45+", 23, 0)
pUnit:GossipMenuAddItem(1, "Trinken 45+", 24, 0)
pUnit:GossipMenuAddItem(1, "Essen 55+", 25, 0)
pUnit:GossipMenuAddItem(1, "Trinken 55+", 26, 0)
pUnit:GossipMenuAddItem(1, "Essen 65+", 9, 0)
pUnit:GossipMenuAddItem(1, "Trinken 65+", 10, 0)
pUnit:GossipMenuAddItem(7, "Back", 100, 0)
pUnit:GossipSendMenu(player)
end

if(intid == 9) then --
player:AddItem(29449, 20)
player:GossipComplete()
end

if(intid == 10) then --
player:AddItem(27860, 20)
player:GossipComplete()
end

if(intid == 15) then --
player:AddItem(1113, 20)
player:GossipComplete()
end

if(intid == 16) then -- 
player:AddItem(2288, 20)
player:GossipComplete()
end

if(intid == 17) then --
player:AddItem(1114, 20)
player:GossipComplete()
end

if(intid == 18) then --
player:AddItem(2136, 20)
player:GossipComplete()
end

if(intid == 19) then --
player:AddItem(1487, 20)
player:GossipComplete()
end

if(intid == 20) then --
player:AddItem(3772, 20)
player:GossipComplete()
end

if(intid == 21) then -- 
player:AddItem(8075, 20)
player:GossipComplete()
end

if(intid == 22) then --
player:AddItem(8077, 20)
player:GossipComplete()
end

if(intid == 23) then --
player:AddItem(8076, 20)
player:GossipComplete()
end

if(intid == 24) then --
player:AddItem(8078, 20)
player:GossipComplete()
end

if(intid == 25) then --
player:AddItem(22895, 20)
player:GossipComplete()
end

if(intid == 26) then --
player:AddItem(8079, 20)
player:GossipComplete()
end

if(intid == 100) then
   intid = 0
   NPC_main_menu(pUnit, player)
end
end

RegisterUnitGossipEvent(EssenTrinkenID, 1, "EssenTrinken_on_gossip_talk")
RegisterUnitGossipEvent(EssenTrinkenID, 2, "EssenTrinken_on_gossip_select")