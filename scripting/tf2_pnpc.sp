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
	PNPC_MapStart();
	
	PrecacheSound(SND_ADMINCOMMAND);
	PrecacheSound(SND_ADMINCOMMAND_ERROR);
}

public void OnMapEnd()
{
	PNPC_MapEnd();
}

PNPC PNPCs[MAXIMUM_PNPCS];

int i_NumTemplates = 0;

bool b_IsPNPC[2049] = { false, ... };

public void PNPC_LoadNPCs()
{
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

public void PNPC_LoadNPCData(ConfigMap NPCMap, char CFGName[255])
{
	char Name[255], Model[255], AI[255];
	NPCMap.Get("npc.name", Name, sizeof(Name));
	NPCMap.Get("npc.model", Model, sizeof(Model));
	NPCMap.Get("npc.ai", AI, sizeof(AI));
			
	int MaxHP = GetIntFromConfigMap(NPCMap, "npc.health", 0);
	float Speed = GetFloatFromConfigMap(NPCMap, "npc.speed", 0.0);

	//TODO: Create an NPC Template from the data read from the config.
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
		if (PNPC_IsNPC(i))
		{
			//TODO: Kill NPC
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
		if (PNPCs[i].b_Exists && (StrEqual(name, PNPCs[i].ConfigName) || StrContains(PNPCs[i].Name, name) != -1))
		{
			//TODO: Spawn NPC
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
		
		if (PNPC_IsNPC(DestroyedPNPC))
		{
			CPrintToChat(client, "{orange}[Portable NPC System] {default}Destroyed {olive}%s{default}.", "TODO: Put the spawned NPC's name here.");
			EmitSoundToClient(client, SND_ADMINCOMMAND);
			
			//TODO: Kill
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