#include "StdAfx.h"
#include "Setup.h"


#define BOUNTYINFORMANT 200004
class SCRIPT_DECL BountyInformant : public GossipScript{
public:
    void GossipHello(Object *pObject, Player *Plr, bool AutoSend);
    void GossipSelectOption(Object *pObject, Player *Plr, uint32 Id, uint32 IntId, const char *Code);
    void GossipEnd(Object *pObject, Player *Plr);
};

void BountyInformant::GossipHello(Object *pObject, Player *Plr, bool AutoSend){
	GossipMenu *Menu;
    objmgr.CreateGossipMenuForPlayer(&Menu, pObject->GetGUID(), 1, Plr);
	Menu->AddItem(0, "Hast du irgendwelche Jobs f\303\274r mich?", 1);
    if(AutoSend) Menu->SendTo(Plr);
}

void BountyInformant::GossipSelectOption(Object *pObject, Player *Plr, uint32 Id, uint32 IntId, const char *Code){
	Creature * pCreature = (pObject->GetTypeId()==TYPEID_UNIT) ? ((Creature*)pObject) : NULL;
	switch(IntId){
		case 1:{
            QueryResult *result = WorldDatabase.Query("SELECT * FROM `BountyHunter` WHERE `contractor`='0' ORDER BY `bounty` DESC", Plr->GetGUID());
			if(!result){
				pCreature->SendChatMessage(CHAT_MSG_MONSTER_SAY, LANG_UNIVERSAL, "Heute gibt es keine Arbeit f\303\274r dich.");
				Plr->Gossip_Complete();
			}else{
				GossipMenu *Menu;
				objmgr.CreateGossipMenuForPlayer(&Menu, pObject->GetGUID(), 1, Plr);
				uint32 id=0, bounty=0;
				do{
					Field *fields = result->Fetch();
					char buffer[100];
					char name[25];
					char client[25];
					uint32 level;
					id = fields[0].GetUInt32();
					bounty = fields[3].GetUInt32();
					GetCharName(fields[2].GetUInt32(), name);
					GetCharName(fields[1].GetUInt32(), client);
					level = GetCharLevel(fields[2].GetUInt32());
					sprintf(buffer, "%s: %i for %s (lvl %i)", client, bounty, name, level);
					Menu->AddItem(0, buffer, id+3);
				}while(result->NextRow());
				Menu->SendTo(Plr);
			}
			break;
		}
		default:{
			QueryResult *result = WorldDatabase.Query("SELECT * FROM `BountyHunter` WHERE `contractor`='0' AND `id`='%i'",IntId-3);
			if(!result){
				pCreature->SendChatMessage(CHAT_MSG_MONSTER_SAY, LANG_UNIVERSAL, "Ich weis nicht wovon du redest.");
			}else{
				Field *fields = result->Fetch();
				char buffer[0x100];
				char client[50], target[50];
				GetCharName(fields[1].GetUInt32(), client);
				GetCharName(fields[2].GetUInt32(), target);

				sprintf(buffer, "\nClient: %s\nTarget: %s\nLevel: %i\nReward: %i\nStarted: %s", client, target, GetCharLevel(fields[2].GetUInt32()), fields[3].GetUInt32(), fields[4].GetString());
				pCreature->SendChatMessage(CHAT_MSG_MONSTER_SAY, LANG_UNIVERSAL, buffer);
			}
			Plr->Gossip_Complete();
		}
	}
}

void BountyInformant::GossipEnd(Object * pObject, Player* Plr){ GossipScript::GossipEnd(pObject, Plr); }

void SetupBountyInformant(ScriptMgr* mgr){
	mgr->register_gossip_script(BOUNTYINFORMANT, (GossipScript*) new BountyInformant());
}

void GetCharName(uint32 guid, char buffer[]){
	QueryResult *result = CharacterDatabase.Query("SELECT `name` FROM `characters` WHERE `guid`='%i'", guid);
	if(!result){
		sprintf(buffer, "UnknownName[%i]", guid);
	}else{
		Field *fields = result->Fetch();
		sprintf(buffer, "%s", fields[0].GetString());
	}
}
uint32 GetCharLevel(uint32 guid){
	QueryResult *result = CharacterDatabase.Query("SELECT `level` FROM `characters` WHERE `guid`='%i'", guid);
	if(!result){
		return -1;
	}else{
		Field *fields = result->Fetch();
		return fields[0].GetUInt32();
	}
}