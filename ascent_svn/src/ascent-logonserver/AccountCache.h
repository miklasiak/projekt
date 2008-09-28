/*
 * Ascent MMORPG Server
 * Copyright (C) 2005-2008 Ascent Team <http://www.ascentcommunity.com/>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

#ifndef __ACCOUNTCACHE_H
#define __ACCOUNTCACHE_H

#include "Common.h"
#include "../ascent-shared/Database/DatabaseEnv.h"

// returns true if the ip hits the mask, otherwise false
static bool ParseCIDRBan(unsigned int IP, unsigned int Mask, unsigned int MaskBits)
{
	// CIDR bans are a compacted form of IP / Submask
	// So 192.168.1.0/255.255.255.0 would be 192.168.1.0/24
	// IP's in the 192.168l.1.x range would be hit, others not.
	unsigned char * source_ip = (unsigned char*)&IP;
	unsigned char * mask = (unsigned char*)&Mask;
	int full_bytes = MaskBits / 8;
	int leftover_bits = MaskBits % 8;
	//int byte;

	// sanity checks for the data first
	if( MaskBits > 32 )
		return false;

	// this is the table for comparing leftover bits
	static const unsigned char leftover_bits_compare[9] = {
		0x00,			// 00000000
		0x80,			// 10000000
		0xC0,			// 11000000
		0xE0,			// 11100000
		0xF0,			// 11110000
		0xF8,			// 11111000
		0xFC,			// 11111100
		0xFE,			// 11111110
		0xFF,			// 11111111 - This one isn't used
	};

	// if we have any full bytes, compare them with memcpy
	if( full_bytes > 0 )
	{
		if( memcmp( source_ip, mask, full_bytes ) != 0 )
			return false;
	}

	// compare the left over bits
	if( leftover_bits > 0 )
	{
		if( ( source_ip[full_bytes] & leftover_bits_compare[leftover_bits] ) !=
			( mask[full_bytes] & leftover_bits_compare[leftover_bits] ) )
		{
			// one of the bits does not match
			return false;
		}
	}

	// all of the bits match that were testable
	return true;
}

static unsigned int MakeIP(const char * str)
{
	unsigned int bytes[4];
	unsigned int res;
	if( sscanf(str, "%u.%u.%u.%u", &bytes[0], &bytes[1], &bytes[2], &bytes[3]) != 4 )
		return 0;

	res = bytes[0] | (bytes[1] << 8) | (bytes[2] << 16) | (bytes[3] << 24);
	return res;
}

struct Account
{
	uint32 AccountId;
	char * GMFlags;
	uint8 AccountFlags;
	uint32 Banned;
	uint8 SrpHash[20];
	uint8 * SessionKey;
	string * UsernamePtr;
	uint32 Muted;

	Account()
	{
		GMFlags = NULL;
		SessionKey = NULL;
	}

	~Account()
	{
		if(GMFlags)
			delete [] GMFlags;
		if(SessionKey)
			delete [] SessionKey;
	}

	void SetGMFlags(const char * flags)
	{
		if(GMFlags)
			delete [] GMFlags;

		size_t len = strlen(flags);
		if(len == 0 || (len == 1 && flags[0] == '0'))
		{
			// no flags
			GMFlags = NULL;
			return;
		}
		
		GMFlags = new char[len+1];
		memcpy(GMFlags, flags, len);
		GMFlags[len] = 0;
	}

	void SetSessionKey(const uint8 *key)
	{
		if(SessionKey == NULL)
			SessionKey = new uint8[40];
		memcpy(SessionKey, key, 40);
	}

	char Locale[4];
	bool forcedLocale;

};

typedef struct 
{
	unsigned int Mask;
	unsigned char Bytes;
	uint32 Expire;
	string db_ip;
} IPBan;

enum BAN_STATUS
{
	BAN_STATUS_NOT_BANNED = 0,
	BAN_STATUS_TIME_LEFT_ON_BAN = 1,
	BAN_STATUS_PERMANENT_BAN = 2,
};

class IPBanner : public Singleton< IPBanner >
{
public:
	void Reload();

	bool Add(const char * ip, uint32 dur);
	bool Remove(const char * ip);

	BAN_STATUS CalculateBanStatus(in_addr ip_address);

protected:
	Mutex listBusy;
	list<IPBan> banList;
};

class AccountMgr : public Singleton < AccountMgr >
{
public:
	~AccountMgr()
	{

#ifdef WIN32
		for(HM_NAMESPACE::hash_map<string,Account*>::iterator itr = AccountDatabase.begin(); itr != AccountDatabase.end(); ++itr)
#else
		for(map<string,Account*>::iterator itr = AccountDatabase.begin(); itr != AccountDatabase.end(); ++itr)
#endif
		{
			delete itr->second;
		}
	}

	void AddAccount(Field* field);

	Account* GetAccount(string Name)
	{
		setBusy.Acquire();
		Account * pAccount = NULL;
		// this should already be uppercase!
#ifdef WIN32
		HM_NAMESPACE::hash_map<string, Account*>::iterator itr = AccountDatabase.find(Name);
#else
		map<string, Account*>::iterator itr = AccountDatabase.find(Name);
#endif

		if(itr == AccountDatabase.end())	pAccount = NULL;
		else								pAccount = itr->second;

		setBusy.Release();
		return pAccount;
	}

	void UpdateAccount(Account * acct, Field * field);
	void ReloadAccounts(bool silent);
	void ReloadAccountsCallback();

	ASCENT_INLINE size_t GetCount() { return AccountDatabase.size(); }

private:
	Account* __GetAccount(string Name)
	{
		// this should already be uppercase!
#ifdef WIN32
		HM_NAMESPACE::hash_map<string, Account*>::iterator itr = AccountDatabase.find(Name);
#else
		map<string, Account*>::iterator itr = AccountDatabase.find(Name);
#endif

		if(itr == AccountDatabase.end())	return NULL;
		else								return itr->second;
	}

#ifdef WIN32
	HM_NAMESPACE::hash_map<string, Account*> AccountDatabase;
#else
	std::map<string, Account*> AccountDatabase;
#endif

protected:
	Mutex setBusy;
};

typedef struct
{
	string Name;
	string Address;
	uint8 Colour;
	uint8 Icon;
	uint8 TimeZone;
	float Population;
	HM_NAMESPACE::hash_map<uint32, uint8> CharacterMap;
}Realm;

class AuthSocket;
class LogonCommServerSocket;

class InformationCore : public Singleton<InformationCore>
{
	map<uint32, Realm*>		  m_realms;
	set<LogonCommServerSocket*> m_serverSockets;
	Mutex serverSocketLock;
	Mutex realmLock;

	uint32 realmhigh;
	bool usepings;

public:
	ASCENT_INLINE Mutex & getServerSocketLock() { return serverSocketLock; }
	ASCENT_INLINE Mutex & getRealmLock() { return realmLock; }

	InformationCore()
	{ 
		realmhigh = 0;
		usepings  = !Config.MainConfig.GetBoolDefault("LogonServer", "DisablePings", false);
	}

	// Packets
	void		  SendRealms(AuthSocket * Socket);
	
	// Realm management
	uint32 GenerateRealmID()
	{
		return ++realmhigh;
	}

	Realm*		  AddRealm(uint32 realm_id, Realm * rlm);
	Realm*        GetRealm(uint32 realm_id);
	void		  RemoveRealm(uint32 realm_id);

	ASCENT_INLINE void   AddServerSocket(LogonCommServerSocket * sock) { serverSocketLock.Acquire(); m_serverSockets.insert( sock ); serverSocketLock.Release(); }
	ASCENT_INLINE void   RemoveServerSocket(LogonCommServerSocket * sock) { serverSocketLock.Acquire(); m_serverSockets.erase( sock ); serverSocketLock.Release(); }

	void		  TimeoutSockets();
	void CheckServers();
};

#define sIPBanner IPBanner::getSingleton()
#define sAccountMgr AccountMgr::getSingleton()
#define sInfoCore InformationCore::getSingleton()

#endif
