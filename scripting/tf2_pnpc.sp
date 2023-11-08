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

#include <pnpc>
#include <sourcemod>
#include <sdktools>
#include <sdkhooks>
#include <entity>
#include <morecolors>
#include <tf2_stocks>
#include <cfgmap>
#include <tf_econ_data>
#include <tf2utils>
#include <dhooks>
#include <collisionhook>
#include <cbasenpc>

#include "pnpc/npcs.sp"

//PERSONAL NOTES:
//
//		- This is going to be a nightmare, but very much worth it in the end.
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
	HookEvent("teamplay_round_win", RoundEnd);
	HookEvent("teamplay_round_stalemate", RoundEnd);
	
	RegAdminCmd("pnpc_reload", PNPC_ReloadNPCs, ADMFLAG_KICK, "Portable NPC System: Reloads the list of enabled PNPCs.");
	RegAdminCmd("pnpc_spawn", PNPC_Spawn, ADMFLAG_KICK, "Portable NPC System: Spawns the specified PNPC at your crosshair.");
	RegAdminCmd("pnpc_destroy", PNPC_Destroy, ADMFLAG_KICK, "Portable NPC System: Kills the PNPC you are aiming at.");
	RegAdminCmd("pnpc_destroyall", PNPC_DestroyAll, ADMFLAG_KICK, "Portable NPC System: Kills every currently active PNPC.");
	
	PNPC_MakeForwards();
}

/**
 * Creates all of the PNPCS natives.
 */
public void PNPC_MakeNatives()
{
	RegPluginLibrary("tf2_pnpc");
	
	CreateNative("PNPC_IsPNPC", Native_PNPC_IsPNPC);
	CreateNative("PNPC_GetPNPCTeam", Native_PNPC_GetPNPCTeam);
	CreateNative("PNPC_HasAspect", Native_PNPC_HasAspect);
	CreateNative("PNPC_GetArgI", Native_PNPC_GetArgI);
	CreateNative("PNPC_GetArgF", Native_PNPC_GetArgF);
	CreateNative("PNPC_GetArgS", Native_PNPC_GetArgS);
}

/**
 * Creates all of the PNPCS forwards.
 */
public void PNPC_MakeForwards()
{
	
}

#define SND_ADMINCOMMAND			"ui/cyoa_ping_in_progress.wav"
#define SND_ADMINCOMMAND_ERROR		"ui/cyoa_ping_in_progress.wav"

#define MAXIMUM_PNPCS				255

public const char s_ModelFileExtensions[][] =
{
	".dx80.vtx",
	".dx90.vtx",
	".mdl",
	".phy",
	".sw.vtx",
	".vvd"
};

public OnMapStart()
{
	PNPC_LoadNPCs();
	
	PrecacheSound(SND_ADMINCOMMAND);
	PrecacheSound(SND_ADMINCOMMAND_ERROR);
}

PNPC PNPCs[MAXIMUM_PNPCS];
ActivePNPC ActivePNPCs[2049];

int i_NumTemplates = 0;

bool b_IsPNPC[2049] = { false, ... };

enum struct PNPC
{
	char Name[255];
	char Model[255];
	char AI[255];
	char Config[255];
	char ConfigName[255];
	int MaxHP;
	float Speed;
	bool Exists;
	
	void Create(char newName[255], char newModel[255], char newAI[255], char newConfig[255], int newMaxHP, float newSpeed)
	{
		strcopy(this.Name, 255, newName);
		strcopy(this.Model, 255, newModel);
		strcopy(this.AI, 255, newAI);
		strcopy(this.ConfigName, 255, newConfig);
		Format(this.Config, 255, "configs/pnpcs/%s.cfg", newConfig);
		this.MaxHP = newMaxHP;
		this.Speed = newSpeed;
		
		this.Exists = true;
		i_NumTemplates++;
	}
	
	int Spawn()
	{
		int ReturnValue = -1; //Something something, CreateEntityByName("base_boss");
		
		//TODO: Spawn a new NPC using this template's information, then return its entity index if successful, or -1 if it fails.
		
		if (IsValidEntity(ReturnValue))
		{
			ActivePNPCs[ReturnValue].Create(ReturnValue, this.Name, this.Model, this.AI, this.Config, this.MaxHP, this.Speed);
		}
		
		return ReturnValue;
	}
	
	void Delete()
	{
		this.Exists = false;
		i_NumTemplates--;
	}
}

enum struct ActivePNPC
{
	int EntityIndex;
	
	char Name[255];
	char Model[255];
	char AI[255];
	char Config[255];
	
	int MaxHP;
	
	float Speed;
	
	void Create(int newIndex, char newName[255], char newModel[255], char newAI[255], char newConfig[255], int newMaxHP, float newSpeed)
	{
		strcopy(this.Name, 255, newName);
		strcopy(this.Model, 255, newModel);
		strcopy(this.AI, 255, newAI);
		strcopy(this.Config, 255, newConfig);
		this.MaxHP = newMaxHP;
		this.Speed = newSpeed;
		this.EntityIndex = newIndex;
	}
	
	void Kill()
	{
		this.Delete();
	}
	
	void Delete()
	{
		this.EntityIndex = -1;
	}
}

public void PNPC_LoadNPCs()
{
	PNPC_UnloadNPCs();
	
	ConfigMap ListOfNPCs = new ConfigMap("data/pnpc/npcs.cfg");
	if (ListOfNPCs == null)
	{
		LogError("data/pnpc/npcs.cfg does not exist!");
		return;
	}
	
	int i = 1;
	char CurrentCFG[255];
	ListOfNPCs.Get("npcs.1", CurrentCFG, 255);
	while (!StrEqual(CurrentCFG, ""))
	{
		char CFGPath[255];
		Format(CFGPath, sizeof(CFGPath), "configs/pnpcs/%s.cfg", CurrentCFG);
		ConfigMap NPCMap = new ConfigMap(CFGPath);
		
		if (NPCMap != null)
		{
			PNPC_LoadNPCData(NPCMap, CurrentCFG);
			PNPC_ManageNPCFiles(NPCMap);
			
			DeleteCfg(NPCMap);
		}
		else
		{
			LogError("data/pnpc/npcs.cfg specifies a PNPC with the config path ''%s'', but no such config exists.", CFGPath);
		}
		
		i++;
		char CurrentSlot[16];
		Format(CurrentSlot, sizeof(CurrentSlot), "npcs.%i", i);
		ListOfNPCs.Get(CurrentSlot, CurrentCFG, 255);
	}
	
	
	DeleteCfg(ListOfNPCs);
}

public void PNPC_UnloadNPCs()
{
	for (int i = 0; i < MAXIMUM_PNPCS; i++)
	{
		PNPCs[i].Delete();
	}
}

public void PNPC_LoadNPCData(ConfigMap NPCMap, char CFGName[255])
{
	char Name[255], Model[255], AI[255];
	NPCMap.Get("npc.name", Name, sizeof(Name));
	NPCMap.Get("npc.model", Model, sizeof(Model));
	NPCMap.Get("npc.ai", AI, sizeof(AI));
			
	int MaxHP = GetIntFromConfigMap(NPCMap, "npc.health", 0);
	float Speed = GetFloatFromConfigMap(NPCMap, "npc.speed", 0.0);
			
	PNPCs[i_NumTemplates].Create(Name, Model, AI, CFGName, MaxHP, Speed);
}

public void PNPC_ManageNPCFiles(ConfigMap NPCMap)
{
	ConfigMap section = NPCMap.GetSection("character.model_download");
 	if (section != null)
 	{
 		PNPC_DownloadNPCModels(section);
 	}
 	
 	section = NPCMap.GetSection("npc.downloads");
 	if (section != null)
 	{
 		PNPC_DownloadFiles(section);
 	}
 	
 	section = NPCMap.GetSection("npc.precache");
 	if (section != null)
 	{
 		PNPC_PrecacheFiles(section);
 	}
}

public void PNPC_DownloadNPCModels(ConfigMap subsection)
{
	char value[255];
 	
 	for (int i = 1; i <= subsection.Size; i++)
 	{
 		subsection.GetIntKey(i, value, sizeof(value));
 			
 		char fileCheck[255], actualFile[255];
				
		for (int j = 0; j < sizeof(s_ModelFileExtensions); j++)
		{
			Format(fileCheck, sizeof(fileCheck), "models/%s%s", value, s_ModelFileExtensions[j]);
			Format(actualFile, sizeof(actualFile), "%s%s", value, s_ModelFileExtensions[j]);
			if (CheckFile(fileCheck))
			{
				if (StrEqual(s_ModelFileExtensions[j], ".mdl"))
				{
					#if defined DEBUG_NPC_CREATION
					int check = PrecacheModel(fileCheck);
					
					if (check != 0)
					{
						PrintToServer("Successfully precached file ''%s''.", fileCheck);
					}
					else
					{
						PrintToServer("Failed to precache file ''%s''.", fileCheck);
					}
					#else
					PrecacheModel(fileCheck);
					#endif
				}

				AddFileToDownloadsTable(fileCheck);
						
				#if defined DEBUG_NPC_CREATION
				PrintToServer("Successfully added model file ''%s'' to the downloads table.", fileCheck);
				#endif
			}
			else
			{
				#if defined DEBUG_NPC_CREATION
				PrintToServer("ERROR: Failed to find model file ''%s''.", fileCheck);
				#endif
			}
		}
	}
}

 public void PNPC_DownloadFiles(ConfigMap subsection)
 {
 	char value[255];
 	
 	for (int i = 1; i <= subsection.Size; i++)
 	{
 		subsection.GetIntKey(i, value, sizeof(value));
 			
 		char actualFile[255];
 		
 		if (CheckFile(value))
		{
			AddFileToDownloadsTable(value);
			
			if (StrContains(value, "sound") == 0)
			{
				for (int j = 6; j < sizeof(value); j++)	//Write the path to the sound without the "sound/" to a new string so we can precache it.
				{
					actualFile[j - 6] = value[j];
				}

				#if defined DEBUG_NPC_CREATION
				bool succeeded = PrecacheSound(actualFile);
				
				if (succeeded)
				{
					PrintToServer("Successfully precached file ''%s''.", actualFile);
				}
				else
				{
					PrintToServer("Failed to precache file ''%s''.", actualFile);
				}
				#else
				PrecacheSound(actualFile);
				#endif
			}
			
			#if defined DEBUG_NPC_CREATION
			PrintToServer("Successfully added file ''%s'' to the downloads table.", value);
			#endif
		}
		else
		{
			#if defined DEBUG_NPC_CREATION
			PrintToServer("ERROR: Failed to find file ''%s''.", value);
			#endif
		}
	}
 }

 public void PNPC_PrecacheFiles(ConfigMap subsection)
 {
 	char value[255];
 	
 	for (int i = 1; i <= subsection.Size; i++)
 	{
 		subsection.GetIntKey(i, value, sizeof(value));
 		
 		char file[255];
				
		bool exists = false;
				
		Format(file, sizeof(file), "models/%s", value);
				
				
		if (CheckFile(file))
		{
			exists = true;
					
			#if defined DEBUG_NPC_CREATION
			int check = PrecacheModel(file);
			if (check != 0)
			{
				PrintToServer("Successfully precached file ''%s''.", file);
			}
			else
			{
				PrintToServer("Failed to precache file ''%s''.", file);
			}
			#else
			PrecacheModel(file);
			#endif
		}
		else
		{
			Format(file, sizeof(file), "sound/%s", value);
					
			if (CheckFile(file))
			{
				exists = true;
					
				#if defined DEBUG_NPC_CREATION
				bool check = PrecacheSound(value);
				if (check)
				{
					PrintToServer("Successfully precached file ''%s''.", file);
				}
				else
				{
					PrintToServer("Failed to precache file ''%s''.", file);
				}
				#else
				PrecacheSound(value);
				#endif
			}
		}
				
		if (!exists)
		{
			#if defined DEBUG_NPC_CREATION
			PrintToServer("Failed to find file ''%s''.", file);
			#endif
		}
	}
}

public int PNPC_KillAll()
{
	int NumKilled = 0;
	
	for (int i = 0; i < 2049; i++)
	{
		if (IsValidEntity(ActivePNPCs[i].EntityIndex))
		{
			ActivePNPCs[i].Kill();
			NumKilled++;
		}
	}
	
	return NumKilled;
}

public int PNPC_SpawnNPC(char name[255])
{
	int ReturnValue = -1;
	bool Found = false;
	
	for (int i = 0; i < MAXIMUM_PNPCS && !Found; i++)
	{
		if (PNPCs[i].Exists && StrEqual(name, PNPCs[i].ConfigName) || StrContains(PNPCs[i].Name, name) != -1)
		{
			ReturnValue = PNPCs[i].Spawn();
			Found = true;
		}
	}
	
	return ReturnValue;
}

public void RoundEnd(Event hEvent, const char[] sEvName, bool bDontBroadcast)
{
	PNPC_KillAll();
}

public Action PNPC_ReloadNPCs(int client, int args)
{	
	if (IsValidClient(client))
	{
		CPrintToChat(client, "{orange}[Portable NPC System] {default}Reloaded data/pnpc/npcs.cfg.");
		EmitSoundToClient(client, SND_ADMINCOMMAND);
		PNPC_LoadNPCs();
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
		
		int SpawnedPNPC = PNPC_SpawnNPC(target);
		
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
		
		if (IsValidEntity(DestroyedPNPC))
		{
			CPrintToChat(client, "{orange}[Portable NPC System] {default}Destroyed {olive}%s{default}.", "TODO: Put the spawned NPC's name here.");
			EmitSoundToClient(client, SND_ADMINCOMMAND);
			
			ActivePNPCs[DestroyedPNPC].Kill();
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

public void OnEntityDestroyed(int entity)
{
	if (entity >= 0 && entity < 2049)
	{
		ActivePNPCs[entity].Delete();
		b_IsPNPC[entity] = false;
	}
}

//Stocks and such, move these to a file like pnpc_stocks or something before publishing:

/**
 * Checks if a client is valid.
 *
 * @param client			The client to check.
 *
 * @return					True if the client is valid, false otherwise.
 */
stock bool IsValidClient(int client)
{
	if(client <= 0 || client > MaxClients)
	{
		return false;
	}
	
	if(!IsClientInGame(client))
	{
		return false;
	}

	return true;
}

stock Handle getAimTrace(int client, TraceEntityFilter filter)
{
	float eyePos[3];
	float eyeAng[3];
	GetClientEyePosition(client, eyePos);
	GetClientEyeAngles(client, eyeAng);
	
	Handle trace;
	
	trace = TR_TraceRayFilterEx(eyePos, eyeAng, MASK_SHOT, RayType_Infinite, filter);
	
	return trace;
}

public bool Trace_OnlyHitWorld(entity, contentsMask)
{
	return entity == 0;
}

public bool Trace_OnlyHitPNPCs(entity, contentsMask)
{
	if (entity < 0 || entity > 2048)
		return false;
	
	return b_IsPNPC[entity];
}

stock int GetIntFromConfigMap(ConfigMap map, char[] path, int defaultValue)
{
	char value[255];
	map.Get(path, value, sizeof(value));
	
	if (StrEqual(value, ""))
	{
		return defaultValue;
	}
	
	return StringToInt(value);
}

stock float GetFloatFromConfigMap(ConfigMap map, char[] path, float defaultValue)
{
	char value[255];
	map.Get(path, value, sizeof(value));
	
	if (StrEqual(value, ""))
	{
		return defaultValue;
	}
	
	return StringToFloat(value);
}

stock bool GetBoolFromConfigMap(ConfigMap map, char[] path, bool defaultValue)
{
	char value[255];
	map.Get(path, value, sizeof(value));
	
	if (StrEqual(value, ""))
	{
		return defaultValue;
	}
	
	return (StringToInt(value) != 0);
}

/**
 * Checks if a file exists.
 *
 * @param path			The file to check.
 *
 * @return					True if it exists, false otherwise.
 */
stock bool CheckFile(char path[255])
{
	bool exists = false;
	
	if (FileExists(path))
	{
		exists = true;
	}
	else
	{
		if (FileExists(path, true))
		{
			exists = true;
		}
	}
	
	return exists;
}

public Native_PNPC_IsPNPC(Handle plugin, int numParams)
{
	int entity = GetNativeCell(1);
	
	if (IsValidEntity(entity))
	{
		return ActivePNPCs[entity].EntityIndex == entity;
	}
	
	return false;
}

public Native_PNPC_GetPNPCTeam(Handle plugin, int numParams)
{
	int entity = GetNativeCell(1);
	
	if (PNPC_IsPNPC(entity))
	{
		int team = GetEntProp(entity, Prop_Send, "m_iTeamNum");
		
		switch(team)
		{
			case 2:
				return TFTeam_Red;
			case 3:
				return TFTeam_Blue;
		}
	}
	
	return TFTeam_Unassigned;
}

public Native_PNPC_HasAspect(Handle plugin, int numParams)
{
	int entity = GetNativeCell(1);
	
	if (!PNPC_IsPNPC(entity))
		return false;
		
	char conf[255], targetPlugin[255], targetAspect[255], pluginName[255], abName[255];
	conf = ActivePNPCs[entity].Config;
	
	ConfigMap map = new ConfigMap(conf);
	if (map == null)
		return false;
		
	GetNativeString(2, targetPlugin, sizeof(targetPlugin));
	GetNativeString(3, targetAspect, sizeof(targetAspect));
		
	ConfigMap aspects = map.GetSection("npc.aspects");
	if (aspects == null)
	{
		DeleteCfg(map);
		return false;
	}
		
	bool ReturnValue = false;
		
	int i = 1;
	char secName[255];
	Format(secName, sizeof(secName), "aspect_%i", i);
		
	ConfigMap subsection = aspects.GetSection(secName);
	while (subsection != null)
	{
		subsection.Get("aspect_name", abName, sizeof(abName));
		subsection.Get("plugin_name", pluginName, sizeof(pluginName));
		
		if (StrEqual(targetPlugin, pluginName) && StrEqual(targetAspect, abName))
		{
			ReturnValue = true;
			break;
		}
		
		i++;
		Format(secName, sizeof(secName), "aspect_%i", i);
		subsection = aspects.GetSection(secName);
	}
	
	DeleteCfg(map);
	
	return ReturnValue;
}

public Native_PNPC_GetArgI(Handle plugin, int numParams)
{
	int entity = GetNativeCell(1);
	
	if (!PNPC_IsPNPC(entity))
		return -1;
		
	char conf[255], targetPlugin[255], targetAspect[255], argName[255], pluginName[255], abName[255];
	conf = ActivePNPCs[entity].Config;
	
	ConfigMap map = new ConfigMap(conf);
	if (map == null)
		return -1;
		
	GetNativeString(2, targetPlugin, sizeof(targetPlugin));
	GetNativeString(3, targetAspect, sizeof(targetAspect));
	GetNativeString(4, argName, sizeof(argName));
		
	ConfigMap abilities = map.GetSection("npc.aspects");
	if (abilities == null)
	{
		DeleteCfg(map);
		return -1;
	}
		
	int ReturnValue = -1;
		
	int i = 1;
	char secName[255];
	Format(secName, sizeof(secName), "aspect_%i", i);
		
	ConfigMap subsection = abilities.GetSection(secName);
	while (subsection != null)
	{
		subsection.Get("aspect_name", abName, sizeof(abName));
		subsection.Get("plugin_name", pluginName, sizeof(pluginName));
		
		if (StrEqual(targetPlugin, pluginName) && StrEqual(targetAspect, abName))
		{
			ReturnValue = GetIntFromConfigMap(subsection, argName, -1);
			break;
		}
		
		i++;
		Format(secName, sizeof(secName), "aspect_%i", i);
		subsection = abilities.GetSection(secName);
	}
	
	DeleteCfg(map);
	
	return ReturnValue;
}

public any Native_PNPC_GetArgF(Handle plugin, int numParams)
{
	int entity = GetNativeCell(1);
	
	if (!PNPC_IsPNPC(entity))
		return -1.0;
		
	char conf[255], targetPlugin[255], targetAspect[255], argName[255], pluginName[255], abName[255];
	conf = ActivePNPCs[entity].Config;
	
	ConfigMap map = new ConfigMap(conf);
	if (map == null)
		return -1.0;
		
	GetNativeString(2, targetPlugin, sizeof(targetPlugin));
	GetNativeString(3, targetAspect, sizeof(targetAspect));
	GetNativeString(4, argName, sizeof(argName));
		
	ConfigMap abilities = map.GetSection("npc.aspects");
	if (abilities == null)
	{
		DeleteCfg(map);
		return -1.0;
	}
		
	float ReturnValue = -1.0;
		
	int i = 1;
	char secName[255];
	Format(secName, sizeof(secName), "aspect_%i", i);
		
	ConfigMap subsection = abilities.GetSection(secName);
	while (subsection != null)
	{
		subsection.Get("aspect_name", abName, sizeof(abName));
		subsection.Get("plugin_name", pluginName, sizeof(pluginName));
		
		if (StrEqual(targetPlugin, pluginName) && StrEqual(targetAspect, abName))
		{
			ReturnValue = GetFloatFromConfigMap(subsection, argName, -1.0);
			break;
		}
		
		i++;
		Format(secName, sizeof(secName), "aspect_%i", i);
		subsection = abilities.GetSection(secName);
	}
	
	DeleteCfg(map);
	
	return ReturnValue;
}

public Native_PNPC_GetArgS(Handle plugin, int numParams)
{
	int entity = GetNativeCell(1);
	int size = GetNativeCell(6);
	
	if (!PNPC_IsPNPC(entity))
	{
		SetNativeString(5, "", size, false);
		return;
	}
		
	char conf[255], targetPlugin[255], targetAspect[255], argName[255], pluginName[255], abName[255];
	conf = ActivePNPCs[entity].Config;
	
	ConfigMap map = new ConfigMap(conf);
	if (map == null)
	{
		SetNativeString(5, "", size, false);
		return;
	}
		
	GetNativeString(2, targetPlugin, sizeof(targetPlugin));
	GetNativeString(3, targetAspect, sizeof(targetAspect));
	GetNativeString(4, argName, sizeof(argName));
		
	ConfigMap abilities = map.GetSection("character.aspects");
	if (abilities == null)
	{
		DeleteCfg(map);
		SetNativeString(5, "", size, false);
		return;
	}
		
	int i = 1;
	char secName[255];
	Format(secName, sizeof(secName), "aspect_%i", i);
		
	ConfigMap subsection = abilities.GetSection(secName);
	while (subsection != null)
	{
		subsection.Get("aspect_name", abName, sizeof(abName));
		subsection.Get("plugin_name", pluginName, sizeof(pluginName));
		
		if (StrEqual(targetPlugin, pluginName) && StrEqual(targetAspect, abName))
		{
			char arg[255]; 
			subsection.Get(argName, arg, sizeof(arg));
			SetNativeString(5, arg, size, false);
			break;
		}
		
		i++;
		Format(secName, sizeof(secName), "aspect_%i", i);
		subsection = abilities.GetSection(secName);
	}
	
	DeleteCfg(map);
}