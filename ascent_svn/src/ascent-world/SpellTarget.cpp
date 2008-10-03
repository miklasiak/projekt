/*
* Ascent MMORPG Server
* Copyright (C) 2005-2007 Ascent Team <http://www.ascentcommunity.com/>
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
*
*/
// Coded by Captnoord for ascent (2007), please give feedback to me if your able to.

#include "StdAfx.h"

/* LEFTOVER RESEARCH, this contains note's comments from Captnoord
// these are left here because of the importance's of the info.
// comments and additional information related to this send to Captnoord

// Type 4:
// 4 is related to Diseases fun to give it a try..
// dono related to "Wandering Plague", "Spirit Steal", "Contagion of Rot", "Retching Plague" and "Copy of Wandering Plague"

// Type 7:
// Point Blank Area of Effect
// think its wrong, related to 2 spells, "Firegut Fear Storm" and "Mind Probe"
// FillAllTargetsInArea(tmpMap,m_targets.m_destX,m_targets.m_destY,m_targets.m_destZ,GetRadius(i));

//fear storm is nice
//Score 5.7	 Vote: [-] [+] by plle, 1.5 years ago
//when you set that ogre head on the top of the rock and all orges see it they /yell: FLEE (and) RUN!!
//and then all ogres get fear storm =D 

//this quest
//Score 6.9	 Vote: [-] [+] by ewendim, 1.1 years ago
//happens while doing this quest http://www.thottbot.com/?qu=3825

// Type 11
// this is related to spellID: 4, as I think is a gm spell

// 11 select id,name, EffectImplicitTargetA1 from spell where EffectImplicitTargetA1 = 11;
// +----+----------------------+------------------------+
// | id | name				 | EffectImplicitTargetA1 |
// +----+----------------------+------------------------+
// |  4 | Word of Recall Other |					 11 |
// +----+----------------------+------------------------+

// type 17:
// spells like 17278:Cannon Fire and 21117:Summon Son of Flame A
// A single target at a xyz location or the target is a possition xyz

// select id,name, EffectImplicitTargetA1 from spell where EffectImplicitTargetB1 = 9;
// +-------+----------------------------+------------------------+
// | id	| name					   | EffectImplicitTargetA1 |
// +-------+----------------------------+------------------------+
// |	 1 | Word of Recall (OLD)	   |					  1 |
// |	 3 | Word of Mass Recall (OLD)  |					 20 |
// |   556 | Astral Recall			  |					  1 |
// |  8690 | Hearthstone				|					  1 |
// | 39937 | There's No Place Like Home |					  1 |
// +-------+----------------------------+------------------------+

// type 10: is not used
// type 12: is not used
// type 13: is not used
// type 14: is not used

// type 19: is target zone I think (test spells)

// type 48: is summon wild unit
// type 49: is summon friend unit
// type 50: something related to the pref 2
// type 51: is targeting objects / egg's / possible to use those while flying


// type 55 related to blink and Netherstep... I think this one sets the xyz where you should end...
// type 56 is related to aura holder... Player 1 give's me a aura and that aura has as target me. I wear then the aura / spell and it targeting me

// type 58 proc triggeret target... 
// Apply Aura: Proc Trigger Spell
// Retching Plague
// 10% chance.

// type 59 related to 2 visual spells
// type 60 1 target related. rest is unknown or not clear

// type 62 targets the best player of [class]
// type 63 targets chess player... something like that
// type 64 something related to wharp storm... and the wharpstorm creature..
// type 65 target enemy's weapon... Item target..... "A" target type, "B" target type is target enemy unit...
// type 66 related to summon some unit...
// type 67 related to summon some unit...
// type 68 is not used
// type 69 is totem stuff level 70 totem stuff
// type 70 is not used
// type 71 is not used
// type 72 target enemy unit... (I think it does not matter if its a friendly unit)
// type 73 is serverside scripted.... Mostly summons
// type 74 Target Random Enemy
// type 75 Target location in front of the caster
// type 76 target a area... of target...
// type 77 target single enemy
// type 78 units in front of caster ( test spell )
// type 79 is not used
// type 80 related to summon some unit
// type 81 > N are not handled because they are test spells 

*/

/// Fill the target map with the targets
/// the targets are specified with numbers and handled accordingly

void Spell::FillTargetMap(uint32 i)
{
	uint32 TargetType = 0;
	TargetType |= GetTargetType(m_spellInfo->EffectImplicitTargetA[i], i);

	//never get info from B if it is 0 :P
	if (m_spellInfo->EffectImplicitTargetB[i] != 0)
		TargetType |= GetTargetType(m_spellInfo->EffectImplicitTargetB[i], i);

	SpellTargetMap* t=&m_spellTargets;

	//always add this guy :P
	if (!(TargetType & (SPELL_TARGET_AOE | SPELL_TARGET_AOE_SELF | SPELL_TARGET_AOE_CURRENT_TARGET | SPELL_TARGET_CONE | SPELL_TARGET_SELF)))
		AddTarget(i, TargetType, m_targets.m_target);

	if (TargetType & SPELL_TARGET_SELF)
		AddTarget(i, TargetType, m_caster);
	if (TargetType & (SPELL_TARGET_AOE | SPELL_TARGET_AOE_SELF)) //targetted aoe
		AddAOETargets(i, TargetType, GetRadius(i), m_spellInfo->MaxTargets);
	if (TargetType & SPELL_TARGET_JUMPING_SPELL) //contagious spells
		AddAOETargets(i, TargetType, 15, 1);
	if (TargetType & SPELL_TARGET_ALL_TOTEMS && u_caster != NULL)
		for (uint32 i=1; i<5; ++i) //totem slots are 1, 2, 3, 4
			AddTarget(i, TargetType, u_caster->m_summonslot[i]);
	if (TargetType & SPELL_TARGET_PET && u_caster != NULL)
		AddTarget(i, TargetType, u_caster->GetSummon());
	if (TargetType & SPELL_TARGET_PET_OWNER && m_targets.m_target->IsPet())
		AddTarget(i, TargetType, static_cast<Pet*>(m_targets.m_target)->GetOwner());
	//targets party, not raid
	if ((TargetType & SPELL_TARGET_PARTY_MEMBERS) && !(TargetType & SPELL_TARGET_RAID_MEMBERS))
	{
		if (!m_caster->IsPlayer() && !m_caster->IsPet() && (!m_caster->IsCreature() || !static_cast<Creature*>(m_caster)->IsTotem()))
			AddAOETargets(i, TargetType, GetRadius(i), m_spellInfo->MaxTargets); //npcs
		else
			AddPartyTargets(i, TargetType, GetRadius(i), m_spellInfo->MaxTargets); //players/pets/totems
	}
	if (TargetType & SPELL_TARGET_RAID_MEMBERS)
	{
		if (!m_caster->IsPlayer() && !m_caster->IsPet() && (!m_caster->IsCreature() || !static_cast<Creature*>(m_caster)->IsTotem()))
			AddAOETargets(i, TargetType, GetRadius(i), m_spellInfo->MaxTargets); //npcs
		else
			AddRaidTargets(i, TargetType, GetRadius(i), m_spellInfo->MaxTargets, (TargetType & SPELL_TARGET_PARTY_MEMBERS)? true: false); //players/pets/totems
	}
	if (TargetType & SPELL_TARGET_CHAINED_OBJECT)
		AddChainTargets(i, TargetType, GetRadius(i), m_spellInfo->MaxTargets);
	//target cone
	if (TargetType & SPELL_TARGET_CONE)
		AddConeTargets(i, TargetType, GetRadius(i), m_spellInfo->MaxTargets);
	if (TargetType & SPELL_TARGET_AOE_CURRENT_TARGET && m_targets.m_target != NULL)
	{
		//this just forces dest as the targets location :P
		m_targets.m_targetMask = TARGET_FLAG_DEST_LOCATION;
		m_targets.m_destX = m_targets.m_target->GetPositionX();
		m_targets.m_destY = m_targets.m_target->GetPositionY();
		m_targets.m_destZ = m_targets.m_target->GetPositionZ();
		m_targets.m_target = NULL;
	}
}

void Spell::AddConeTargets(uint32 i, uint32 TargetType, float r, uint32 maxtargets)
{
	SpellTargetMap* t=&m_spellTargets;

	std::set<Object*>::iterator itr;
	for( itr = m_caster->GetInRangeSetBegin(); itr != m_caster->GetInRangeSetEnd(); itr++ )
	{
		if(!((*itr)->IsUnit()) || !((Unit*)(*itr))->isAlive())
			continue;
		//is Creature in range
		if(m_caster->isInRange((Unit*)(*itr),GetRadius(i)))
		{
			if( m_spellInfo->cone_width ? m_caster->isInArc( (Unit*)(*itr) , m_spellInfo->cone_width ) : m_caster->isInFront((Unit*)(*itr)) ) // !!! is the target within our cone ?
			{
				AddTarget(i, TargetType, (*itr));	
			}
		}
		if (maxtargets != 0 && t->size() >= maxtargets)
			return;
	}
}

void Spell::AddChainTargets(uint32 i, uint32 TargetType, float r, uint32 maxtargets)
{
	if(!m_caster->IsInWorld())
		return;

	if (m_targets.m_target == NULL)
		return;

	SpellTargetMap* t=&m_spellTargets;
	//if selected target is party member, then jumps on party
	Unit* firstTarget = NULL;

	if (m_targets.m_target->IsUnit())
		firstTarget = static_cast<Unit*>(m_targets.m_target);
	else
		firstTarget = u_caster;

	bool RaidOnly = false;
	float range = GetMaxRange(dbcSpellRange.LookupEntry(m_spellInfo->rangeIndex));//this is probably wrong,
	//this is cast distance, not searching distance
	range *= range;

	//is this party only?
	Player* casterFrom =  u_caster->GetPlayerFrom();
	Player* pfirstTargetFrom=firstTarget->GetPlayerFrom();

	if (casterFrom != NULL && pfirstTargetFrom != NULL && casterFrom->GetGroup() == pfirstTargetFrom->GetGroup())
		RaidOnly = true;

	uint32 jumps=m_spellInfo->EffectChainTarget[i];

	//range
	range /= jumps; //hacky, needs better implementation!

	if(m_spellInfo->SpellGroupType && u_caster != NULL)
		SM_FIValue(u_caster->SM_FAdditionalTargets, (int32*)&jumps, m_spellInfo->SpellGroupType);

	AddTarget(i, TargetType, firstTarget);

	if(jumps <= 1 || m_orderedObjects.size() == 0) //1 because we've added the first target, 0 size if spell is resisted
		return;

	std::set<Object*>::iterator itr;
	for( itr = firstTarget->GetInRangeSetBegin(); itr != firstTarget->GetInRangeSetEnd(); itr++ )
	{
		if( !(*itr)->IsUnit() || !((Unit*)(*itr))->isAlive())
			continue;

		if (RaidOnly && !pfirstTargetFrom->InRaid(static_cast<Unit*>(*itr)))
			continue;

		//healing spell, full health target = NONO
		if (IsHealingSpell(m_spellInfo) && static_cast<Unit*>(*itr)->GetHealthPct() == 100)
			continue;


		if(IsInrange(firstTarget->GetPositionX(), firstTarget->GetPositionY(), firstTarget->GetPositionZ(), (*itr), range))
		{
			AddTarget(i, TargetType, (*itr));
			if(t->size() >= jumps)
				return;
		}
	}
}

void Spell::AddPartyTargets(uint32 i, uint32 TargetType, float r, uint32 maxtargets)
{
	Object* u = m_targets.m_target? m_targets.m_target : m_caster;
	Player* p = u->GetPlayerFrom();

	if (p == NULL || u_caster == NULL)
		return;

	AddTarget(i, TargetType, p);

	std::set<Object*>::iterator itr;
	for(itr = u->GetInRangeSetBegin(); itr != u->GetInRangeSetEnd(); itr++)
	{
		if (!(*itr)->IsUnit() || static_cast<Unit*>(*itr)->isAlive())
			continue;

		//only affect players and pets
		if (!(*itr)->IsPlayer() && !(*itr)->IsPet())
			continue;

		if (!p->InParty(static_cast<Unit*>(*itr)))
			continue;

		if (u->CalcDistance(*itr) > r)
			continue;

		AddTarget(i, TargetType, (*itr));
	}
}

void Spell::AddRaidTargets(uint32 i, uint32 TargetType, float r, uint32 maxtargets, bool partylimit)
{
	Object* u = m_targets.m_target? m_targets.m_target : m_caster;
	Player* p = u->GetPlayerFrom();

	if (p == NULL || u_caster == NULL)
		return;

	AddTarget(i, TargetType, p);

	std::set<Object*>::iterator itr;
	for(itr = u->GetInRangeSetBegin(); itr != u->GetInRangeSetEnd(); itr++)
	{
		if (!(*itr)->IsUnit() || static_cast<Unit*>(*itr)->isAlive())
			continue;

		//only affect players and pets
		if (!(*itr)->IsPlayer() && !(*itr)->IsPet())
			continue;

		if (!p->InRaid(static_cast<Unit*>(*itr)))
			continue;

		if (u->CalcDistance(*itr) > r)
			continue;

		AddTarget(i, TargetType, (*itr));
	}
}

void Spell::AddAOETargets(uint32 i, uint32 TargetType, float r, uint32 maxtargets)
{
	SpellTargetMap* t = &m_spellTargets;
	LocationVector source;

	//cant do raid/party stuff here, seperate functions for it
	if (TargetType & (SPELL_TARGET_PARTY_MEMBERS | SPELL_TARGET_RAID_MEMBERS) && !(!m_caster->IsPlayer() && !m_caster->IsPet() && (!m_caster->IsCreature() || !static_cast<Creature*>(m_caster)->IsTotem())))
		return;
	
	if (TargetType & SPELL_TARGET_AOE_SELF)
		source=m_caster->GetPosition();
	else if (TargetType & SPELL_TARGET_AOE_CURRENT_TARGET && m_targets.m_target != NULL)
		source=m_targets.m_target->GetPosition();
	else
	{
		m_targets.m_target = NULL; //visual fix
		m_targets.m_targetMask = TARGET_FLAG_DEST_LOCATION;
		source.x=m_targets.m_destX;
		source.y=m_targets.m_destY;
		source.z=m_targets.m_destZ;
	}

	//caster might be in the aoe LOL
	if (m_caster->CalcDistance(source) <= r)
		AddTarget(i, TargetType, m_caster);

	for (ObjectSet::iterator itr = m_caster->GetInRangeSetBegin(); itr!=m_caster->GetInRangeSetEnd(); ++itr)
	{
		if (maxtargets != 0 && t->size() >= maxtargets)
			break;

		if ((*itr)->CalcDistance(source) <= r)
			AddTarget(i, TargetType, (*itr));
	}
}

bool Spell::AddTarget(uint32 i, uint32 TargetType, Object* obj)
{
	SpellTargetMap* t = &m_spellTargets;

	if (obj == NULL || !obj->IsInWorld())
		return false;
	//GO target, not item
	if ((TargetType & SPELL_TARGET_GAMEOBJECT) && !(TargetType & SPELL_TARGET_ITEM) && !obj->IsGO())
		return false;

	//target go, not able to target go
	if (obj->IsGO() && !(TargetType & SPELL_TARGET_GAMEOBJECT) && !m_triggeredSpell)
		return false;
	//target item, not able to target item
	if (obj->IsItem() && !(TargetType & SPELL_TARGET_ITEM) && !m_triggeredSpell)
		return false;

	if (u_caster != NULL && u_caster->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_ATTACKABLE_9) && ((obj->IsPlayer() || obj->IsPet()) || (m_caster->IsPlayer() || m_caster->IsPet())))
		return false;

	if (TargetType & SPELL_TARGET_SELF && m_caster != obj && !m_triggeredSpell)
		return false;
	if (TargetType & SPELL_TARGET_FRIENDLY && !isFriendly(m_caster, obj) && !m_triggeredSpell)
		return false;
	if (TargetType & SPELL_TARGET_HOSTILE && !isAttackable(m_caster, obj) && !m_triggeredSpell)
		return false;
	if (TargetType & SPELL_TARGET_SPECIFIC_UNIT && (m_spellScript == NULL || !m_spellScript->IsValidTarget(obj)))
		return false;
	if (TargetType & SPELL_TARGET_CLASS_OF_TARGET && m_targets.m_target != NULL && m_targets.m_target->IsPlayer() && obj->IsPlayer() && p_caster->getClass() != static_cast<Player*>(m_targets.m_target)->getClass())
		return false;
	if (TargetType & SPELL_TARGET_PET && !obj->IsPet())
		return false;
	if (TargetType & (SPELL_TARGET_AOE | SPELL_TARGET_AOE_SELF | SPELL_TARGET_AOE_CURRENT_TARGET | SPELL_TARGET_CONE | SPELL_TARGET_PARTY_MEMBERS | SPELL_TARGET_RAID_MEMBERS) && ((obj->IsUnit() && !static_cast<Unit*>(obj)->isAlive()) || (obj->IsCreature() && static_cast<Creature*>(obj)->IsTotem())))
		return false;

	//check if it hit on hostiles :P
	if (TargetType & SPELL_TARGET_HOSTILE && obj->IsUnit())
	{
		uint8 hitresult=DidHit(i, static_cast<Unit*>(obj));
		if(hitresult != SPELL_DID_HIT_SUCCESS)
		{
			uint8 extended = 0;
			if (hitresult == SPELL_DID_HIT_REFLECT && u_caster != NULL)
			{
				//for checks
				Unit* tmp = u_caster;
				u_caster = static_cast<Unit*>(obj);
				extended = DidHit(i, u_caster);
				u_caster = tmp;
			}

			SpellTargetMap::iterator itr = m_spellTargets.find(obj);
			if (itr != m_spellTargets.end())
			{
				itr->second.HasEffect[i]=true;
				itr->second.TargetModType = hitresult;
				itr->second.ExtendedTargetModType = extended;
			}
			else
			{
				SpellTargetEntry s;
				s.HasEffect[i]=true;
				s.TargetModType = hitresult;
				s.ExtendedTargetModType = extended;
				m_spellTargets.insert(std::make_pair<Object*, SpellTargetEntry>(obj, s));
			}
			return false;
		}
	}

	//final checks, require line of sight unless range/radius is 50000 yards
	SpellRange* r=dbcSpellRange.LookupEntry(m_spellInfo->rangeIndex);
	if (r->maxRange < 50000 && GetRadius(i) < 50000 && !obj->IsItem())
	{
		float x=m_caster->GetPositionX(), y=m_caster->GetPositionY(), z=m_caster->GetPositionZ() + 0.5;

		//are we using a different location?
		if (TargetType & SPELL_TARGET_AOE)
		{
			x=m_targets.m_destX;
			y=m_targets.m_destY;
			z=m_targets.m_destZ;
		}
		else if (TargetType & SPELL_TARGET_CHAINED_OBJECT)
		{
			Object* lasttarget = NULL;
			if (m_orderedObjects.size() > 0)
			{
				lasttarget=m_orderedObjects[m_orderedObjects.size() - 1];
				x=lasttarget->GetPositionX();
				y=lasttarget->GetPositionY();
				z=lasttarget->GetPositionZ();
			}
		}

		if (!CollideInterface.CheckLOS(m_caster->GetMapId(), x, y, z + 2, obj->GetPositionX(), obj->GetPositionY(), obj->GetPositionZ() + 2))
			return false;
	}

	//ok, we try and find old entry, if not, put a new one in :)
	SpellTargetMap::iterator itr = m_spellTargets.find(obj);

	if (itr != m_spellTargets.end())
		itr->second.HasEffect[i] = true;
	else
	{
		SpellTargetEntry s;
		s.HasEffect[i]=true;
		m_spellTargets.insert(std::make_pair<Object*, SpellTargetEntry>(obj, s));
		m_orderedObjects.push_back(obj);
	}

	return true;
}

uint32 Spell::GetTargetType(uint32 value, uint32 i)
{
	uint32 type = 0;

	//OK, rewrite start!
	switch (value)
	{
		case 0:
			type |= SPELL_TARGET_ITEM | SPELL_TARGET_GAMEOBJECT;
			if (m_targets.m_targetMask & TARGET_FLAG_DEST_LOCATION)
				type |= SPELL_TARGET_AOE;
				break;
		case 1: type |= SPELL_TARGET_SELF; break;
		case 3: type |= SPELL_TARGET_FRIENDLY; break;
		case 4: type |= SPELL_TARGET_JUMPING_SPELL; break;
		case 5: type |= SPELL_TARGET_PET; break;
		case 6: type |= SPELL_TARGET_HOSTILE; break;
		case 7: type |= SPELL_TARGET_SPECIFIC_UNIT; break;
		case 8: type |= SPELL_TARGET_AOE | SPELL_TARGET_HOSTILE; break;
		case 15: type |= SPELL_TARGET_HOSTILE; break;
		case 16: type |= SPELL_TARGET_AOE | SPELL_TARGET_HOSTILE; break;
		case 17: type |= SPELL_TARGET_AOE; break;
		case 18: type |= SPELL_TARGET_AOE_SELF; break;
		case 20: type |= SPELL_TARGET_PARTY_MEMBERS; break;
		case 21: type |= SPELL_TARGET_FRIENDLY; break;
		case 22: type |= SPELL_TARGET_AOE_SELF; break;
		case 23: type |= SPELL_TARGET_GAMEOBJECT; break;
		case 24: type |= SPELL_TARGET_CONE | SPELL_TARGET_HOSTILE; break;
		//case 25: type |= SPELL_TARGET_HOSTILE; break; this can target anything!
		case 26: type |= SPELL_TARGET_GAMEOBJECT | SPELL_TARGET_ITEM; break;
		case 27: type |= SPELL_TARGET_PET_OWNER; break;
		case 28: type |= SPELL_TARGET_AOE | SPELL_TARGET_HOSTILE; break;
		case 29: type |= SPELL_TARGET_SELF | SPELL_TARGET_PARTY_MEMBERS | SPELL_TARGET_AOE_SELF; break;
		case 30: type |= SPELL_TARGET_FRIENDLY; break;
		case 31: type |= SPELL_TARGET_FRIENDLY | SPELL_TARGET_AOE; break;
		//case 32: type |= SPELL_TARGET_SELF; break;
		case 33: type |= SPELL_TARGET_AOE_SELF | SPELL_TARGET_PARTY_MEMBERS; break;
		case 35: type |= SPELL_TARGET_PARTY_MEMBERS; break;
		case 36: type |= SPELL_TARGET_SPECIFIC_UNIT; break;
		case 37: type |= SPELL_TARGET_AOE_SELF | SPELL_TARGET_PARTY_MEMBERS | SPELL_TARGET_RAID_MEMBERS; break;
		case 39: type |= SPELL_TARGET_SELF; break;
		case 40: type |= SPELL_TARGET_SPECIFIC_UNIT; break;
		case 41: type |= SPELL_TARGET_SELF; break;
		case 42: type |= SPELL_TARGET_SELF; break;
		case 43: type |= SPELL_TARGET_SELF; break;
		case 44: type |= SPELL_TARGET_SELF; break;
		case 45: type |= SPELL_TARGET_CHAINED_OBJECT | SPELL_TARGET_FRIENDLY; break;
		case 46: type |= SPELL_TARGET_SELF; break;
		case 47: type |= SPELL_TARGET_SELF; break;
		case 48: type |= SPELL_TARGET_SELF; break;
		case 49: type |= SPELL_TARGET_SELF; break;
		case 50: type |= SPELL_TARGET_SELF; break;
		case 52: type |= SPELL_TARGET_SELF; break;
		case 53: type |= SPELL_TARGET_AOE_CURRENT_TARGET | SPELL_TARGET_HOSTILE; break;
		case 54: type |= SPELL_TARGET_CONE | SPELL_TARGET_HOSTILE; break;
		case 56: type |= SPELL_TARGET_SELF; break;
		case 57: type |= SPELL_TARGET_FRIENDLY | SPELL_TARGET_PARTY_MEMBERS; break;
		case 61: type |= SPELL_TARGET_AOE_SELF | SPELL_TARGET_RAID_MEMBERS | SPELL_TARGET_CLASS_OF_TARGET | SPELL_TARGET_FRIENDLY; break;
		case 63: type |= SPELL_TARGET_SELF; break;
		case 64: type |= SPELL_TARGET_SELF; break;
		case 65: type |= SPELL_TARGET_SELF; break;
		case 66: type |= SPELL_TARGET_SELF; break;
		case 67: type |= SPELL_TARGET_SELF; break;
		case 69: type |= SPELL_TARGET_SELF; break;
		case 72: type |= SPELL_TARGET_SELF; break;
		case 73: type |= SPELL_TARGET_SELF; break;
		case 76: type |= SPELL_TARGET_AOE | SPELL_TARGET_HOSTILE; break;
		case 77: type |= SPELL_TARGET_HOSTILE; break;
		case 87: type |= SPELL_TARGET_AOE; break;
		case 90: type |= SPELL_TARGET_CRITTER_PET; break;
	}

	//CHAIN SPELLS ALWAYS CHAIN!
	uint32 jumps = m_spellInfo->EffectChainTarget[i];
	if (u_caster != NULL)
		SM_FIValue(u_caster->SM_FAdditionalTargets,(int32*)&jumps,m_spellInfo->SpellGroupType);
	if (jumps != 0)
		type |= SPELL_TARGET_CHAINED_OBJECT;

	return type;
}

void Spell::GenerateTargets(SpellCastTargets* t)
{
	if (u_caster == NULL || u_caster->GetAIInterface() == NULL)
		return;

	for (uint32 i=0; i<3; ++i)
	{

	uint32 TargetType = 0;
	TargetType |= GetTargetType(m_spellInfo->EffectImplicitTargetA[i], i);

	//never get info from B if it is 0 :P
	if (m_spellInfo->EffectImplicitTargetB[i] != 0)
		TargetType |= GetTargetType(m_spellInfo->EffectImplicitTargetB[i], i);

	if (TargetType & (SPELL_TARGET_SELF | SPELL_TARGET_PARTY_MEMBERS | SPELL_TARGET_RAID_MEMBERS))
	{
		t->m_targetMask |= TARGET_FLAG_UNIT;
		t->m_target = u_caster;
	}

	if (TargetType & SPELL_TARGET_HOSTILE && !(TargetType & (SPELL_TARGET_AOE | SPELL_TARGET_AOE_SELF | SPELL_TARGET_AOE_CURRENT_TARGET | SPELL_TARGET_CONE)))
	{
		if (u_caster->GetAIInterface()->GetNextTarget() != NULL)
		{
			t->m_targetMask |= TARGET_FLAG_UNIT;
			t->m_target = u_caster->GetAIInterface()->GetNextTarget();
		}
		else
		{
			Unit* target = u_caster->GetMapMgr()->GetUnit(GetSinglePossibleEnemy(i));
			if (target != NULL)
			{
				t->m_targetMask |= TARGET_FLAG_UNIT;
				t->m_target = target;
			}
		}
	}

	if (TargetType & SPELL_TARGET_FRIENDLY && !(TargetType & (SPELL_TARGET_AOE | SPELL_TARGET_AOE_SELF | SPELL_TARGET_AOE_CURRENT_TARGET | SPELL_TARGET_CONE)))
	{
		Unit* target = u_caster->GetMapMgr()->GetUnit(GetSinglePossibleFriend(i));
		if (target != NULL)
		{
			t->m_targetMask |= TARGET_FLAG_UNIT;
			t->m_target = target;
		}
		else
		{
			t->m_targetMask |= TARGET_FLAG_UNIT;
			t->m_target = u_caster;
		}
	}
	if (TargetType & SPELL_TARGET_AOE) //targetted aoe
	{
		if (u_caster->GetAIInterface()->GetNextTarget() != NULL)
		{
			t->m_targetMask |= TARGET_FLAG_DEST_LOCATION;
			t->m_destX = u_caster->GetAIInterface()->GetNextTarget()->GetPositionX();
			t->m_destY = u_caster->GetAIInterface()->GetNextTarget()->GetPositionY();
			t->m_destZ = u_caster->GetAIInterface()->GetNextTarget()->GetPositionZ();
		}
	}
	if (TargetType & SPELL_TARGET_AOE_SELF)
	{
		t->m_targetMask |= TARGET_FLAG_SOURCE_LOCATION;
		t->m_target = u_caster;
		t->m_srcX = u_caster->GetPositionX();
		t->m_srcY = u_caster->GetPositionY();
		t->m_srcZ = u_caster->GetPositionZ();
	}
	/*if (TargetType & SPELL_TARGET_PET)
	{
		t->m_targetMask |= TARGET_FLAG_UNIT;
		t->m_target = ;
	}
	if (TargetType & SPELL_TARGET_PET_OWNER && u_caster->IsCreature() && static_cast<Creature*>(u_caster)->)
	{
		t->m_targetMask |= TARGET_FLAG_UNIT;
		t->m_target = u_caster;
	}*/
	if (TargetType & SPELL_TARGET_CHAINED_OBJECT)
	{
		if (TargetType & SPELL_TARGET_HOSTILE)
		{
			if (u_caster->GetAIInterface()->GetNextTarget() != NULL)
			{
				t->m_targetMask |= TARGET_FLAG_UNIT;
				t->m_target = u_caster->GetAIInterface()->GetNextTarget();
			}
		}
		else
		{
			t->m_targetMask |= TARGET_FLAG_UNIT;
			t->m_target = u_caster;
		}
	}
	//target cone
	if (TargetType & SPELL_TARGET_AOE_CURRENT_TARGET)
	{
		if (u_caster->GetAIInterface()->GetNextTarget() != NULL)
		{
			t->m_targetMask |= TARGET_FLAG_DEST_LOCATION;
			t->m_destX = u_caster->GetAIInterface()->GetNextTarget()->GetPositionX();
			t->m_destY = u_caster->GetAIInterface()->GetNextTarget()->GetPositionY();
			t->m_destZ = u_caster->GetAIInterface()->GetNextTarget()->GetPositionZ();
		}
	}
	}
}
