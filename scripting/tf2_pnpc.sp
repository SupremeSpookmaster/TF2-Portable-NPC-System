#define PLUGIN_NAME           		  "[TF2] Portable NPC System"

#define PLUGIN_AUTHOR         "Spookmaster"
#define PLUGIN_DESCRIPTION    "Create and dynamically spawn your own custom NPCs!"
#define PLUGIN_VERSION        "0.2.0"
#define PLUGIN_URL            "https://github.com/SupremeSpookmaster/TF2-Portable-NPC-System"

#pragma semicolon 1

public Plugin myinfo =
{
	name = PLUGIN_NAME,
	author = PLUGIN_AUTHOR,
	description = PLUGIN_DESCRIPTION,
	version = PLUGIN_VERSION,
	url = PLUGIN_URL
};

#include <pnpc_stocks>
#include <pnpc>

#include "pnpc/npcs.sp"
#include "pnpc/templates.sp"

//PERSONAL NOTES:
//
//		- Rewrite some of this to use methodmaps instead of enum structs.
//		- Port Chaos Fortress CFNPCs to this, then remove them from Chaos Fortress.
//		- Things I must do:
//				- Implement many, many DHooks and GameData calls.
//				- Remove all ZR-specific logic (this will likely comprise 90% of npcs.sp)
//				- Once we have the plugin in a state where it can at least compile, move the ActivePNPC struct to npcs.sp and merge it with CClotBody.

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	PNPC_MakeNatives();
	return APLRes_Success;
}

public void OnPluginStart()
{
	//HookEvent("teamplay_round_win", RoundEnd);
	//HookEvent("teamplay_round_stalemate", RoundEnd);
	
	RegAdminCmd("pnpc_reload", PNPC_ReloadNPCs, ADMFLAG_KICK, "Portable NPC System: Reloads the list of enabled PNPCs.");
	RegAdminCmd("pnpc_spawn", PNPC_Spawn, ADMFLAG_KICK, "Portable NPC System: Spawns the specified PNPC at your crosshair.");
	RegAdminCmd("pnpc_destroy", PNPC_Destroy, ADMFLAG_KICK, "Portable NPC System: Kills the PNPC you are aiming at.");
	RegAdminCmd("pnpc_destroyall", PNPC_DestroyAll, ADMFLAG_KICK, "Portable NPC System: Kills every currently active PNPC.");
	
	PNPC_MakeForwards();
}

/**
 * Creates all of the PNPCS natives.
 */
/*public void PNPC_MakeNatives()
{
	RegPluginLibrary("tf2_pnpc");
	
	CreateNative("PNPC_IsPNPC", Native_PNPC_IsPNPC);
	CreateNative("PNPC_GetPNPCTeam", Native_PNPC_GetPNPCTeam);
	CreateNative("PNPC_HasAspect", Native_PNPC_HasAspect);
	CreateNative("PNPC_GetArgI", Native_PNPC_GetArgI);
	CreateNative("PNPC_GetArgF", Native_PNPC_GetArgF);
	CreateNative("PNPC_GetArgS", Native_PNPC_GetArgS);
}*/

#define SND_ADMINCOMMAND			"ui/cyoa_ping_in_progress.wav"
#define SND_ADMINCOMMAND_ERROR		"ui/cyoa_ping_in_progress.wav"

#define MAXIMUM_PNPCS				255

public OnMapStart()
{
	Templates_MapStart();
	PNPC_MapStart();
	
	PrecacheSound(SND_ADMINCOMMAND);
	PrecacheSound(SND_ADMINCOMMAND_ERROR);
}

public void OnMapEnd()
{
	PNPC_MapEnd();
	Templates_MapEnd();
}

PNPC_Template Templates[MAXIMUM_PNPCS];

public int PNPC_KillAll()
{
	int NumKilled = 0;
	
	for (int i = 0; i < 2049; i++)
	{
		if (PNPC_IsNPC(i))
		{
			view_as<PNPC>(i).Gib();
			NumKilled++;
		}
	}
	
	return NumKilled;
}

//TODO: Expand parameters to allow specifying a position, angles, owner, and team. Possibly more as well.
public int PNPC_SpawnNPC(char name[255])
{
	int ReturnValue = -1;
	bool Found = false;
	
	for (int i = 0; i < MAXIMUM_PNPCS && !Found; i++)
	{
		if (!Templates[i].b_Exists)
			continue;
		
		char confName[255], realName[255];
		Templates[i].GetConfigName(confName);
		Templates[i].GetName(realName);

		if (StrEqual(name, confName) || StrContains(realName, name) != -1)
		{
			Templates[i].Spawn(NULL_VECTOR, NULL_VECTOR);
			Found = true;
		}
	}
	
	return ReturnValue;
}

/*public void RoundEnd(Event hEvent, const char[] sEvName, bool bDontBroadcast)
{
	PNPC_KillAll();
}*/

public Action PNPC_ReloadNPCs(int client, int args)
{	
	if (IsValidClient(client))
	{
		CPrintToChat(client, "{orange}[Portable NPC System] {default}Reloaded data/pnpc/npcs.cfg.");
		EmitSoundToClient(client, SND_ADMINCOMMAND);
		Templates_LoadNPCs();
	}	
	
	return Plugin_Continue;
}

public Action PNPC_Spawn(int client, int args)
{	
	if (IsValidClient(client))
	{
		if (args < 1)
		{
			CPrintToChat(client, "{orange}[Portable NPC System] {default}Usage: {olive}pnpc_spawn {yellow}<{olive}PNPC's Name or Config Name{yellow}>{default}.");
			return Plugin_Continue;
		}
		
		char target[255];
		GetCmdArg(1, target, sizeof(target));
		
		int SpawnedPNPC = PNPC_SpawnNPC(target);	//TODO: Expand on this command so the user can specify a team and owner, maybe other things too.
		
		if (IsValidEntity(SpawnedPNPC))
		{
			float pos[3];
			Handle trace = getAimTrace(client, Trace_OnlyHitWorld);
			TR_GetEndPosition(pos, trace);
			delete trace;
			
			TeleportEntity(SpawnedPNPC, pos);
			
			CPrintToChat(client, "{orange}[Portable NPC System] {default}Spawned {olive}%s{default}.", "TODO: Put the spawned NPC's name here.");
			EmitSoundToClient(client, SND_ADMINCOMMAND);
		}
		else
		{
			CPrintToChat(client, "{orange}[Portable NPC System] {default}Failed to spawn PNPC ''{red}%s{default}''.", target);
			EmitSoundToClient(client, SND_ADMINCOMMAND_ERROR);
		}
	}	
	
	return Plugin_Continue;
}

public Action PNPC_Destroy(int client, int args)
{	
	if (IsValidClient(client))
	{
		Handle trace = getAimTrace(client, Trace_OnlyHitPNPCs);
	
		int DestroyedPNPC = TR_GetEntityIndex(trace);
		
		delete trace;
		
		if (PNPC_IsNPC(DestroyedPNPC))
		{
			CPrintToChat(client, "{orange}[Portable NPC System] {default}Destroyed {olive}%s{default}.", "TODO: Put the spawned NPC's name here.");
			EmitSoundToClient(client, SND_ADMINCOMMAND);
			
			view_as<PNPC>(DestroyedPNPC).Gib();
		}
		else
		{
			CPrintToChat(client, "{orange}[Portable NPC System] {default}You are not aiming at a valid PNPC.");
			EmitSoundToClient(client, SND_ADMINCOMMAND_ERROR);
		}
	}	
	
	return Plugin_Continue;
}

public Action PNPC_DestroyAll(int client, int args)
{	
	if (IsValidClient(client))
	{
		int NumDestroyed = PNPC_KillAll();

		if (NumDestroyed > 0)
		{
			CPrintToChat(client, "{orange}[Portable NPC System] {default}Destroyed {olive}%i PNPCs{default}.", NumDestroyed);
			EmitSoundToClient(client, SND_ADMINCOMMAND);
		}
		else
		{
			CPrintToChat(client, "{orange}[Portable NPC System] {default}Failed to find any PNPCs to destroy.");
			EmitSoundToClient(client, SND_ADMINCOMMAND_ERROR);
		}
	}	
	
	return Plugin_Continue;
}

public void OnEntityCreated(int entity, const char[] classname)
{
	PNPC_OnEntityCreated(entity, classname);
}

public void OnEntityDestroyed(int entity)
{
	if (entity >= 0 && entity < 2049)
	{
		PNPC_OnEntityDestroyed(entity);
	}
}

public Action CH_PassFilter(int ent1, int ent2, bool &result)
{
	return PNPC_PassFilter(ent1, ent2, result);
}

public bool Trace_OnlyHitPNPCs(entity, contentsMask)
{
	if (entity < 0 || entity > 2048)
		return false;
	
	return PNPC_IsNPC(entity);
}