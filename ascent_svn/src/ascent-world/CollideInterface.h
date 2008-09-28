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

#ifndef _COLLIDEINTERFACE_H
#define _COLLIDEINTERFACE_H

/* imports */
#define NO_WMO_HEIGHT -100000.0f

//#define COLLISION_DEBUG 1

#ifdef WIN32
#define COLLISION_IMPORT __declspec(dllimport)
#else
#define COLLISION_IMPORT 
#endif

extern VMAP::IVMapManager* CollisionMgr;

class CCollideInterface
{
public:
	void Init();
	void DeInit();

	void ActivateTile(uint32 mapId, uint32 tileX, uint32 tileY);
	void DeactivateTile(uint32 mapId, uint32 tileX, uint32 tileY);

#ifdef COLLISION_DEBUG

	bool CheckLOS(uint32 mapId, float x1, float y1, float z1, float x2, float y2, float z2);
	bool GetFirstPoint(uint32 mapId, float x1, float y1, float z1, float x2, float y2, float z2, float & outx, float & outy, float & outz, float distmod);
	bool IsIndoor(uint32 mapId, float x, float y, float z);
	bool IsOutdoor(uint32 mapId, float x, float y, float z);

	float GetHeight(uint32 mapId, float x, float y, float z);
	bool CheckLOS(uint32 mapId, LocationVector & pos1, LocationVector & pos2);
	bool GetFirstPoint(uint32 mapId, LocationVector & pos1, LocationVector & pos2, LocationVector & outvec, float distmod);
	bool IsIndoor(uint32 mapId, LocationVector & pos);
	bool IsOutdoor(uint32 mapId, LocationVector & pos);
	float GetHeight(uint32 mapId, LocationVector & pos);

#else

	ASCENT_INLINE bool CheckLOS(uint32 mapId, float x1, float y1, float z1, float x2, float y2, float z2)
	{
		return CollisionMgr->isInLineOfSight( mapId, x1, y1, z1, x2, y2, z2 );
	}

	ASCENT_INLINE bool GetFirstPoint(uint32 mapId, float x1, float y1, float z1, float x2, float y2, float z2, float & outx, float & outy, float & outz, float distmod)
	{
		return CollisionMgr->getObjectHitPos( mapId, x1, y1, z1, x2, y2, z2, outx, outy, outz, distmod );
	}
	
	ASCENT_INLINE bool IsIndoor(uint32 mapId, float x, float y, float z)
	{
		return CollisionMgr->isInDoors( mapId, x, y, z );
	}

	ASCENT_INLINE bool IsOutdoor(uint32 mapId, float x, float y, float z)
	{
		return CollisionMgr->isOutDoors( mapId, x, y, z );
	}

	ASCENT_INLINE float GetHeight(uint32 mapId, float x, float y, float z)
	{
		return CollisionMgr->getHeight( mapId, x, y, z );
	}

	ASCENT_INLINE bool CheckLOS(uint32 mapId, LocationVector & pos1, LocationVector & pos2)
	{
		return CollisionMgr->isInLineOfSight( mapId, pos1, pos2 );
	}

	ASCENT_INLINE bool GetFirstPoint(uint32 mapId, LocationVector & pos1, LocationVector & pos2, LocationVector & outvec, float distmod)
	{
		return CollisionMgr->getObjectHitPos( mapId, pos1, pos2, outvec, distmod );
	}

	ASCENT_INLINE bool IsIndoor(uint32 mapId, LocationVector & pos)
	{
		return CollisionMgr->isInDoors( mapId, pos );
	}

	ASCENT_INLINE bool IsOutdoor(uint32 mapId, LocationVector & pos)
	{
		return CollisionMgr->isOutDoors( mapId, pos );
	}

	ASCENT_INLINE float GetHeight(uint32 mapId, LocationVector & pos)
	{
		return CollisionMgr->getHeight( mapId, pos );
	}

#endif

};

extern CCollideInterface CollideInterface;

#endif
