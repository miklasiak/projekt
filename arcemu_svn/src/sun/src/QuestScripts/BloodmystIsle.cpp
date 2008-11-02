/*
 * WEmu Scripts for WEmu MMORPG Server
 * Copyright (C) 2008 WEmu Team
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "StdAfx.h"
#include "Setup.h"
#include "EAS/EasyFunctions.h"

#define SendQuickMenu(textid) objmgr.CreateGossipMenuForPlayer(&Menu, pObject->GetGUID(), textid, plr); \
    Menu->SendTo(plr);

class TheKesselRun : public QuestScript
{	
public:
  void OnQuestStart(Player * mTarget, QuestLogEntry * qLogEntry)
  {
    if(!mTarget)
		return;
    if(!mTarget->HasSpell(30829))
      mTarget->CastSpell(mTarget, 30829, true);
  }
};



class TheKesselRun1 : public GossipScript
{
public:
    void GossipHello(Object* pObject, Player* plr, bool AutoSend)
    {
		if(!plr)
			return;

        GossipMenu *Menu;
		Creature *highchief = (Creature*)(pObject);
		if (highchief == NULL)
			return;

			objmgr.CreateGossipMenuForPlayer(&Menu, pObject->GetGUID(), 1, plr);
			if(plr->GetQuestLogForEntry(9663))
			Menu->AddItem( 0, "Warn him", 1);
	 
		if(AutoSend)
			Menu->SendTo(plr);
    }
 
	void GossipSelectOption(Object* pObject, Player* plr, uint32 Id, uint32 IntId, const char * EnteredCode)
    {
		if(!plr)
			return;

		Creature *highchief = (Creature*)(pObject);
		if (highchief == NULL)
			return;

		switch (IntId)
		{
			case 0:
				GossipHello(pObject, plr, true);
				break;
 
			case 1:
			{
			QuestLogEntry *en = plr->GetQuestLogForEntry(9663);
			if(en && en->GetMobCount(0) < en->GetQuest()->required_mobcount[0])
			{
				en->SetMobCount(0, en->GetMobCount(0) + 1);
				en->SendUpdateAddKill(0);
				en->UpdatePlayerFields();
				return;
			}break;
			}
		}
	}
 
    void Destroy()
    {
        delete this;
    }
};


class TheKesselRun2 : public GossipScript
{
public:
    void GossipHello(Object* pObject, Player* plr, bool AutoSend)
    {
		if(!plr)
			return;

        GossipMenu *Menu;
		Creature *highchief = (Creature*)(pObject);
		if (highchief == NULL)
			return;

			objmgr.CreateGossipMenuForPlayer(&Menu, pObject->GetGUID(), 1, plr);
			if(plr->GetQuestLogForEntry(9663))
			Menu->AddItem( 0, "Warn him", 1);
	 
		if(AutoSend)
			Menu->SendTo(plr);
    }
 
	void GossipSelectOption(Object* pObject, Player* plr, uint32 Id, uint32 IntId, const char * EnteredCode)
    {
		if(!plr)
			return;

		Creature *highchief = (Creature*)(pObject);
		if (highchief == NULL)
			return;

		switch (IntId)
		{
			case 0:
				GossipHello(pObject, plr, true);
				break;
 
			case 1:
			{
			QuestLogEntry *en = plr->GetQuestLogForEntry(9663);
			if(en && en->GetMobCount(1) < en->GetQuest()->required_mobcount[1])
			{
				en->SetMobCount(1, en->GetMobCount(1) + 1);
				en->SendUpdateAddKill(1);
				en->UpdatePlayerFields();
				return;
			}break;
			}
		}
	}
 
    void Destroy()
    {
        delete this;
    }
};


class TheKesselRun3 : public GossipScript
{
public:
    void GossipHello(Object* pObject, Player* plr, bool AutoSend)
    {
		if(!plr)
			return;

        GossipMenu *Menu;
		Creature *highchief = (Creature*)(pObject);
		if (highchief == NULL)
			return;

			objmgr.CreateGossipMenuForPlayer(&Menu, pObject->GetGUID(), 1, plr);
			if(plr->GetQuestLogForEntry(9663))
			Menu->AddItem( 0, "Warn him", 1);
	 
		if(AutoSend)
			Menu->SendTo(plr);
    }
 
	void GossipSelectOption(Object* pObject, Player* plr, uint32 Id, uint32 IntId, const char * EnteredCode)
    {
		if(!plr)
			return;

		Creature *highchief = (Creature*)(pObject);
		if (highchief == NULL)
			return;

		switch (IntId)
		{
			case 0:
				GossipHello(pObject, plr, true);
				break;
 
			case 1:
			{
			QuestLogEntry *en = plr->GetQuestLogForEntry(9663);
			if(en && en->GetMobCount(2) < en->GetQuest()->required_mobcount[2])
			{
				en->SetMobCount(2, en->GetMobCount(2) + 1);
				en->SendUpdateAddKill(2);
				en->UpdatePlayerFields();
				return;
			}break;
			}
		}
	}
 
    void Destroy()
    {
        delete this;
    }
};

//-----------------------------------------------------------------------------------------------------------------------

int fulborgskilled = 0;


class SavingPrincessStillpine : public GameObjectAIScript
{
public:
	SavingPrincessStillpine(GameObject* goinstance) : GameObjectAIScript(goinstance) {}
	static GameObjectAIScript *Create(GameObject * GO) { return new SavingPrincessStillpine(GO); }

	void OnActivate(Player * pPlayer)
	{
		if(!pPlayer)
			return;

		QuestLogEntry *qle = pPlayer->GetQuestLogForEntry(9667);
		if(qle == NULL)
			return;

		if(qle->GetMobCount(0) < qle->GetQuest()->required_mobcount[0])
		{
			qle->SetMobCount(0, qle->GetMobCount(0)+1);
			qle->SendUpdateAddKill(0);
			qle->UpdatePlayerFields();
		}

		Creature *princess = pPlayer->GetMapMgr()->GetInterface()->GetCreatureNearestCoords(pPlayer->GetPositionX(), pPlayer->GetPositionY(), pPlayer->GetPositionZ(), 17682);
		if(!princess)
			return;

		princess->Despawn(1000, 6*60*1000);
		return;
	}
};

class HighChiefBristlelimb : public CreatureAIScript
{
public:
	ADD_CREATURE_FACTORY_FUNCTION(HighChiefBristlelimb);
	HighChiefBristlelimb(Creature* pCreature) : CreatureAIScript(pCreature) {}

	void OnDied(Unit *mKiller)
	{
		fulborgskilled++;
		if(mKiller->IsPlayer())
		{
			Player* mPlayer = static_cast< Player* >( mKiller );

			if(fulborgskilled > 8&& mPlayer->GetQuestLogForEntry( 9667 ))
			{
				_unit->GetMapMgr()->GetInterface()->SpawnCreature(17702, -2419, -12166, 33, 3.45f, true, false, 0, 0)->Despawn(18000000, 0);
				fulborgskilled = 0;
				_unit->SendChatMessage(CHAT_MSG_MONSTER_YELL, LANG_UNIVERSAL, "Chief, we need your help!");
			}
		}
	}

};

class WebbedCreature : public CreatureAIScript
{
public:
   ADD_CREATURE_FACTORY_FUNCTION(WebbedCreature);
    WebbedCreature(Creature* pCreature) : CreatureAIScript(pCreature) {}

   void OnDied(Unit *mKiller)
   {
      Player * plr = static_cast<Player*>(mKiller);
      QuestLogEntry * qle;
      qle = plr->GetQuestLogForEntry( 9670 );

      if( qle == NULL )
      {
      uint32 ids[] = { 17681, 17887, 17550, 17323, 17338, 17341, 17333, 17340, 17353, 17320, 17339, 17337, 17715, 17322, 17494, 17654, 17342, 17328, 17331, 17325, 17321, 17330, 17522, 17329, 17524, 17327, 17661, 17352, 17334, 17326, 17324, 17673, 17336, 17346, 17589, 17609, 17608, 17345, 17527, 17344, 17347, 17525, 17713, 17523, 17348, 17606, 17604, 17607, 17610, 17358, 17588 }; //Creatures from BloodMyst
      uint32 id = ids[RandomUInt( sizeof( ids ) / sizeof( uint32 ) ) - 1];
      Creature * cre = _unit->GetMapMgr()->GetInterface()->SpawnCreature( id, _unit->GetPositionX() + 2, _unit->GetPositionY() + 2, _unit->GetPositionZ(), _unit->GetOrientation(), true, false, 0, 0);
      if(cre)
       {
         cre->m_noRespawn = true;
         cre->Despawn(60000, 0);
       }
      }
      else
      {
      uint32 ids[] = { 17681, 17321, 17330, 17522, 17673, 17336, 17346, 17589 };
      uint32 id = ids[RandomUInt( sizeof( ids ) / sizeof( uint32 ) ) - 1]; // By my friend from ofic realm
      Creature * cre = _unit->GetMapMgr()->GetInterface()->SpawnCreature( id, _unit->GetPositionX() + 2, _unit->GetPositionY() + 2, _unit->GetPositionZ(), _unit->GetOrientation(), true, false, 0, 0);
      if(cre)
       {
         cre->m_noRespawn = true;
         cre->Despawn(60000, 0);
         if( id == 17681 && qle != NULL && qle->GetMobCount(0) < qle->GetQuest()->required_mobcount[0] )
         {
            qle->SetMobCount( 0,  qle->GetMobCount( 0 ) + 1 );
              qle->SendUpdateAddKill( 0 );
              qle->UpdatePlayerFields();
         }
       }
      }
   }
};

void SetupBloodmystIsle(ScriptMgr * mgr)
{
	QuestScript *KesselRun = (QuestScript*) new TheKesselRun();
	mgr->register_quest_script(9663, KesselRun);

	GossipScript * gossip1 = (GossipScript*) new TheKesselRun1();
	mgr->register_gossip_script(17440, gossip1);

	GossipScript * gossip2 = (GossipScript*) new TheKesselRun2();
	mgr->register_gossip_script(17116, gossip2);

	GossipScript * gossip3 = (GossipScript*) new TheKesselRun3();
	mgr->register_gossip_script(17240, gossip3);


	mgr->register_gameobject_script(181928, &SavingPrincessStillpine::Create);

	mgr->register_creature_script(17320, &HighChiefBristlelimb::Create);
	mgr->register_creature_script(17321, &HighChiefBristlelimb::Create);

	mgr->register_creature_script(17680, &WebbedCreature::Create);
}