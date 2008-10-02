#include "StdAfx.h"
#include "Setup.h"

void onPlayerLogin(Player* Plr){
	static QueryResult *result = NULL;
	result = WorldDatabase.Query("SELECT `bounty` FROM `BountyHunter` WHERE `target`='%i' AND `contractor`='0'", Plr->GetGUID());
	if(!result) return; 

	Plr->BroadcastMessage("Auf dich wurde ein Kopfgeld ausgesetzt!");
	uint32 bounty=0, total=0;
	do{
		Field *fields = result->Fetch();
        bounty += fields[0].GetUInt32();
		total++;
	}while(result->NextRow());
	Plr->BroadcastMessage("Kopfgeld: %i von %i Auftraggebern", bounty, total);
}
void onBountyPvpKill(Player* attacker, Player* victim){
	if(attacker->GetGUID() == victim->GetGUID()) return;
	static QueryResult *result = NULL;
	result = WorldDatabase.Query("SELECT * FROM `BountyHunter` WHERE `target`='%i' AND `contractor`='0'", victim->GetGUID());
	if(!result) return; //No bounties
	uint32 total=0, bounty=0, client=0, id=0;
	string start;
	do{
		Field *fields = result->Fetch();
		id     = fields[0].GetUInt32();
		client = fields[1].GetUInt32();
		bounty = fields[3].GetUInt32();
		start  = fields[4].GetString();
		if(bounty < 0) bounty *= -1; //Make sure it's a positive bounty
		
		char clientName[50];
		GetCharName(client, clientName);
		attacker->BroadcastMessage("$%i from %s started %s", bounty, clientName);
		WorldDatabase.Query("UPDATE `BountyHunter` SET `finish` = NOW(), `level`='%i', `contractor`='%i' WHERE `id`='%i' LIMIT 1;",
			victim->getLevel(), attacker->GetGUID(), id);
		total += bounty;
	}while(result->NextRow());
	attacker->BroadcastMessage("Erhaltenes Kopfgeld:");	
	attacker->BroadcastMessage("Earned %ic", total);
	uint32 currentgold = attacker->GetUInt32Value(PLAYER_FIELD_COINAGE);
	attacker->SetUInt32Value(PLAYER_FIELD_COINAGE,currentgold+total); 
}

void SetupBountyHunter(ScriptMgr* mgr){
	mgr->register_hook(SERVER_HOOK_EVENT_ON_KILL_PLAYER, onBountyPvpKill);
	mgr->register_hook(SERVER_HOOK_EVENT_ON_ENTER_WORLD, onPlayerLogin);
}