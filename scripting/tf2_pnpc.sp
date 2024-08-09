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
#include <worldtext>

#include "pnpc/npcs.sp"
#include "pnpc/templates.sp"
#include "pnpc/settings.sp"
#include "pnpc/animator.sp"

//PERSONAL NOTES:
//		- Add lag compensation.
//		- Fix collision with friendly NPCs (likely related to lag comp).
//		- Make the following attributes involving backstabs work against players:
//			- Attribute 154: Disguise as victim on stab
//			- Attribute 341: Jarate backstabber
//			- Attribute 402: Backstab immunity
//			- Attribute 52: Block a single stab attempt (remove the first weapon/wearable we find that has this attribute, restore it after a delay, do not block the stab if no weapons/wearables with this attribute remain on the victim)
//		- Some melee weapons have global sounds for some unholy reason, which makes the frying pan VERY ANNOYING. Fix it.
//		//////// THE FOLLOWING ARE BUGS SPECIFIC TO CHAOS FORTRESS, AND MUST BE FIXED BEFORE THE OPEN BETA:
//		- Doktor Medick's medigun effects do not work on NPCs.
//		- Doktor Medick's Cocainum does not work on NPCs (the initial blast damage works on enemies, everything else is nonfunctional).
//		- CBS does not change his melee when hitting NPCs.
//		- The m_iHealth property is fucking stupid, it uses Prop_Data for entities and Prop_Send for clients. Need to fix this in EVERY plugin used for CF...
//		- Anything involving damage/healing dealt to NPCs will not work. This includes:
//			- All ult charge and special resource mechanics.
//		- Surprisingly, Gadgeteer's drones actually work as intended against NPCs. This HAS to be too good to be true, test it later.
//		- Spookmaster Bones' Soul Discard skulls are dealing INSANE damage for some fucked up reason...
//		- Demopan's Profit Blast does no damage. Probably a line-of-sight issue.
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
//		- Implement NPC kill feed and allow server owners to configure it in settings.cfg.
//		- Some day down the road (not immediately), add the Fake Player Model system. The basic functionality should actually be fairly easy to implement given all of the control we have over animations.
//			- Copy the user's current sequence, pose parameters, and gestures to the NPC every frame, then when we animate the NPC we stop copying until the animation is done.
//			- The actual player should be teleported off of the map, and SetClientViewEntity should be used to make them view everything from the NPC's perspective.
//			- The hard part will be making all of the TFConds and other related things (setting client's move type, GetClientAbsOrigin, etc) work properly. A lot of this can be done with function rerouting, but it will be impossible to make it perfect.
//		- Do the following to finish the explosion rewrites:
//			- Make the Loose Cannon work as intended against NPCs, maybe?
//			- Make flare explosion detection actually work.
//		- Add an option to make NPCs use the body_pitch and body_yaw pose parameters to automatically look towards their target destination.
//		- Add natives for basic attacks:
//				- Generic hitscan: uses a hull trace with customizable width, length, and filter.
//				- Generic projectile: fires a single projectile with customizable model, scale, velocity, homing, and on-collide function.
//				- Generic melee: should just be an extension of generic hitscan that adds a delay before the damage event occurs.
//				- All: Have parameters for both an on-hit function and a filter function to determine what can/cannot be hit, as well as animation and sound parameters.
//		- Add an option to make NPCs automatically enter their air/swim animations if airborne or in the water.
//		- Projectiles phase through NPCs that have no team affiliation. PassFilter does not fix this. Find an alternative solution.
//		- Fix the SpawnNPC method freaking out when it fails to find the specified template.
//		- Once NPCs are capable of attacking: add the "sound_kill" cue and test it.
//		- MAYBE make übercharge effects work on NPCs?
//		- Add a system that replaces a player's viewmodel with an NPC that can be animated.
//			- Melee should be easy, ranged will require muzzle flashes.
//			- Perhaps we should hide the *real* viewmodel, then have our custom VM copy its animation data until we decide to animate it?
//			- Replace CF's viewmodel animation native with one that uses this system.
//		- Add support for customizable NPC kill icons.

public APLRes AskPluginLoad2(Handle myself, bool late, char[] error, int err_max)
{
	PNPC_MakeNatives();
	Templates_MakeNatives();
	Animator_MakeNatives();
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
	RegAdminCmd("pnpc_reloadsettings", PNPC_ReloadSettings, ADMFLAG_KICK, "Portable NPC System: Reloads the settings stored in settings.cfg.");

	HookEvent("player_death", PlayerKilled_Pre, EventHookMode_Pre);
	
	PNPC_MakeForwards();
	Animator_PluginStart();
}

public Action PlayerKilled_Pre(Event hEvent, const char[] sEvName, bool bDontBroadcast)
{
	int victim = GetClientOfUserId(hEvent.GetInt("userid"));
	int inflictor = hEvent.GetInt("inflictor_entindex");
	int attacker = GetClientOfUserId(hEvent.GetInt("attacker"));
	
	Action result = Plugin_Continue;
	
	if (IsValidClient(victim))
	{
		result = PNPC_PlayerKilled_Pre(victim, inflictor, attacker, hEvent);
	}
	
	return result;
}

#define SND_ADMINCOMMAND			"ui/cyoa_ping_in_progress.wav"
#define SND_ADMINCOMMAND_ERROR		"ui/cyoa_ping_in_progress.wav"

public OnMapStart()
{
	Templates_MapStart();
	PNPC_MapStart();
	Settings_Load();
	
	PrecacheSound(SND_ADMINCOMMAND);
	PrecacheSound(SND_ADMINCOMMAND_ERROR);
}

public void OnMapEnd()
{
	PNPC_MapEnd();
	Templates_MapEnd();
}

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

/*public void RoundEnd(Event hEvent, const char[] sEvName, bool bDontBroadcast)
{
	PNPC_KillAll();
}*/

public Action PNPC_ReloadNPCs(int client, int args)
{	
	Templates_LoadNPCs();

	if (IsValidClient(client))
	{
		CPrintToChat(client, "{orange}[Portable NPC System] {default}Reloaded data/pnpc/npcs.cfg.");
		EmitSoundToClient(client, SND_ADMINCOMMAND);
	}	
	
	return Plugin_Continue;
}

public Action PNPC_ReloadSettings(int client, int args)
{	
	Settings_Load();
	if (IsValidClient(client))
	{
		CPrintToChat(client, "{orange}[Portable NPC System] {default}Reloaded data/pnpc/settings.cfg.");
		EmitSoundToClient(client, SND_ADMINCOMMAND);
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

			char name[255];
			view_as<PNPC>(SpawnedPNPC).GetName(name, sizeof(name));
			
			CPrintToChat(client, "{orange}[Portable NPC System] {default}Spawned {olive}%s{default}.", name);
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
			PNPC npc = view_as<PNPC>(DestroyedPNPC);
			char name[255];
			npc.GetName(name, sizeof(name));
			CPrintToChat(client, "{orange}[Portable NPC System] {default}Destroyed {olive}%s{default}.", name);
			EmitSoundToClient(client, SND_ADMINCOMMAND);
			
			npc.Gib();
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