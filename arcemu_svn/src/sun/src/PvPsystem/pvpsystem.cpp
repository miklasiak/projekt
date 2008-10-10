//Made by ???
//Modified by WigSplitta whole code
//Re-Modified by HalestormXV (Added More Features)
//Random Dice Concept to Kuraria for Helping me


#include "StdAfx.h"

#define GOLD_AMOUNT 1000000  //it is in copper
                    
#define PVP_TOKEN 1260 //Put Your Token ID Here    

void onPvpKill(Player* plr, Player* victim)
{
   if(plr->getLevel() >= 80 && victim->getLevel() >= 80 && plr->GetTeam() != victim->GetTeam())
   {
      char message[200];
      sprintf(message, "|cff00ff00[World PvP]|r |cffff0000%s has killed %s...The hunt begins!|r", plr->GetName(), victim->GetName());
      sWorld.SendWorldWideScreenText(message);
      sLog.outColor(TRED,"\n[WPVP]: WPVP Activated - the killer was %s...The victim was %s.", plr->GetName(), victim->GetName());
      sLog.outColor(TNORMAL,"\n");
      int32 gold_check_p = plr->GetUInt32Value( PLAYER_FIELD_COINAGE );
      int32 gold_check_v = victim->GetUInt32Value( PLAYER_FIELD_COINAGE );
      int32 new_gold_p = gold_check_p + GOLD_AMOUNT;
      int32 new_gold_v;
      if(gold_check_v < GOLD_AMOUNT)
      {
         new_gold_v = 0;
      }
      else
      {
         new_gold_v = gold_check_v - GOLD_AMOUNT;
      }
      plr->SetUInt32Value( PLAYER_FIELD_COINAGE, new_gold_p );
      plr->BroadcastMessage("You have gained 100 gold for this kill and the victim's soul for your own use.");
      plr->CastSpell(plr, 27239, true);
      plr->PlaySoundToSet(11466);
      victim->SetUInt32Value( PLAYER_FIELD_COINAGE, new_gold_v );
      victim->BroadcastMessage("You have lost 100 gold and your soul! Learn to fight!!");


      int die;
      die = rand()%5 + 1;
      if((die == 1) || (die == 2))
      {
         plr->GetItemInterface()->SafeAddItem(PVP_TOKEN, INVENTORY_SLOT_NOT_SET, -1);
         Item * it = objmgr.CreateItem(PVP_TOKEN, plr);
         plr->GetItemInterface()->AddItemToFreeSlot(it);
         sLog.outColor(TGREEN,"[WPVP]: A Token was added for this kill to %s", plr->GetName());
         sLog.outColor(TNORMAL,"\n");
      }
      else
      {
         sLog.outColor(TYELLOW,"[WPVP]: A Token was not added to %s", plr->GetName());
         sLog.outColor(TNORMAL,"\n");
      }

   }
}
void SetupPvP(ScriptMgr * mgr)
{
   mgr->register_hook(SERVER_HOOK_EVENT_ON_KILL_PLAYER, (void*)onPvpKill);
}