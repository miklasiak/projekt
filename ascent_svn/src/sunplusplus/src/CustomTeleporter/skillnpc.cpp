//Title of Script: SkillNPC
//Description of Script: Adds the players their skills
//Original Script Author: Arotho

#include "StdAfx.h"
#include "Setup.h"

class SCRIPT_DECL SkillNPC : public GossipScript{
public:
    void GossipHello(Object *pObject, Player *Plr, bool AutoSend);
    void GossipSelectOption(Object *pObject, Player *Plr, uint32 Id, uint32 IntId, const char *Code);
    void GossipEnd(Object *pObject, Player *Plr);
	void Destroy(){ delete this; }
};
void SkillNPC::GossipEnd(Object * pObject, Player* Plr){ GossipScript::GossipEnd(pObject, Plr); }
void SkillNPC::GossipHello(Object *pObject, Player *Plr, bool AutoSend){
	GossipMenu *Menu;
    objmgr.CreateGossipMenuForPlayer(&Menu, pObject->GetGUID(), 1, Plr);
				if (Plr->getClass() == 1) 
 { 
Menu->AddItem(0, "Welche Zauber k\195\182nnen Krieger lernen?", 1);
 } 
				if (Plr->getClass() == 2)
 { 
Menu->AddItem(0, "Welche Zauber k\195\182nnen Paladine lernen?", 2);
 }
				if (Plr->getClass() == 3)
 { 
Menu->AddItem(0, "Welche Zauber k\195\182nnen J\195\164ger lernen?", 3);
 }
				if (Plr->getClass() == 9)
 { 
Menu->AddItem(0, "Welche Zauber k\195\182nnen Hexenmeister lernen?", 4);
 }
				if (Plr->getClass() == 11)
 { 
Menu->AddItem(0, "Welche Zauber k\195\182nnen Druiden lernen?", 5);
 }
				if (Plr->getClass() == 4) 
 { 
Menu->AddItem(0, "Welche Zauber k\195\182nnen Schurken lernen?", 6);
 } 
				if (Plr->getClass() == 5) 
 { 
Menu->AddItem(0, "Welche Zauber k\195\182nnen Priester lernen?", 7);
 } 
				if (Plr->getClass() == 7) 
 { 
Menu->AddItem(0, "Welche Zauber k\195\182nnen Schamanen lernen?", 8);
 } 
				if (Plr->getClass() == 8) 
 { 
Menu->AddItem(0, "Welche Zauber k\195\182nnen Magier lernen?", 9);
 } 


Menu->AddItem(5, "Talentpunkte zur\195\188cksetzen", 98);

    Menu->SendTo(Plr);
}


void SkillNPC::GossipSelectOption(Object *pObject, Player *Plr, uint32 Id, uint32 IntId, const char *Code){
	Creature * pCreature = (pObject->GetTypeId()==TYPEID_UNIT) ? ((Creature*)pObject) : NULL;
	GossipMenu * Menu;
	switch(IntId){
	case 0:     // Return to start
				GossipHello(pObject, Plr, true);
            break;

case 1:
objmgr.CreateGossipMenuForPlayer(&Menu, pCreature->GetGUID(), 1, Plr);
Menu->AddItem(5, "Spott", 10);
Menu->AddItem(5, "Abfangen", 13);
Menu->AddItem(5, "Tödlicher Stoß", 14);
Menu->AddItem(5, "Verteidigungshaltung", 11);
Menu->AddItem(5, "Berserkerhaltung", 12);
Menu->AddItem(0, "[Zur\195\188ck]", 99);
Menu->SendTo(Plr);
break;

case 2:
objmgr.CreateGossipMenuForPlayer(&Menu, pCreature->GetGUID(), 1, Plr);
Menu->AddItem(5, "Erl\195\182sung", 22);
Menu->AddItem(5, "Schlachtross beschw\195\182ren", 20);
Menu->AddItem(5, "Streitross beschw\195\182ren", 21);
Menu->AddItem(0, "[Zur\195\188ck]", 99);
Menu->SendTo(Plr);
break;

case 3:
objmgr.CreateGossipMenuForPlayer(&Menu, pCreature->GetGUID(), 1, Plr);
Menu->AddItem(5, "Pet spells", 30);
Menu->AddItem(0, "[Zur\195\188ck]", 99);
Menu->SendTo(Plr);
break;

case 4:
objmgr.CreateGossipMenuForPlayer(&Menu, pCreature->GetGUID(), 1, Plr);
Menu->AddItem(5, "Pet Spells", 40);
Menu->AddItem(5, "Teufelsross beschw\195\182ren", 41);
Menu->AddItem(5, "Schreckensross beschw\195\182ren", 42);
Menu->AddItem(0, "[Zur\195\188ck]", 99);
Menu->SendTo(Plr);
break;

case 5:
objmgr.CreateGossipMenuForPlayer(&Menu, pCreature->GetGUID(), 1, Plr);
Menu->AddItem(5, "Knurren", 50);
Menu->AddItem(5, "Zerfleischen", 55);
Menu->AddItem(5, "B\195\164rengestalt", 54);
Menu->AddItem(5, "Terrorb\195\164rengestalt", 51);
Menu->AddItem(5, "Wassergestalt", 56);
Menu->AddItem(5, "Fluggestalt", 52);
Menu->AddItem(5, "Schnelle Fluggestalt", 53); 
Menu->AddItem(0, "[Zur\195\188ck]", 99);
Menu->SendTo(Plr);
break;

case 6:
objmgr.CreateGossipMenuForPlayer(&Menu, pCreature->GetGUID(), 1, Plr);
Menu->AddItem(0, "[Zur\195\188ck]", 99);
Menu->SendTo(Plr);
break;

case 7:
objmgr.CreateGossipMenuForPlayer(&Menu, pCreature->GetGUID(), 1, Plr);
Menu->AddItem(0, "[Zur\195\188ck]", 99);
Menu->SendTo(Plr);
break;

case 8:
objmgr.CreateGossipMenuForPlayer(&Menu, pCreature->GetGUID(), 1, Plr);
Menu->AddItem(0, "[Zur\195\188ck]", 99);
Menu->SendTo(Plr);
break;

case 9:
objmgr.CreateGossipMenuForPlayer(&Menu, pCreature->GetGUID(), 1, Plr);
Menu->AddItem(0, "[Zur\195\188ck]", 99);
Menu->SendTo(Plr);
break;

        case 10:     // Warrior-Taunt
			if(Plr->getLevel() >= 10)
			{
				Plr->addSpell(355);
				Plr->BroadcastMessage("Du hast Spott erlernt.");
			}else{
				Plr->BroadcastMessage("Du musst mindestens Level 10 sein, um Spott zu erlernen.");
				}
			break;

	case 11:     // Warrior-Defensive Stance
			if(Plr->getLevel() >= 10)
			{
				Plr->addSpell(71);
				Plr->BroadcastMessage("Du hast die Verteidigungshaltung erlernt.");
			}else{
				Plr->BroadcastMessage("Du musst mindestens Level 10 sein, um die Verteidigungshaltung zu erlernen.");
				}
			break;

	case 12:     // Warrior-Beserker Stance
			if(Plr->getLevel() >= 30)
			{
				Plr->addSpell(2458);
				Plr->BroadcastMessage("Du hast die Berserkerhaltung erlernt.");
			}else{
				Plr->BroadcastMessage("Du musst mindestens Level 30 sein, um die Berserkerhaltung zu erlernen.");
				}
			break;

	case 13:     // Warrior-Intercept
			if(Plr->getLevel() >= 10)
			{
				Plr->addSpell(25275);
				Plr->BroadcastMessage("Du hast Abfangen erlernt.");
			}else{
				Plr->BroadcastMessage("Du musst mindestens Level 10 sein, um Abfangen zu erlernen.");
				}
			break;

	case 14:     // Warrior-Mortal Strike
			if(Plr->getLevel() >= 40)
			{
				Plr->addSpell(30330);
				Plr->BroadcastMessage("Du hast Tödlicher Stoß erlernt.");
			}else{
				Plr->BroadcastMessage("Du musst mindestens Level 40 sein, um Tödlicher Stoß zu erlernen.");
				}
			break;

        case 20:     // Paladin-Warhorse
			if(Plr->getLevel() >= 40)
			{
                		Plr->addSpell(13819);
            			Plr->BroadcastMessage("Du hast Schlachtross beschw\195\182ren erlernt.");
			}else{ 
				Plr->BroadcastMessage("Du musst mindestens Level 40 sein, um Schlachtross beschw\195\182ren zu erlernen."); 
				}
			break;

	case 21:     // Paladin-Charger
			if(Plr->getLevel() >= 60)
			{
                		Plr->addSpell(34767);
            			Plr->BroadcastMessage("Du hast Streitross beschw\195\182ren erlernt.");
			}else{ 
				Plr->BroadcastMessage("Du musst mindestens Level 60 sein, um Streitross beschw\195\182ren zu erlernen."); 
				}			
			break;

	case 22:     // Paladin-Redemption
			if(Plr->getLevel() >= 10)
			{
                		Plr->addSpell(20773);
            			Plr->BroadcastMessage("Du hast Erl\195\182sung erlernt.");
			}else{ 
				Plr->BroadcastMessage("Du musst mindestens Level 10 sein, um Erl\195\182sung zu erlernen."); 
				}			
			break;
        
        case 30:     // Hunter-Pet Spells
	        	if(Plr->getLevel() >= 10)
	        	{
				Plr->addSpell(1515);
				Plr->addSpell(883);
				Plr->addSpell(5149);
				Plr->addSpell(982);
				Plr->addSpell(6991);
				Plr->BroadcastMessage("Du hast deine J\195\164ger Pet Spells erlernt.");
				Plr->Gossip_Complete();
			}else{
				Plr->BroadcastMessage("Du musst mindestens Level 10 sein.");
				Plr->Gossip_Complete();
				}
            		break;

	case 40:     // Warlock-Pet Spells
	        	if(Plr->getLevel() >= 10)
	        	{
				Plr->addSpell(688);
				Plr->addSpell(697);
				Plr->addSpell(712);
				Plr->addSpell(691);
				Plr->BroadcastMessage("Du hast deine Hexenmeister Pet Spells erlernt.");
				Plr->Gossip_Complete();
			}else{
				Plr->BroadcastMessage("Du musst mindestens Level 10 sein.");
				Plr->Gossip_Complete();
			}
			break;

	case 41:     // Warlock-Felsteed
	        	if(Plr->getLevel() >= 40)
	        	{
				Plr->addSpell(5784);
				Plr->BroadcastMessage("Du hast Teufelsross beschw\195\182ren erlernt.");
				Plr->Gossip_Complete();
			}else{
				Plr->BroadcastMessage("Du musst mindestens Level 40 sein, um Teufelsross beschw\195\182ren zu erlernen.");
				Plr->Gossip_Complete();
			}
			break;

	case 42:     // Warlock-Dreadsteed
	        	if(Plr->getLevel() >= 60)
	        	{
				Plr->addSpell(23161);
				Plr->BroadcastMessage("Du hast Schreckensross beschw\195\182ren erlernt.");
				Plr->Gossip_Complete();
			}else{
				Plr->BroadcastMessage("Du musst mindestens Level 60 sein, um Schreckensross beschw\195\182ren zu erlernen.");
				Plr->Gossip_Complete();
			}
            		break;

	case 50:     // Druid-Growl
	        	if(Plr->getLevel() >= 10)
	        	{
				Plr->addSpell(6795);
				Plr->BroadcastMessage("Du hast Knurren erlernt.");
				Plr->Gossip_Complete();
			}else{
				Plr->BroadcastMessage("Du musst mindestens Level 10 sein, um Knurren zu erlernen.");
				Plr->Gossip_Complete();
			}
            		break;

	case 51:     // Druid-Dire Bear Form
	        	if(Plr->getLevel() >= 30)
	        	{
				Plr->addSpell(9634);
				Plr->BroadcastMessage("Du hast die Terrorb\195\164rengestalt erlernt.");
				Plr->Gossip_Complete();
			}else{
				Plr->BroadcastMessage("Du musst mindestens Level 30 sein, um die Terrorb\195\164rengestalt zu erlernen.");
				Plr->Gossip_Complete();
			}
            		break;

	case 52:     // Druid-Normal Flight Form
	        	if(Plr->getLevel() >= 68)
	        	{
				Plr->addSpell(33943);
				Plr->BroadcastMessage("Du hast die Fluggestalt erlernt.");
				Plr->Gossip_Complete();
			}else{
				Plr->BroadcastMessage("Du musst mindestens Level 68 sein, um die Fluggestalt zu erlernen.");
				Plr->Gossip_Complete();
			}
            		break;

	case 53:     // Druid-Epic Flight Form
	        	if(Plr->getLevel() >= 70)
	        	{
				Plr->addSpell(40120);
				Plr->BroadcastMessage("Du hast die Schnelle Fluggestalt erlernt.");
				Plr->Gossip_Complete();
			}else{
				Plr->BroadcastMessage("Du musst mindestens Level 70 sein, um die Schnelle Fluggestalt zu erlernen.");
				Plr->Gossip_Complete();
			}
	case 54:     // Druid-
	        	if(Plr->getLevel() >= 10)
	        	{
				Plr->addSpell(6795);
				Plr->BroadcastMessage("Du hast die B\195\164rengestalt erlernt");
				Plr->Gossip_Complete();
			}else{
				Plr->BroadcastMessage("Du musst mindesten Level 10 sein, um die B\195\164rengestalt zu erlernen.");
				Plr->Gossip_Complete();
			}
            		break;
	case 55:     // Druid-Maul
	        	if(Plr->getLevel() >= 67)
	        	{
				Plr->addSpell(6795);
				Plr->BroadcastMessage("Du hast Zerfleischen erlernt.");
				Plr->Gossip_Complete();
			}else{
				Plr->BroadcastMessage("Du musst mindestens Level 67 sein, um Zerfleischen zu erlernen.");
				Plr->Gossip_Complete();
			}
            		break;
	case 56:     // Druid-Aquatic Form
	        	if(Plr->getLevel() >= 20)
	        	{
				Plr->addSpell(6795);
				Plr->BroadcastMessage("Du hast die Wassergestalt erlernt.");
				Plr->Gossip_Complete();
			}else{
				Plr->BroadcastMessage("Du musst mindestens Level 67 sein, um die Wassergestalt zu erlernen.");
				Plr->Gossip_Complete();
			}
            		break;
	case 98:     // Reset Talents
			{
                                Plr->Reset_Talents();
				Plr->BroadcastMessage("Du hast deine Talentpunkte zur\195\188ckgesetzt.");
				Plr->Gossip_Complete();
			}
            		break;
	case 99:    //Main Menu
			objmgr.CreateGossipMenuForPlayer(&Menu, pObject->GetGUID(), 1, Plr);
				if (Plr->getClass() == 1) 
 { 
Menu->AddItem(0, "Welche Zauber k\195\182nnen Krieger lernen?", 1);
 } 
				if (Plr->getClass() == 2)
 { 
Menu->AddItem(0, "Welche Zauber k\195\182nnen Paladine lernen?", 2);
 }
				if (Plr->getClass() == 3)
 { 
Menu->AddItem(0, "Welche Zauber k\195\182nnen J\195\164ger lernen?", 3);
 }
				if (Plr->getClass() == 9)
 { 
Menu->AddItem(0, "Welche Zauber k\195\182nnen Hexenmeister lernen?", 4);
 }
				if (Plr->getClass() == 11)
 { 
Menu->AddItem(0, "Welche Zauber k\195\182nnen Druiden lernen?", 5);
 }
				if (Plr->getClass() == 4) 
 { 
Menu->AddItem(0, "Welche Zauber k\195\182nnen Schurken lernen?", 6);
 } 
				if (Plr->getClass() == 5) 
 { 
Menu->AddItem(0, "Welche Zauber k\195\182nnen Priester lernen?", 7);
 } 
				if (Plr->getClass() == 7) 
 { 
Menu->AddItem(0, "Welche Zauber k\195\182nnen Schamanen lernen?", 8);
 } 
				if (Plr->getClass() == 8) 
 { 
Menu->AddItem(0, "Welche Zauber k\195\182nnen Magier lernen?", 9);
 } 
Menu->AddItem(5, "Talentpunkte zur\195\188cksetzen", 98);
Menu->SendTo(Plr);
break;

			
		}
	}

void SetupSkillNPC(ScriptMgr * mgr)
{
	mgr->register_gossip_script(200000, (GossipScript*) new SkillNPC());
}