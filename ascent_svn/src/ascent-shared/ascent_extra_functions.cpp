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

#include "Common.h"
#include "ascent_extra_functions.h"

int arg_counter = 1;
char ascent_optarg[514];
int ascent_getopt_long_only(int ___argc, char *const *___argv, const char *__shortopts, const struct ascent_option *__longopts, int *__longind)
{
	// burlex todo: handle the shortops, at the moment it only works with longopts.

	if (___argc == 1 || arg_counter == ___argc)			// No arguments (apart from filename)
		return -1;

	const char * opt = ___argv[arg_counter];
//	int return_val = 0;

	// if we're not an option, return an error.
	if (strnicmp(opt, "--", 2) != 0)
		return 1;
	else
		opt += 2;


	// parse argument list
	int i = 0;
	for (; __longopts[i].name != 0; ++i)
	{
		if (!strnicmp(__longopts[i].name, opt, strlen(__longopts[i].name)))
		{
			// woot, found a valid argument =)
			char * par = 0;
			if ((arg_counter + 1) != ___argc)
			{
				// grab the parameter from the next argument (if its not another argument)
				if (strnicmp(___argv[arg_counter+1], "--", 2) != 0)
				{
					arg_counter++;		// Trash this next argument, we won't be needing it.
					par = ___argv[arg_counter];
				}
			}			

			// increment the argument for next time
			arg_counter++;

			// determine action based on type
			if (__longopts[i].has_arg == ascent_required_argument)
			{
				if(!par)
					return 1;

				// parameter missing and its a required parameter option
				if(__longopts[i].flag)
				{
					*__longopts[i].flag = atoi(par);
					return 0;
				}
			}

			// store argument in optarg
			if (par)
				strncpy(ascent_optarg, par, 514);

			if (__longopts[i].flag != 0)
			{
				// this is a variable, we have to set it if this argument is found.
				*__longopts[i].flag = 1;
				return 0;
			}
			else
			{
				if (__longopts[i].val == -1 || par == 0)
					return 1;

				return __longopts[i].val;
			}			
			break;
		}
	}

	// return 1 (invalid argument)
	return 1;
}

void replace(std::string &str, char* find, char* rep, uint32 limit)
{
	uint32 i=0;
	std::string::size_type pos=0;
	while((pos=str.find(find, pos)) != std::string::npos)
	{
		str.erase(pos, strlen(find));
		str.insert(pos, rep);
		pos+=strlen(rep);

		++i;
		if (limit != 0 && i == limit)
			break;
	}
}

volatile long Sync_Add(volatile long* value)
{
#ifdef WIN32
	return InterlockedIncrement(value);
#else
	return __sync_add_and_fetch(value, 1);
#endif
}

volatile long Sync_Sub(volatile long* value)
{
#ifdef WIN32
	return InterlockedDecrement(value);
#else
	return __sync_sub_and_fetch(value, 1);
#endif
}