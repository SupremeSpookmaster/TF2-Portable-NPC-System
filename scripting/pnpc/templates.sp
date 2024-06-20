public const char s_ModelFileExtensions[][] =
{
	".dx80.vtx",
	".dx90.vtx",
	".mdl",
	".phy",
	".sw.vtx",
	".vvd"
};

#define MAXIMUM_TEMPLATES			2048

PNPC_Template Templates[MAXIMUM_TEMPLATES];

char Template_ConfigName[MAXIMUM_TEMPLATES][255];
char Template_Name[MAXIMUM_TEMPLATES][255];

bool b_TemplateExists[MAXIMUM_TEMPLATES] = { false, ... };

ConfigMap g_ConfigMap[MAXIMUM_TEMPLATES] = { null, ... };

public void Templates_MakeNatives()
{
	CreateNative("PNPC_Template.PNPC_Template", Native_PNPCTemplate_Constructor);
	CreateNative("PNPC_Template.Destroy", Native_PNPCTemplate_Destroy);
	CreateNative("PNPC_Template.Spawn", Native_PNPCTemplate_Spawn);
	CreateNative("PNPC_Template.GetConfigName", Native_PNPCTemplate_GetConfigName);
	CreateNative("PNPC_Template.SetConfigName", Native_PNPCTemplate_SetConfigName);
	CreateNative("PNPC_Template.GetName", Native_PNPCTemplate_GetName);
	CreateNative("PNPC_Template.SetName", Native_PNPCTemplate_SetName);
	CreateNative("PNPC_Template.b_Exists.get", Native_PNPCTemplate_GetExists);
	CreateNative("PNPC_Template.b_Exists.set", Native_PNPCTemplate_SetExists);
	CreateNative("PNPC_Template.g_ConfigMap.get", Native_PNPCTemplate_GetConfigMap);
	CreateNative("PNPC_Template.g_ConfigMap.set", Native_PNPCTemplate_SetConfigMap);
	CreateNative("PNPC_Template.Index.get", Native_PNPCTemplate_GetIndex);
	CreateNative("PNC_Template.GetConfigMap", Native_PNPCTemplate_GetConfigMapCopy);
}

public any Native_PNPCTemplate_GetConfigMapCopy(Handle plugin, int numParams)
{
	char filePath[255];
	Format(filePath, sizeof(filePath), "configs/npcs/%s.cfg", Template_ConfigName[GetNativeCell(1)]);

	return new ConfigMap(filePath);
}

public int Native_PNPCTemplate_Constructor(Handle plugin, int numParams)
{
	char file[255], path[255];
	GetNativeString(1, file, sizeof(file));
	Format(path, sizeof(path), "configs/npcs/%s.cfg", file);

	ConfigMap map = new ConfigMap(path);
	if (map == null)
	{
		LogError("PNPCTemplate constructor failed: file ''%s'' does not exist!", file);
		return -1;
	}

	int index = 0;
	while (b_TemplateExists[index] && index < MAXIMUM_TEMPLATES - 1)
		index++;

	if (index >= MAXIMUM_TEMPLATES - 1)
	{
		LogError("PNPCTemplate constructor failed: the maximum number of templates (%i) has been reached!", MAXIMUM_TEMPLATES);
		return -1;
	}

	b_TemplateExists[index] = true;
	g_ConfigMap[index] = map;
	map.Get("npc.name", Template_Name[index], 255);
	strcopy(Template_ConfigName[index], 255, file);
	Templates[index] = view_as<PNPC_Template>(index);

	return index;
}

public int Native_PNPCTemplate_Destroy(Handle plugin, int numParams)
{
	PNPC_Template template = view_as<PNPC_Template>(GetNativeCell(1));
	b_TemplateExists[template.Index] = false;
	if (g_ConfigMap[template.Index] != null)
		DeleteCfg(g_ConfigMap[template.Index]);

	return 0;
}

public int Native_PNPCTemplate_Spawn(Handle plugin, int numParams)
{
	PNPC_Template template = view_as<PNPC_Template>(GetNativeCell(1));

	float pos[3], ang[3];
	GetNativeArray(2, pos, sizeof(pos));
	GetNativeArray(3, ang, sizeof(ang));
	int owner = GetNativeCell(4);
	TFTeam team = GetNativeCell(5);

	char name[255], model[255], confName[255];
	template.g_ConfigMap.Get("npc.visuals.model", model, sizeof(model));
	template.GetName(name);
	template.GetConfigName(confName);

	int health = GetIntFromConfigMap(template.g_ConfigMap, "npc.stats.health", 100);
	float speed = GetFloatFromConfigMap(template.g_ConfigMap, "npc.stats.speed", 300.0);
	int skin = GetIntFromConfigMap(template.g_ConfigMap, "npc.visuals.skin", -1);
	float scale = GetFloatFromConfigMap(template.g_ConfigMap, "npc.visuals.scale", 1.0);
	float thinkRate = GetFloatFromConfigMap(template.g_ConfigMap, "npc.stats.think_rate", 1.0);
	float lifespan = GetFloatFromConfigMap(template.g_ConfigMap, "npc.stats.lifespan", 0.0);

	int spawned = PNPC(model, team, health, health, skin, scale, speed, _, _, thinkRate, pos, ang, lifespan, confName, name).Index;
	if (IsValidEntity(spawned))
	{
		PNPC npc = view_as<PNPC>(spawned);
		if (IsValidEntity(owner))
			SetEntPropEnt(spawned, Prop_Send, "m_hOwnerEntity", owner);

		char activity[255], flinch[255], blood[255];
		template.g_ConfigMap.Get("npc.visuals.activity", activity, sizeof(activity));
		template.g_ConfigMap.Get("npc.visuals.bleed_particle", blood, sizeof(blood));
		template.g_ConfigMap.Get("npc.visuals.flinch_activity", flinch, sizeof(flinch));

		npc.SetActivity(activity);
		npc.SetDamagedVFX(blood, flinch);
		
		npc.SetGibsFromConfig();
		RequestFrame(Template_ApplyVFXPostSpawn, npc);
		npc.SetAttachmentsFromConfig();

		return spawned;
	}

	return 0;
}

public void Template_ApplyVFXPostSpawn(PNPC npc)
{
	if (!npc.b_Exists)
		return;

	npc.SetParticlesFromConfig();
}

public int Native_PNPCTemplate_GetConfigName(Handle plugin, int numParams) {  SetNativeString(2, Template_ConfigName[GetNativeCell(1)], 255); return 0; }
public int Native_PNPCTemplate_SetConfigName(Handle plugin, int numParams)
{
	char name[255];
	GetNativeString(2, name, sizeof(name));
	strcopy(Template_ConfigName[GetNativeCell(1)], 255, name);
	return 0;
}

public int Native_PNPCTemplate_GetName(Handle plugin, int numParams) {  SetNativeString(2, Template_Name[GetNativeCell(1)], 255); return 0; }
public int Native_PNPCTemplate_SetName(Handle plugin, int numParams)
{
	char name[255];
	GetNativeString(2, name, sizeof(name));
	strcopy(Template_Name[GetNativeCell(1)], 255, name);
	return 0;
}

public any Native_PNPCTemplate_GetExists(Handle plugin, int numParams) { return b_TemplateExists[GetNativeCell(1)]; }
public int Native_PNPCTemplate_SetExists(Handle plugin, int numParams)
{
	b_TemplateExists[GetNativeCell(1)] = GetNativeCell(2);
	return 0;
}

public any Native_PNPCTemplate_GetConfigMap(Handle plugin, int numParams) { return g_ConfigMap[GetNativeCell(1)]; }
public int Native_PNPCTemplate_SetConfigMap(Handle plugin, int numParams)
{
	g_ConfigMap[GetNativeCell(1)] = GetNativeCell(2);
	return 0;
}

public any Native_PNPCTemplate_GetIndex(Handle plugin, int numParams) { return GetNativeCell(1); }

public void Templates_MapStart()
{
	Templates_LoadNPCs();
}

public void Templates_MapEnd()
{
	Templates_DeleteAll();
}

public void Templates_DeleteAll()
{
	for (int i = 0; i < MAXIMUM_TEMPLATES; i++)
	{
		PNPC_Template template = view_as<PNPC_Template>(i);
		if (template.b_Exists)
			template.Destroy();
	}
}

public void Templates_LoadNPCs()
{
	Templates_DeleteAll();

	ConfigMap ListOfNPCs = new ConfigMap("data/pnpc/npcs.cfg");
	if (ListOfNPCs == null)
	{
		LogError("data/pnpc/npcs.cfg does not exist!");
		return;
	}
	
	int i = 1;
	char CurrentCFG[255], CurrentSlot[16];
	Format(CurrentSlot, sizeof(CurrentSlot), "npcs.%i", i);
	while (ListOfNPCs.Get(CurrentSlot, CurrentCFG, 255) > 0)
	{
		char CFGPath[255];
		Format(CFGPath, sizeof(CFGPath), "configs/npcs/%s.cfg", CurrentCFG);

		ConfigMap NPCMap = new ConfigMap(CFGPath);
		
		if (NPCMap != null)
		{
			new PNPC_Template(CurrentCFG);
			Templates_ManageNPCFiles(NPCMap);
			
			DeleteCfg(NPCMap);
		}
		else
		{
			LogError("data/pnpc/npcs.cfg specifies a PNPC with the config path ''%s'', but no such config exists.", CFGPath);
		}
		
		i++;
		Format(CurrentSlot, sizeof(CurrentSlot), "npcs.%i", i);
	}
	
	DeleteCfg(ListOfNPCs);
}

public void Templates_ManageNPCFiles(ConfigMap NPCMap)
{
	ConfigMap section = NPCMap.GetSection("character.model_download");
 	if (section != null)
 	{
 		Templates_DownloadNPCModels(section);
 	}
 	
 	section = NPCMap.GetSection("npc.downloads");
 	if (section != null)
 	{
 		Templates_DownloadFiles(section);
 	}
 	
 	section = NPCMap.GetSection("npc.precache");
 	if (section != null)
 	{
 		Templates_PrecacheFiles(section);
 	}

	section = NPCMap.GetSection("npc.visuals.models");
	if (section != null)
	{
		Templates_PrecacheMiscs(section);
	}

	section = NPCMap.GetSection("npc.visuals.gibs");
	if (section != null)
	{
		Templates_PrecacheMiscs(section);
	}
}

public void Templates_PrecacheMiscs(ConfigMap subsection)
{
	int slot = 1;
	char slotChar[16];
	ConfigMap instance = subsection.GetSection("1");

	while (instance != null)
	{
		char model[255];
		instance.Get("model", model, sizeof(model));
		
		if (CheckFile(model))
			PrecacheModel(model);

		slot++;
		IntToString(slot, slotChar, sizeof(slotChar));
		instance = subsection.GetSection(slotChar);
	}
}

public void Templates_DownloadNPCModels(ConfigMap subsection)
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

 public void Templates_DownloadFiles(ConfigMap subsection)
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

 public void Templates_PrecacheFiles(ConfigMap subsection)
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

//TODO: Expand parameters to allow specifying a position, angles, owner, and team. Possibly more as well.
public int PNPC_SpawnNPC(char name[255])
{
	//TODO: This freaks out and lags the server for a brief moment if it fails to find the template it's looking for.
	//It seems to cycle through the first template until it reaches the max when this happens. Not sure why.
	for (int i = 0; i < MAXIMUM_TEMPLATES && Templates[i].b_Exists; i++)
	{		
		char confName[255], realName[255];
		Templates[i].GetConfigName(confName);
		Templates[i].GetName(realName);

		if (StrEqual(name, confName) || StrContains(realName, name, false) != -1)
		{
			return Templates[i].Spawn(NULL_VECTOR, NULL_VECTOR);
		}
	}
	
	return -1;
}