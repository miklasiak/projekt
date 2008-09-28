#include <string>
#ifndef INSTANCE_SCRIPTS_SETUP_H
#define INSTANCE_SCRIPTS_SETUP_H

void SetupWarper(ScriptMgr * mgr);
void SetupMorpher(ScriptMgr * mgr);
void SetupPwarper(ScriptMgr * mgr);
void SetupSkillNPC(ScriptMgr * mgr);
void SetupTournament(ScriptMgr * mgr);
void SetupInstant70(ScriptMgr * mgr);
//void SetupL70etc(ScriptMgr * mgr);
void SetupPortals(ScriptMgr * mgr);
void SetupPvPToken(ScriptMgr * mgr);
//void SetupWeddingNPC(ScriptMgr * mgr)

struct ct_entry {
        int creature;
        int parent;
        int menuid;
        int icon;
        const char * gossip;
        int map;
        float position_x;
        float position_y;
        float position_z;
        int minlevel;
        int maxlevel;
        int team;
        bool hasChildren;
};

struct SP_AI_Spell{
	SpellEntry *info; // spell info
	char targettype; // 0-self , 1-attaking target, ....
	bool instant; // does it is instant or not?
	float perctrigger; // % of the cast of this spell in a total of 100% of the attacks
	int attackstoptimer; // stop the creature from attacking
	int soundid; // sound id in DBC
	std::string speech; // text displaied when spell was casted
	uint32 cooldown;	// spell cooldown
	uint32 casttime;	// "time" left to cast spell
};

enum
{
	TARGET_SELF,
	TARGET_VARIOUS,
	TARGET_ATTACKING,
	TARGET_DESTINATION,
	TARGET_SOURCE,

	//.....add
};

#endif
