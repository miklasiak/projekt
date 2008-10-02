#pragma once
void onPlayerLogin(Player* Plr);
void onBountyPvpKill(Player* attacker, Player* victim);
void GetCharName(uint32 guid, char buffer[]);
uint32 GetCharLevel(uint32 guid);

void SetupBountyInformant(ScriptMgr* mgr);