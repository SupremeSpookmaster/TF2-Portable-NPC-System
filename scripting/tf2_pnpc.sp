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
//		- Port all of the "GetClosestTarget/Ally/Whatever" natives from CF.
//		- Make custom melee hitreg so it doesn't sound like you're hitting a wall every time you hit an NPC with melee.
//			- Instead of a custom attribute, just grab the 263 and 264 attributes from all melee weapons at the moment they attack and apply those to a global array, then set the attributes to 0.0 and restore them after running our custom melee logic.
//		- Add lag compensation.
//		- Fix collision with friendly NPCs (likely related to lag comp).
//		- Add an option to make NPCs automatically enter their air/swim animations if airborne or in the water.
//		- Add customizable sounds for any number of custom triggers.
//			- Should include: sound_damaged, sound_impact, sound_kill, and sound_killed as officially supported sound cues, then have "CFNPC.PlaySound" as a native to play custom cues.
//		- NPC CFGs should function like FF2 boss CFGs, with sections for equipped models, name, etc. One of these sections should be called "functionality", where devs can add and tweak AI modifiers to control how the NPC behaves.
//		//////// THE FOLLOWING DO NOT NEED TO BE DONE PRE-CF BETA, AND SHOULD BE SKIPPED FOR NOW FOR THE SAKE OF TIME:
//		- Make a few basic AI templates. These should be split into categories governing movement and combat.
//			- Chaser (movement): chases the nearest player. Can be customized to specify the target's team as well as whether or not it will predict their movement.
//			- Zoner (movement): runs away from players if they are too close, but will chase them if they are too far. Can be customized to specify the team to flee from/chase, as well as whether it turns away or strafes backwards when fleeing.
//			- Brawler (combat): punches enemies who get too close. Should be customizable to set attack interval, damage, melee range, and melee width.
//			- Gunner (combat): shoots enemies who are within a certain range. Should be customizable in the same way as Brawler, but also include options for spread, clip size, falloff, ramp-up, and reload time.
//			- Barrager (combat): shoots enemies with projectiles. Should be customizable in the same way as gunner, but also include options for explosive projectiles.
//		- NPC behavior should be split into 4 basic categories:
//			- Movement logic.
//			- Combat logic.
//			- "Aspects", AKA passive effects.
//			- "Abilities", AKA special abilities that can only be activated by custom NPC logic.
//			- Movement and combat will typically only be used by extremely basic NPCs, whereas aspects and abilities are used to create more complex NPCs.
//		- Allow server owners to configure several settings:
//			- Max NPCs, max gibs, max model attachments per NPC, whether or not NPCs should have visible health bars, whether or not the NPC's remaining HP should be displayed on the user's HUD when the NPC is damaged.
//		- Some day down the road (not immediately), add the Fake Player Model system. Should actually be fairly easy to implement given all of the control we have over animations; we just copy the user's current sequence, pose parameters, and gestures to the NPC every frame, then when we animate the NPC we stop copying until the animation is done.
//		- Do the following to finish the explosion rewrites:
//			- Make the Loose Cannon work as intended against NPCs, maybe?
//			- Make flare explosion detection actually work.
//		- Add an option to make NPCs use the body_pitch and body_yaw pose parameters to automatically look towards their target destination.
//		- Add natives for basic attacks (should have generic melee, generic projectile, and generic bullets).

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	PNPC_MakeNatives();
	Templates_MakeNatives();
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