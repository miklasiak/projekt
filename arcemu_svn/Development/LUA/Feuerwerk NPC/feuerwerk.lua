local npcid = 121214
function WarpNPC_OnGossipTalk(pUnit, event, player, pMisc)
pUnit:GossipCreateMenu(100, player, 0)
pUnit:GossipMenuAddItem(5, "Buff mich bitte.", 57, 0)
pUnit:GossipSendMenu(player)
end
function WarpNPC_OnGossipSelect(pUnit, event, player, id, intid, code, pMisc)
if (intid == 57) then
pUnit:GossipCreateMenu(99, player, 0)
pUnit:GossipMenuAddItem(3, "Agility", 59, 0)
pUnit:GossipSendMenu(player)
end
if (intid == 59) then
pUnit:CastSpellOnTarget(46830, player)
pUnit:GossipComplete(player)
end
if (intid == 59) then
pUnit:CastSpellOnTarget(46835, player)
pUnit:GossipComplete(player)
end
if (intid == 59) then
pUnit:CastSpellOnTarget(46829, player)
pUnit:GossipComplete(player)
end
if (intid == 59) then
pUnit:CastSpellOnTarget(46847, player)
pUnit:GossipComplete(player)
end
if (intid == 59) then
pUnit:CastSpellOnTarget(11543, player)
pUnit:GossipComplete(player)
end
if (intid == 59) then
pUnit:CastSpellOnTarget(11542, player)
pUnit:GossipComplete(player)
end
if (intid == 59) then
pUnit:CastSpellOnTarget(47004, player)
pUnit:GossipComplete(player)
end
if (intid == 59) then
pUnit:CastSpellOnTarget(11352, player)
pUnit:GossipComplete(player)
end
if (intid == 59) then
pUnit:CastSpellOnTarget(6668, player)
pUnit:GossipComplete(player)
end
if (intid == 59) then
pUnit:CastSpellOnTarget(30161, player)
pUnit:GossipComplete(player)
end
if (intid == 59) then
pUnit:CastSpellOnTarget(11541, player)
pUnit:GossipComplete(player)
end
if (intid == 59) then
pUnit:CastSpellOnTarget(25465, player)
pUnit:GossipComplete(player)
end
if (intid == 59) then
pUnit:CastSpellOnTarget(11540, player)
pUnit:GossipComplete(player)
end
end
RegisterUnitGossipEvent(npcid, 1, "WarpNPC_OnGossipTalk")
RegisterUnitGossipEvent(npcid, 2, "WarpNPC_OnGossipSelect")