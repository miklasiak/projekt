//Title of Script: Portable Teleporter
//Description of Script: Teleports people to diferent locations.
//Author: Spartansp
//Credits: To Aldaus for original script changed by me though.

    #include "StdAfx.h"
    #include "Setup.h"

    #ifdef WIN32
    #pragma warning(disable:4305)        // warning C4305: 'argument' : truncation from 'double' to 'float'
    #endif

    //Defining Pwarper
    class SCRIPT_DECL Pwarper : public GossipScript
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

    void Pwarper::GossipHello(Object* pObject, Player * Plr, bool AutoSend)
    {
        if(Plr->CombatStatus.IsInCombat())
        {
            Plr->BroadcastMessage("Du befindest dich in einem Kampf!");
        }
        if(!Plr->CombatStatus.IsInCombat())
        {
        
        GossipMenu *Menu;
        objmgr.CreateGossipMenuForPlayer(&Menu, pObject->GetGUID(), 2593, Plr);
        Menu->AddItem(0, "Sturmwind", 50);
        Menu->AddItem(0, "Eisenschmiede", 51);
        Menu->AddItem(0, "Exodar", 52);
        Menu->AddItem(0, "Darnassus", 53);  
        Menu->AddItem(0, "Orgrimar", 54);
        Menu->AddItem(0, "Donnerfels", 55);
        Menu->AddItem(0, "Silbermond", 56);
        Menu->AddItem(0, "Unterstadt", 57);
        Menu->AddItem(0, "Shattrath", 58);
            if(AutoSend)
            Menu->SendTo(Plr);
    }
};




    //Defining Cases
    void Pwarper::GossipSelectOption(Object* pObject, Player* Plr, uint32 Id, uint32 IntId, const char * Code)
    {
        GossipMenu * Menu;
        switch(IntId)
        {
                case 50:
                    {   //Stormwind
                        Plr->SafeTeleport(0, 0, -8831.61, 622.666, 93.7787, 0);
                        Plr->Gossip_Complete();
                    }break;
                    
                case 51:
                    {   //Ironforge
                        Plr->SafeTeleport(0, 0, -4804.45, -1101.14, 498.807, 0);
                        Plr->Gossip_Complete();
                    }break;
                    
                case 52:
                    {   //Exodar
                        Plr->SafeTeleport(530, 0, -3796.24, -11710.9, -105.45, 0);
                        Plr->Gossip_Complete();
                    }break;
                    
                case 53:
                    {   //Darnassus
                        Plr->SafeTeleport(1, 0, 9952.07, 2278.46, 1341.39, 0);
                        Plr->Gossip_Complete();
                    }break;
                    
                case 54:
                    {   //Orgrimmar
                        Plr->SafeTeleport(1, 0, 1499.55, -4406.91, 23.1642, 0);
                        Plr->Gossip_Complete();
                    }break;
                    
                case 55:
                    {   //Thunder Bluff
                        Plr->SafeTeleport(1, 0, -1195.88, -56.5582, 160.034, 0);
                        Plr->Gossip_Complete();
                    }break;
                    
                case 56:
                    {   //Silvermoon City
                        Plr->SafeTeleport(530, 0, 9492.45, -7279.12, 14.3036, 0);
                        Plr->Gossip_Complete();
                    }break;
                    
                case 57:
                    {   //Undercity
                        Plr->SafeTeleport(0, 0, 1615.1, 239.786, -62.0774, 0);
                        Plr->Gossip_Complete();
                    }break;
                    
                case 58:
                    {   //Shattrath
                        Plr->SafeTeleport(530, 0, -1852, 5432, -11, 0);
                        Plr->Gossip_Complete();
                    }break;


        }
    };

    void Pwarper::GossipEnd(Object * pObject, Player* Plr)
{
    GossipScript::GossipEnd(pObject, Plr);
}

    void SetupPwarper(ScriptMgr * mgr)
    {
    GossipScript * gs = (GossipScript*) new Pwarper();
    mgr->register_item_gossip_script(60001,gs);
    }