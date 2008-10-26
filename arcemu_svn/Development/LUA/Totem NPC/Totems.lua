-- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------
-- ## Made By Neo© ##
-- Mitwirkende:
-- ## Ronce -- Unterstützung und Hilfe ##
-- ## ##
-- ---------- ---------- ---------- ---------- ---------- ---------- ---------- ----------

-- Welche EntryID soll der Npc haben?
local NpcID = 900006


function Totem_main_menu(pUnit, player)
   pUnit:GossipCreateMenu(3543, player, 0)

   pUnit:GossipMenuAddItem(1, "Totems geben", 550, 0)
   pUnit:GossipMenuAddItem(6, "Totems entfernen", 551, 0)
   pUnit:GossipMenuAddItem(0, "Auf Wiedersehen", 552, 0)
   pUnit:GossipSendMenu(player)
end

function Totem_ongossiptalk(pUnit, event, player)
   Totem_main_menu(pUnit, player)
end

  function Totem_ongossipselect(pUnit, event, player, id, intid, code, pMisc)    
  if (intid == 550) then
  if (player:GetPlayerClass() == "Shaman") then
  player:RemoveItem(5178, 1)
  player:RemoveItem(5175, 1)
  player:RemoveItem(5176, 1)
  player:RemoveItem(5177, 1)
  player:AddItem(5175, 1)
  player:AddItem(5176, 1)
  player:AddItem(5177, 1)
  player:AddItem(5178, 1)
  player:GossipComplete()
  pUnit:SendChatMessage(12, 0, "Totems erfolgreich geaddet!")

else
  player:GossipComplete(player)
  pUnit:SendChatMessage(12, 0, "TuT Mir Leid du bist leider kein Schamane!")
end
end                                   
  if (intid == 551) then
  player:RemoveItem(5175, 1)
  player:RemoveItem(5176, 1)
  player:RemoveItem(5177, 1)
  player:RemoveItem(5178, 1)
  player:GossipComplete()
  pUnit:SendChatMessage(12, 0, "Totems erfolgreich entfernt!")
end                                    
  if (intid == 552) then
  player:GossipComplete()
  pUnit:SendChatMessage(12, 0, "Auf Wiedersehen")
end
end

RegisterUnitGossipEvent(900006, 1, "Totem_ongossiptalk")
RegisterUnitGossipEvent(900006, 2, "Totem_ongossipselect")