// Script By Miraculix

#include "StdAfx.h"
#include "Setup.h"

#ifdef WIN32
#pragma warning(disable:4305)		// warning C4305: 'argument' : truncation from 'double' to 'float'
#endif

class SCRIPT_DECL WarpNPC : public GossipScript
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
void WarpNPC::GossipHello(Object * pObject, Player* Plr, bool AutoSend)
    {
        GossipMenu *Menu;
        objmgr.CreateGossipMenuForPlayer(&Menu, pObject->GetGUID(), 200000, Plr);
		if (Plr->GetTeam() > 0) {
			Menu->AddItem(0, "Horde Gebiete", 2);
		}else{
			Menu->AddItem(0, "Allianz Gebiete", 4); }
			Menu->AddItem(0, "Neutrale Gebiete", 5);
			Menu->AddItem(0, "Instanzen", 22);
			Menu->AddItem(5, "Shattrath", 6);
			Menu->AddItem(5, "Gurubashi Arena", 7);
			Menu->AddItem(9, "Meine Besonderen F\303\244higkeiten", 8);


        if(AutoSend)
            Menu->SendTo(Plr);
    }

void WarpNPC::GossipSelectOption(Object * pObject, Player* Plr, uint32 Id, uint32 IntId, const char * Code)
    {
	Creature * pCreature = (pObject->GetTypeId()==TYPEID_UNIT)?((Creature*)pObject):NULL;
	if(pCreature==NULL)
		return;
GossipMenu * Menu;
        switch(IntId)
        {
        case 0:     // zurück zum start
				GossipHello(pObject, Plr, true);
            break;
	          
			
        case 2:     // Horde
                {
                objmgr.CreateGossipMenuForPlayer(&Menu, pObject->GetGUID(), 200001, Plr);
					Menu->AddItem(5, "Silvermoon", 9);
					Menu->AddItem(5, "Orgrimmar", 10);
					Menu->AddItem(5, "Thunderbluff", 11);
					Menu->AddItem(5, "UnderCity", 12);
					Menu->AddItem(0, "[Zur\303\274ck]", 21);
					Menu->SendTo(Plr);
				}
			break;
		

		case 4:     // Alliance
				{
                objmgr.CreateGossipMenuForPlayer(&Menu, pObject->GetGUID(), 200002, Plr);
					Menu->AddItem(5, "The Exodar", 13);
					Menu->AddItem(5, "Stormwind", 14);
					Menu->AddItem(5, "Ironforge", 15);
					Menu->AddItem(5, "Darnassus", 16);
					Menu->AddItem(0, "[Zur\303\274ck]", 21);
					Menu->SendTo(Plr);
				}
            break;
			
		case 5:
				{
				objmgr.CreateGossipMenuForPlayer(&Menu, pObject->GetGUID(), 200003, Plr);
					Menu->AddItem(5, "Ratchet", 17);
					Menu->AddItem(5, "Booty Bay", 18);
					Menu->AddItem(0, "[Zur\303\274ck]", 21);
					Menu->SendTo(Plr);
				}
			break;
					
		case  8:
				{
				objmgr.CreateGossipMenuForPlayer(&Menu, pObject->GetGUID(), 200004, Plr);
					Menu->AddItem(3, "Entferne Wiederbelebungs Nachwirkung", 19);
					Menu->AddItem(3, "Mache diesen Platz zu deinem Zuhause", 20);
					Menu->AddItem(0, "[Zur\303\274ck]", 21);
					Menu->SendTo(Plr);
				}
			break;

		case  22:
				{
				objmgr.CreateGossipMenuForPlayer(&Menu, pObject->GetGUID(), 200005, Plr);
					Menu->AddItem(5, "Molten Core", 23);
					Menu->AddItem(5, "Zul Gurub", 24);
					Menu->AddItem(5, "Black Wing Lair", 25);
					Menu->AddItem(5, "BWL", 26);
					Menu->AddItem(5, "Naxxramas", 27);
					Menu->AddItem(0, "[Zur\303\274ck]", 21);
					Menu->SendTo(Plr);
				}
			break;
					
		case 7:  // Gurubashi Arena
			{
				Plr->EventTeleport(0, -13265.340820, 160.127151, 36.019310);
			}
			break;

			//
            // Horde
            //
		
        case 9://Silvermoon
            {
                Plr->EventTeleport(530, 9400.486328, -7278.376953, 14.206780);

            }
			break;

        case 10://Orgrimmar
            {
                Plr->EventTeleport(1, 1371.068970, -4370.801758, 26.052483);
            }
			break;

        case 11://ThunderBluff
            {
                Plr->EventTeleport(1, -1304.569946, 205.285004, 68.681396);
            }
			break;

        case 12://UnderCity
            {
                Plr->EventTeleport(0, 2050.203125, 285.650604, 56.994549);
            }
			break;

            //
            // Alliance 
            //

        case 13: //Exodar
            {
                Plr->EventTeleport(530, -4072.202393, -12014.337891, -1.277277);
            }
			break;

        case 14: //Stormwind
            {
                Plr->EventTeleport(0, -9100.480469, 406.950745, 92.594185);
            }
			break;

        case 15: //Ironforge
            {
                Plr->EventTeleport(0, -5028.265137, -825.976563, 495.301575);
            }
			break;

        case 16: //Darnassus
            {
                Plr->EventTeleport(1, 9985.907227, 1971.155640, 1326.815674);
            }
			break;
			
		case 20: // Bind Position
            {
                Plr->GetSession()->SendInnkeeperBind(pCreature);
			}
			break;
			
		case 19: //Verlernt Wiederbelbungsnachwirkung
				{
            		Plr->addSpell(15007);			// Lernt Wiederbelbungsnachwirkung
					Plr->removeSpell(15007,0,0,0);		//Verlernt Wiederbelbungsnachwirkung
					pCreature->SendChatMessage(CHAT_MSG_MONSTER_SAY, LANG_UNIVERSAL, "Ich habe deine Wiederbelebungsnachwirkung entfernt." );
					Plr->Gossip_Complete();
				}
                break;
				
		case 17: //Ratchet
				{
					Plr->EventTeleport(1, -991.859, -3812.852, 5.5);
				}
				break;
				
		case 6: // Shattrath
				{
					Plr->EventTeleport(530, -1523.40, 5312.05, 9.0066);
				}
				break;
				
		case 18: // Booty bay
				{
					Plr->EventTeleport(0, -14315.94, 442.3346, 23.1208);
				}
				break;

		case 23: // Molten Core
				{
					Plr->EventTeleport(0, -14315.94, 442.3346, 23.1208);
				}
				break;

		case 24: // Zul Gurub
				{
					Plr->EventTeleport(0, -14315.94, 442.3346, 23.1208);
				}
				break;

		case 25: // Black Wing Lair
				{
					Plr->EventTeleport(0, -14315.94, 442.3346, 23.1208);
				}
				break;

		case 26: // BWL
				{
					Plr->EventTeleport(0, -14315.94, 442.3346, 23.1208);
				}
				break;

		case 27: // Naxxramas
				{
					Plr->EventTeleport(0, -14315.94, 442.3346, 23.1208);
				}
				break;
				
		case 21: //main menu
			{
			objmgr.CreateGossipMenuForPlayer(&Menu, pObject->GetGUID(), 200000, Plr);
		if (Plr->GetTeam() > 0) {
			Menu->AddItem(0, "Horde Gebiete", 2);
		}else{
			Menu->AddItem(0, "Allianz Gebiete", 4); }
			Menu->AddItem(0, "Neutrale Gebiete", 5);
			Menu->AddItem(0, "Instanzen", 22);
			Menu->AddItem(5, "Shattrath", 6);
			Menu->AddItem(5, "Gurubashi Arena", 7);
			Menu->AddItem(9, "Meine Besonderen F\303\244higkeiten", 8);
					Menu->SendTo(Plr);
			}
				break;
			
			
 }
    }

void WarpNPC::GossipEnd(Object * pObject, Player* Plr)
{
    GossipScript::GossipEnd(pObject, Plr);
}

void SetupWarpNPC(ScriptMgr * mgr)
{
	GossipScript * gs = (GossipScript*) new WarpNPC();
    /* Teleporter List */
    mgr->register_gossip_script(200000, gs);          // NPC
}