#include "StdAfx.h"
#include "Setup.h"

extern "C" SCRIPT_DECL void _exp_script_register(ScriptMgr* mgr)
{
SetupWarpNPC(mgr);
}

#ifdef WIN32

BOOL APIENTRY DllMain( HANDLE hModule, DWORD ul_reason_for_call, LPVOID lpReserved )
{
return TRUE;
}

#endif