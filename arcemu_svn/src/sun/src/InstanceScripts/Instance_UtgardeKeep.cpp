/*************************** 
 *      .-.                * 
 *      `-.. ..-. + +      * 
 *      `-''-'' '          * 
 *  OpenSource Scripting   * 
 *          Team           * 
 * http://sunplusplus.info * 
 *                         * 
 *************************** 
 * 
 * Sun++ Scripts for Ascent Based MMORPG Server 
 * Copyright (C) 2008 Sun++ Team <http://www.sunplusplus.info/> 
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

#include <StdAfx.h>
#include <setup.h>
#include <base.h>

//////////////////////////////////////////////////////////////////////////
//////// Dragonflayer Forge Master

#define CN_DRAGONFLAYER_FORGE_MASTER				27389
#define DRAGONFLAYER_FORGE_MASTER_BURNING_BRAND		43757

class DragonflayerForgeMasterAI : public MoonScriptCreatureAI
 {
 	MOONSCRIPT_FACTORY_FUNCTION(DragonflayerForgeMasterAI, MoonScriptCreatureAI);
 	DragonflayerForgeMasterAI(Creature *pCreature) : MoonScriptCreatureAI(pCreature)
 	{
		mBurningBrand = AddSpell( DRAGONFLAYER_FORGE_MASTER_BURNING_BRAND, Target_Current, 8, 0, 40, 0, 30 );
 	}
 };
 
//////////////////////////////////////////////////////////////////////////
//////// Dragonflayer HeartSplitter

#define CN_DRAGONFLAYER_HEARTSPLITTER				24071
#define DRAGONFLAYER_HEARTSPLITTER_PIERCING_JAB		31551
#define DRAGONFLAYER_HEARTSPLITTER_THROW			43665
#define DRAGONFLAYER_HEARTSPLITTER_WING_CLIP		32908

class DragonflayerHeartsplitterAI : public MoonScriptCreatureAI
 {
 	MOONSCRIPT_FACTORY_FUNCTION(DragonflayerHeartSplitterAI, MoonScriptCreatureAI);
 	DragonflayerHeartsplitterAI(Creature *pCreature) : MoonScriptCreatureAI(pCreature)
 	{
		mPiercingJab = AddSpell( DRAGONFLAYER_HEARTSPLITTER_PIERCING_JAB, Target_Current, 8, 0, 40, 0, 30 );
		mThrow = AddSpell( DRAGONFLAYER_HEARTSPLITTER_THROW, Target_Current, 8, 0, 40, 0, 30 );
		mWingClip = AddSpell( DRAGONFLAYER_HEARTSPLITTER_WING_CLIP, Target_Current, 8, 0, 40, 0, 30 );
 	}
 };


//////////////////////////////////////////////////////////////////////////
//////// Dragonflayer Ironhelm

#define CN_DRAGONFLAYER_IRONHELM				23961
#define DRAGONFLAYER_IRONHELM_HEROIC_STRIKE		29426
#define DRAGONFLAYER_IRONHELM_RINGING_SLAP		42780

class DragonflayerIronhelmAI : public MoonScriptCreatureAI
 {
 	MOONSCRIPT_FACTORY_FUNCTION(DragonflayerIronhelmAI, MoonScriptCreatureAI);
 	DragonflayerIronhelmAI(Creature *pCreature) : MoonScriptCreatureAI(pCreature)
 	{
		AddSpell( DRAGONFLAYER_IRONHELM_HEROIC_STRIKE, Target_Current, 8, 0, 40, 0, 30 )
		AddSpell( DRAGONFLAYER_IRONHELM_RINGING_SLAP, Target_Current, 8, 0, 40, 0, 30 )
	}
};


//////////////////////////////////////////////////////////////////////////
//////// Dragonflayer Metalworker

#define CN_DRAGONFLAYER_METALWORKER				24078
#define DRAGONFLAYER_METALWORKER_ENRAGE			8599
#define	DRAGONFLAYER_METALWORKER_SUNDER_ARMOR	15572

class DragonflayerMetalworkerAI : public MoonScriptCreatureAI
 {
 	MOONSCRIPT_FACTORY_FUNCTION(DragonflayerMetalworkerAI, MoonScriptCreatureAI);
 	DragonflayerMetalworkerAI(Creature *pCreature) : MoonScriptCreatureAI(pCreature)
 	{
		AddSpell( DRAGONFLAYER_METALWORKER_SUNDER_ARMOR, Target_Current, 8, 0, 40, 0, 30 )
		if ( _unit->GetHealthPct() > 20 )
			AddSpell( DRAGONFLAYER_METALWORKER_ENRAGE, Target_Self, 8, 0, 40, 0, 30 )
	}
};

//////////////////////////////////////////////////////////////////////////////////////
//////// Dragonflayer Overseer

#define CN_DRAGONFLAYER_OVERSEER					24085
#define DRAGONFLAYER_OVERSEER_BATTLE_SHOUT			38232
#define DRAGONFLAYER_OVERSEER_CHARGE				35570
#define DRAGONFLAYER_OVERSEER_DEMORALIZING_SHOUT	16244

class DragonflayerOverseerAI : public MoonScriptCreatureAI
 {
 	MOONSCRIPT_FACTORY_FUNCTION(DragonflayerOverseerAI, MoonScriptCreatureAI);
 	DragonflayerOverseerAI(Creature *pCreature) : MoonScriptCreatureAI(pCreature)
	{
		AddSpell( DRAGONFLAYER_OVERSEER_BATTLE_SHOUT, Target_Current, 8, 0, 40, 0, 30 )
		mCharge = AddSpell( DRAGONFLAYER_OVERSEER_CHARGE, Target_Current, 8, 0, 40, 0, 30 )
		AddSpell( DRAGONFLAYER_OVERSEER_DEMORALIZING_SHOUT, Target_Current, 8, 0, 40, 0, 30 )
	}
};

//////////////////////////////////////////////////////////////////////////
//////// Dragonflayer Runecaster

#define CN_DRAGONFLAYER_RUNECASTER								23960
#define DRAGONFLAYER_RUNECASTER_BOLTHORNS_RUNE_OF_FLAME			54965			
#define DRAGONFLAYER_RUNECASTER_NJORDS_RUNE_OF_PROTECTION		42740

class DragonflayerRunecasterAI : public MoonScriptCreatureAI
 {
 	MOONSCRIPT_FACTORY_FUNCTION(DragonflayerRunecasterAI, MoonScriptCreatureAI);
 	DragonflayerRunecasterAI(Creature *pCreature) : MoonScriptCreatureAI(pCreature)
	{
		AddSpell( DRAGONFLAYER_RUNECASTER_BOLTHORNS_RUNE_OF_FLAME, Target_Self )
		AddSpell( DRAGONFLAYER_RUNECASTER_NJORDS_RUNE_OF_PROTECTION, Target_Self )
	}
};

//////////////////////////////////////////////////////////////////////////
//////// Dragonflayer Spiritualist

#define CN_DRAGONFLAYER_SPIRITUALIST				28410
#define DRAGONFLAYER_SPIRITUALIST_FLAME_SHOCK		51588
#define DRAGONFLAYER_SPIRITUALIST_HEALING_WAVE		51586
#define DRAGONFLAYER_SPIRITUALIST_LIGHTNING_BOLT	51587

class DragonflayerSpiritualistAI : public MoonScriptCreatureAI
 {
 	MOONSCRIPT_FACTORY_FUNCTION(DragonflayerSpiritualistAI, MoonScriptCreatureAI);
 	DragonflayerSpiritualistAI(Creature *pCreature) : MoonScriptCreatureAI(pCreature)
	{
		AddSpell( DRAGONFLAYER_SPIRITUALIST_FLAME_SHOCK, Target_Current )
		AddSpell( DRAGONFLAYER_SPIRITUALIST_LIGHTNING_BOLT, Target_Current )
		if ( _unit->GetHealthPct() > 60 )
			AddSpell( DRAGONFLAYER_SPIRITUALIST_HEALING_WAVE, Target_Self )
	}
};

//////////////////////////////////////////////////////////////////////////
//////// Dragonflayer Weaponsmith

#define CN_DRAGONFLAYER_WEAPONSMITH					23956
#define DRAGONFLAYER_WEAPONSMITH_BLIND				42972
#define DRAGONFLAYER_WEAPONSMITH_TICKING_BOMB		54955

class DragonflayerWeaponsmithAI : public MoonScriptCreatureAI
 {
 	MOONSCRIPT_FACTORY_FUNCTION(DragonflayerSpiritualistAI, MoonScriptCreatureAI);
 	DragonflayerWeaponSmithAI(Creature *pCreature) : MoonScriptCreatureAI(pCreature)
	{
		AddSpell( DRAGONFLAYER_WEAPONSMITH_BLIND, Target_Current, 8, 0, 40, 0, 30 )
		AddSpell( DRAGONFLAYER_WEAPONSMITH_TICKING_BOMB, Target_Current, 8, 0, 40, 0, 30 )
	}
};

//////////////////////////////////////////////////////////////////////////
//////// Enslaved Proto-Drake

#define CN_ESLAVED_PROTO-DRAKE						24083
#define ESLAVED_PROTO-DRAKE_FLAME_BREATH			50653
#define ESLAVED_PROTO-DRAKE_KNOCK_AWAY				49722
#define ESLAVED_PROTO-DRAKE_REND					43931

class EnslavedProto-DrakeAI : public MoonScriptCreatureAI
 {
 	MOONSCRIPT_FACTORY_FUNCTION(EnslavedProto-DrakeAI, MoonScriptCreatureAI);
 	EnslavedProto-DrakeAI(Creature *pCreature) : MoonScriptCreatureAI(pCreature)
	{
		AddSpell( ESLAVED_PROTO-DRAKE_FLAME_BREATH, Target_Current, 8, 0, 40, 0, 30 )
		AddSpell( ESLAVED_PROTO-DRAKE_KNOCK_AWAY, Target_Current, 8, 0, 40, 0, 30 )
		AddSpell( ESLAVED_PROTO-DRAKE_REND, Target_Current, 8, 0, 40, 0, 30 )
	}
};

//////////////////////////////////////////////////////////////////////////
//////// Frenzied Geist

#define CN_FRENZIED_GEIST				28419
#define FRENZIED_GEIST_FIXATE			40414

class FrenziedGeistAI : public MoonScriptCreatureAI
 {
 	MOONSCRIPT_FACTORY_FUNCTION(FrenziedGeistAI, MoonScriptCreatureAI);
 	FrenziedGeistAI(Creature *pCreature) : MoonScriptCreatureAI(pCreature)
	{
		AddSpell( FRENZIED_GEIST_FIXATE, Target_Current, 8, 0, 40, 0, 30 )
	}
};

//Todo: Finish Mobs and do the following bosses:
//Ingvar the Plunderer Skarvald the Constructor Dalronn the Controller Prince Keleseth
		
void SetupUtgardeKeep(ScriptMgr * mgr)
{
	//////////////////////////////////////////////////////////////////////////////////////////
	///////// Mobs
	mgr->register_creature_script(CN_DRAGONFLAYER_FORGE_MASTER, &DragonflayerForgeMasterAI::Create);
	mgr->register_creature_script(CN_DRAGONFLAYER_HEARTSPLITTER, &DragonflayerHeartSplitterAI::Create);
	mgr->register_creature_script(CN_DRAGONFLAYER_IRONHELM, &DragonflayerIronhelmAI::Create);
	mgr->register_creature_script(CN_DRAGONFLAYER_METALWORKER, &DragonflayerIronhelmAI::Create);
	mgr->register_creature_script(CN_DRAGONFLAYER_OVERSEER, &DragonflayerOverseerAI::Create);
	mgr->register_creature_script(CN_DRAGONFLAYER_RUNECASTER, &DragonflayerRunecasterAI::Create);
	mgr->register_creature_script(CN_DRAGONFLAYER_SPIRITUALIST, &DragonflayerSpiritualistAI::Create);
	mgr->register_creature_script(CN_DRAGONFLAYER_WEAPONSMITH, &DragonflayerWeaponSmithAI::Create);
	mgr->register_creature_script(CN_ESLAVED_PROTO-DRAKE, &EnslavedProto-DrakeAI::Create);
	mgr->register_creature_script(CN_FRENZIED_GEIST, &FrenziedGeistAI::Create);
};
