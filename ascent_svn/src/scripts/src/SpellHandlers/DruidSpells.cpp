/****************************************************************************
 *
 * SpellHandler Plugin
 * Copyright (c) 2007 Team Ascent
 *
 * This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0
 * License. To view a copy of this license, visit
 * http://creativecommons.org/licenses/by-nc-sa/3.0/ or send a letter to Creative Commons,
 * 543 Howard Street, 5th Floor, San Francisco, California, 94105, USA.
 *
 * EXCEPT TO THE EXTENT REQUIRED BY APPLICABLE LAW, IN NO EVENT WILL LICENSOR BE LIABLE TO YOU
 * ON ANY LEGAL THEORY FOR ANY SPECIAL, INCIDENTAL, CONSEQUENTIAL, PUNITIVE OR EXEMPLARY DAMAGES
 * ARISING OUT OF THIS LICENSE OR THE USE OF THE WORK, EVEN IF LICENSOR HAS BEEN ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGES.
 *
 */

#include "StdAfx.h"
#include "Setup.h"

class Prowl : public SpellScript
{
public:
	ADD_SPELL_FACTORY_FUNCTION(Prowl);
	Prowl(Spell* pSpell) : SpellScript(pSpell) {}
	SpellCastError CanCast(bool tolerate)
	{
		if (_spell->u_caster == NULL || _spell->u_caster->CombatStatus.IsInCombat())
			return SPELL_FAILED_TARGET_IN_COMBAT;

		if (_spell->p_caster != NULL && _spell->p_caster->m_bgHasFlag)
			return SPELL_FAILED_SPELL_UNAVAILABLE;

		return SPELL_CANCAST_OK;
	}
};

class LifeBloom : public SpellScript
{
public:
	ADD_SPELL_FACTORY_FUNCTION(LifeBloom);
	LifeBloom(Spell* pSpell) : SpellScript(pSpell) {}

	void OnDispel(Aura* pDispelledAura, Spell* pDispellingSpell)
	{
		OnExpire(pDispelledAura); //does same thing
	}

	void OnExpire(Aura* pExpiredAura)
	{
		Unit* u_caster = pExpiredAura->GetUnitCaster();
		Unit* u_target = pExpiredAura->GetTarget();

		if (u_caster == NULL || u_target == NULL)
			return;

		Spell s(u_caster, pExpiredAura->m_spellProto, true, NULL);
		s.SetUnitTarget(pExpiredAura->GetTarget());
		//get bonus :)
		uint32 healamount = pExpiredAura->m_spellProto->EffectBasePoints[1] + 1 + u_caster->GetSpellDmgBonus(u_target, pExpiredAura->m_spellProto, pExpiredAura->m_spellProto->EffectBasePoints[1] + 1, false);
		s.Heal(healamount);
	}
};

class Rake : public SpellScript
{
public:
	ADD_SPELL_FACTORY_FUNCTION(Rake);
	Rake(Spell* pSpell) : SpellScript(pSpell) {}
	void CalculateEffect(uint32 EffectIndex, Unit* target, int32* value)
	{
		//Rake the target for ${$AP/100+$m1} bleed damage and an additional ${$m2*3+$AP*0.06} damage over $d.
		if( _spell->u_caster != NULL ) 
		{
			float ap = (float)_spell->u_caster->GetAP();
			if(EffectIndex == 0)
				*value+=(uint32)ceilf((ap*0.01f));	// / 100
			else if(EffectIndex == 1)
				*value=(int32)ceilf((float(*value * 3) + ceilf((ap*0.06f))) / 3.0f);
		}
	}
};

class Rip : public SpellScript
{
public:
	ADD_SPELL_FACTORY_FUNCTION(Rip);
	Rip(Spell* pSpell) : SpellScript(pSpell) {}
	void CalculateEffect(uint32 EffectIndex, Unit* target, int32* value)
	{
		if( _spell->u_caster != NULL ) 
			*value += (uint32)(_spell->u_caster->GetAP()*0.04f);
	}
};

class Swipe : public SpellScript
{
public:
	ADD_SPELL_FACTORY_FUNCTION(Swipe);
	Swipe(Spell* pSpell) : SpellScript(pSpell) {}
	void CalculateEffect(uint32 EffectIndex, Unit* target, int32* value)
	{
		if( _spell->u_caster != NULL )
			*value += float2int32(_spell->u_caster->GetAP()*0.06f);
	}
};

class TreeOfLife : public SpellScript
{
public:
	ADD_SPELL_FACTORY_FUNCTION(TreeOfLife);
	TreeOfLife(Spell* pSpell) : SpellScript(pSpell) {}
	void OnCast()
	{
		Spell* s=new Spell(_spell->m_caster, dbcSpell.LookupEntry(5420), true, NULL);
		SpellCastTargets t(_spell->m_caster);
		s->prepare(&t);
		Spell* s2=new Spell(_spell->m_caster, dbcSpell.LookupEntry(34123), true, NULL);
		s2->prepare(&t);
	}

	void OnRemove(Aura* pRemovedAura)
	{
		Unit* caster=pRemovedAura->GetUnitCaster();

		if (caster == NULL)
			return;

		//remove 5420 and 34123 where caster guids match :)
		for(uint32 x=0; x<MAX_AURAS+MAX_PASSIVE_AURAS; ++x)
		{
			if (caster->m_auras[x] == NULL || caster->m_auras[x]->m_casterGuid != caster->GetGUID())
				continue;

			if (caster->m_auras[x]->m_spellProto->Id != 5420 && caster->m_auras[x]->m_spellProto->Id != 24123)
				continue;

			caster->m_auras[x]->m_wasremoved = true;
			caster->m_auras[x]->Remove();
		}
	}
};

class TreeOfLifePassive : public SpellScript
{
public:
	ADD_SPELL_FACTORY_FUNCTION(TreeOfLifePassive);
	TreeOfLifePassive(Spell* pSpell) : SpellScript(pSpell) { }
	void CalculateEffect(uint32 EffectIndex, Unit* target, int32* value)
	{
		//effect value is spirit * 0.25f, SAVE VALUE, spirit might change and it might remove a different value
		if (EffectIndex != 0 || _spell->u_caster == NULL)
			return;

		*value = float2int32(_spell->u_caster->GetUInt32Value(UNIT_FIELD_STAT4) * 0.25f);
	}
};

void SetupDruidSpells(ScriptMgr * mgr)
{
	mgr->register_spell_script(5215, &Prowl::Create);
	mgr->register_spell_script(6783, &Prowl::Create);
	mgr->register_spell_script(9913, &Prowl::Create);
	mgr->register_spell_script(33763, &LifeBloom::Create);
	mgr->register_spell_script(1822, &Rake::Create);
	mgr->register_spell_script(1823, &Rake::Create);
	mgr->register_spell_script(1824, &Rake::Create);
	mgr->register_spell_script(9904, &Rake::Create);
	mgr->register_spell_script(27003, &Rake::Create);
	mgr->register_spell_script(1079, &Rip::Create);
	mgr->register_spell_script(9492, &Rip::Create);
	mgr->register_spell_script(9493, &Rip::Create);
	mgr->register_spell_script(9752, &Rip::Create);
	mgr->register_spell_script(9894, &Rip::Create);
	mgr->register_spell_script(9896, &Rip::Create);
	mgr->register_spell_script(27008, &Rip::Create);
	mgr->register_spell_script(33891, &TreeOfLife::Create);
	mgr->register_spell_script(34123, &TreeOfLifePassive::Create);
}