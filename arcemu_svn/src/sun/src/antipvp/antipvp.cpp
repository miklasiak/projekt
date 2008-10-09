#include "StdAfx.h"
#include "Setup.h"
void EventKillHandler(Player * pPlayer, Player * pVictim)
{
    uint32 BannedZoneId = 616;
    AreaTable * at = dbcArea.LookupEntry(pPlayer->GetMapMgr()->GetAreaID(pPlayer->GetPositionX(), pPlayer->GetPositionY()));
    if( at->ZoneId == BannedZoneId )
    {
        char onkick[1024];
        snprintf((char*)onkick, 1024, "%s was caught PvPing in the mall.", pPlayer->GetName());
        sWorld.SendWorldText(onkick);
        pPlayer->BroadcastMessage("You were teleported to your starting zone for PvPing in the mall.");
            PlayerCreateInfo *info = NULL;
            for(uint32 i=1;i<11;i++)
            {
               info = objmgr.GetPlayerCreateInfo(raceid, i);
               if(info != NULL) break;
            }
    
            if(info == NULL)
            {
               return;
            }

            m_session->GetPlayer()->SafeTeleport(info->mapId, 0, LocationVector(info->positionX, info->positionY, info->positionZ));
        return;
    }
}
void SetupAntiPvP(ScriptMgr * mgr)
{
    mgr->register_hook(SERVER_HOOK_EVENT_ON_KILL_PLAYER, (void *) EventKillHandler);
}