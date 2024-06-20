int i_MaxNPCs = -1;
int i_MaxNPCsMethod = 0;
int i_MaxGibs = -1;
int i_MaxAttachments = -1;
int i_MaxParticles = -1;
int i_HealthBars = -1;
int i_HealthBarsDisplay = -1;

bool b_KillFeed = false;
bool b_MeleeHitreg = false;
bool b_CustomExplosions = false;

char s_DefaultName[255] = "";

public void Settings_Load()
{
	ConfigMap conf = new ConfigMap("data/pnpc/settings.cfg");
	if (conf == null)
	{
		LogError("data/pnpc/settings.cfg does not exist!");
		return;
	}

	i_MaxNPCs = GetIntFromConfigMap(conf, "settings.max_npcs", -1);
	i_MaxNPCsMethod = GetIntFromConfigMap(conf, "settings.npc_limit_method", 0);
	i_MaxGibs = GetIntFromConfigMap(conf, "settings.npc_max_gibs", -1);
	i_MaxAttachments = GetIntFromConfigMap(conf, "settings.npc_attachments_max", -1);
	i_MaxParticles = GetIntFromConfigMap(conf, "settings.npc_particles_max", -1);
	i_HealthBars = GetIntFromConfigMap(conf, "settings.npc_health_bars", 0);
	i_HealthBarsDisplay = GetIntFromConfigMap(conf, "settings.npc_health_bars_display", 0);
	b_KillFeed = GetBoolFromConfigMap(conf, "settings.npc_killfeed", true);
	conf.Get("settings.npc_default_name", s_DefaultName, sizeof(s_DefaultName));
	b_MeleeHitreg = GetBoolFromConfigMap(conf, "settings.custom_melee_hitreg", true);
	b_CustomExplosions = GetBoolFromConfigMap(conf, "settings.custom_explosion_logic", true);

	DeleteCfg(conf);
}

/**
 * Checks if there would be too many NPCs after spawning another one.
 * 
 * @param NPCs		Current list of NPCs.
 * 
 * @return	True if spawning one more NPC will exceed the limit, false otherwise.
 */
public bool Settings_WillExceedNPCLimit(Queue NPCs)
{
	if (i_MaxNPCs < 0)
		return false;

	return NPCs.Length + 1 > i_MaxNPCs;
}

public int Settings_GetMaxNPCsMethod() { return i_MaxNPCsMethod; }

/**
 * Checks if there would be too many gibs after spawning another one.
 * 
 * @param Gibs		Current list of gibs.
 * 
 * @return	True if spawning one more gib will exceed the limit, false otherwise.
 */
public bool Settings_WillExceedGibLimit(Queue Gibs)
{
	if (i_MaxGibs < 0)
		return false;

	return Gibs.Length + 1 > i_MaxGibs;
}

public int Settings_GetMaxAttachments() { return i_MaxAttachments; }
public int Settings_GetMaxParticles() { return i_MaxParticles; }
public bool Settings_AllowExplosions() { return !b_CustomExplosions; }