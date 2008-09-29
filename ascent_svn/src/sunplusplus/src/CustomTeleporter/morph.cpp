//Title of Script: Portable Morpher
//Description of Script: Morphs the player into a few different creatures using a item.
//Original Script Author: Arotho
#include "StdAfx.h"
#include "Setup.h"

#ifdef WIN32
#pragma warning(disable:4305)        // warning C4305: 'argument' : truncation from 'double' to 'float'
#endif

  //Start of Script
class SCRIPT_DECL Morpher : public GossipScript
{
public:
    void GossipHello(Object * pObject, Player* Plr, bool AutoSend);
    void GossipSelectOption(Object * pObject, Player* Plr, uint32 Id, uint32 IntId, const char * Code);
    void GossipEnd(Object * pObject, Player* Plr);
    void Destroy()
    {
    delete this;
    }
};
    void Morpher::GossipHello(Object* pObject, Player * Plr, bool AutoSend)
    {
        GossipMenu *Menu;
        objmgr.CreateGossipMenuForPlayer(&Menu, pObject->GetGUID(), 2593, Plr);
        Menu->AddItem(0, "Goblin", 0);
        Menu->AddItem(0, "Felguard", 2);
        Menu->AddItem(0, "Broken", 3);
        Menu->AddItem(0, "Oger", 4);
        Menu->AddItem(0, "Pirat", 5);
        Menu->AddItem(0, "Skelett", 6);
        Menu->AddItem(0, "Infernal", 7);
		Menu->AddItem(0, "AmaniB\195\164r", 8);
		Menu->AddItem(0, "Samuro", 9);
		Menu->AddItem(0, "Illidan Sturmgrimm", 10);
		Menu->AddItem(0, "Akama", 11);
		Menu->AddItem(0, "Baby Murloc", 12);
		Menu->AddItem(0, "Flik's Frosch", 13);
		Menu->AddItem(0, "SpartanWoW Wache", 14);
        Menu->AddItem(2, "Demorph", 15);

           if(AutoSend)
            Menu->SendTo(Plr);
    }


//Defining Cases
void Morpher::GossipSelectOption(Object* pObject, Player* Plr, uint32 Id, uint32 IntId, const char * Code)
    {
        GossipMenu * Menu;
        switch(IntId)
        {
            //Goblin
        case 0:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 7109);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->Gossip_Complete();
            }break;

            
            //FelGuard
        case 2:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 18287);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->Gossip_Complete();
            }break;
            
            //Broken
        case 3:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 17833);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->Gossip_Complete();
            }break;
            
            //Ogre
        case 4:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 1122);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->Gossip_Complete();
            }break;
            
            //Pirate
        case 5:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 2347);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->Gossip_Complete();
            }break;

            //Skeleton
        case 6:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 17970);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->Gossip_Complete();
            }break;

        //Infernal
        case 7:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 169);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->Gossip_Complete();
            }break;

    //Amani Bear
        case 8:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 22467);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->Gossip_Complete();
            }break;

    //Samuro
        case 9:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 21665);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->Gossip_Complete();
            }break;
    
    //Illidan Stormrage
        case 10:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 21135);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->Gossip_Complete();
            }break; 

        //Akama
        case 11:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 20681);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->Gossip_Complete();
            }break; 

        //Baby Murloc
        case 12:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 15394);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->Gossip_Complete();
            }break; 

        //Flik's Frog
        case 13:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 14936);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->Gossip_Complete();
            }break; 

        //SpartanWoW Guard
        case 14:
            {
                Plr->SetUInt32Value(UNIT_FIELD_DISPLAYID, 19386);
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->Gossip_Complete();
            }break; 

    //Demorph :P
        case 15:
            {
                Plr->Emote(EMOTE_ONESHOT_CHEER);
                Plr->DeMorph();
                Plr->Gossip_Complete();
            }break;
        


        }
};

void Morpher::GossipEnd(Object * pObject, Player* Plr)
{
GossipScript::GossipEnd(pObject, Plr);
}

void SetupMorpher(ScriptMgr * mgr)
{
GossipScript * gs = (GossipScript*) new Morpher();
mgr->register_item_gossip_script(200000,gs);
}