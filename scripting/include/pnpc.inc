#if defined _pnpc_included_
  #endinput
#endif
#define _pnpc_included_

#include <cbasenpc>

methodmap PNPC_Template __nullable__
{
	/**
	 * Generates a PNPC template from a given config file.
	 * 
	 * @param file			The file to generate from, relative to sourcemod/configs/npcs.
	 */
	public native PNPC_Template(char[] file);

	/**
	 * Removes this template from the list of templates and deletes its ConfigMap. 
	 * Don't call this unless you know exactly what you're doing, the Portable NPC System calls this automatically in all of the main situations where it would be needed.
	 * The only time you should need this would be in weird edge cases where you're already doing fairly advanced things with the templates.
	 */
	public native void Destroy();

	/**
	 * Spawns a PNPC using this template.
	 * 
	 * @param pos			The position to spawn the PNPC at.
	 * @param ang			The angles to spawn the PNPC with.
	 * @param owner			The entity this PNPC belongs to. Does not need to be valid.
	 * @param team			The team this PNPC belongs to.
	 * 
	 * @return	The entity index of the spawned PNPC if successful, -1 otherwise.
	 */
	public native int Spawn(float pos[3], float ang[3], int owner = -1, TFTeam team = TFTeam_Spectator);

	/**
	 * Retrieves the config file used for this PNPC template, relative to sourcemod/configs/npcs.
	 * 
	 * @param output		Output buffer.
	 * @param size			Output buffer length.
	 * @param buildPath		If set to true, the output buffer will contain the full path needed to create a ConfigMap of this config.
	 */
	public native void GetConfigName(char[] output, int size, bool buildPath = false);

	/**
	 * Sets the config file used for this PNPC template, relative to sourcemod/configs/npcs.
	 * 
	 * @param file			New file to use.
	 */
	public native void SetConfigName(char[] file);

	/**
	 * Retrieves the in-game name used for PNPCs spawned using this template. IE: "John".
	 * 
	 * @param output		Output buffer.
	 * @param size			Output buffer length.
	 */
	public native void GetName(char[] output, int size);

	/**
	 * Sets the in-game name used for PNPCs spawned using this template. IE: "John".
	 * 
	 * @param name		New name to use.
	 */
	public native void SetName(char[] name);

	property int Index
	{
		public native get();
	}

	property bool b_Exists
	{
		public native get();
		public native set(bool value);
	}

	property ConfigMap g_ConfigMap
	{
		/**
		 * NOTE: This getter is for internal use only! If you need to mess with a PNPC's ConfigMap, use PNPC.GetConfigName with the "buildPath" parameter set to true, then create a new ConfigMap from that!
		 */
		public native get();
		public native set(ConfigMap value);
	}
}

methodmap PNPC < CBaseCombatCharacter
{
	/**
	 * Creates a new Chaos Fortress NPC.
	 *
	 * @param model			Model to use. Needs to be precached.
	 * @param team			The NPC's team.
	 * @param health		The NPC's health.
	 * @param maxHealth		The NPC's max health.
	 * @param skin			Skin to set. Set below zero to automatically assign a skin based on the given team (requires TFTeam_Red or TFTeam_Blue).
	 * @param scale			Model scale. Affects bounding box.
	 * @param speed			Movement speed, in hammer units per second.
	 * @param logic			A function which is called per "thinkRate" interval while the NPC is active. Must take one integer, which is the NPC's entity index.
	 * @param plugin		The name of the plugin which contains the logic function.
	 * @param thinkRate		The rate at which this NPC's logic function is called. 0.0 or below: every frame.
	 * @param pos			Position to spawn the NPC at.
	 * @param ang			Angles to spawn the NPC with.
	 * @param lifespan		Time until the NPC is automatically destroyed. <= 0.0: do not delete.
	 * @param config		The name of the config associated with this PNPC, relative to sourcemod/configs/npcs. DOES NOT include the .cfg.
	 * @param name			The name of this PNPC, as displayed in-game.
	 */
	public native PNPC(char[] model, TFTeam team, int health = 200, int maxHealth = 200, int skin = -1, float scale = 1.0, float speed = 300.0, Function logic = INVALID_FUNCTION, char plugin[255] = "", float thinkRate = 0.0, float pos[3] = NULL_VECTOR, float ang[3] = NULL_VECTOR, float lifespan = 0.0, char config[255] = "", char name[255] = "");

	/**
	 * Retrieves the PNPC's model, stored in the output buffer.
	 * 
	 * @param output		Output buffer to store the model's path.
	 * @param size			Output buffer length.
	 */
	public native void GetModel(char[] output, int size);

	/**
	 * Sets the PNPC's model.
	 * 
	 * @param newModel		New model to use. Must be precached.
	 */
	public native void SetModel(char[] newModel);

	/**
	 * Retrieves the bleed particle used when this PNPC takes damage, stored in the output buffer.
	 * 
	 * @param output		Output buffer to store the bleed particle.
	 * @param size			Output buffer length.
	 */
	public native void GetBleedParticle(char[] output, int size);

	/**
	 * Sets the PNPC's bleed particle, to be used when the PNPC is damaged.
	 * 
	 * @param newBleed		New bleed particle to use. Can be left blank tomake the PNPC not bleed at all.
	 */
	public native void SetBleedParticle(char[] newBleed);

	/**
	 * Retrieves the gesture played when this PNPC takes damage, stored in the output buffer.
	 * 
	 * @param output		Output buffer to store the flinch sequence.
	 * @param size			Output buffer length.
	 */
	public native void GetFlinchSequence(char[] output, int size);

	/**
	 * Sets the PNPC's flinch gesture, to be used when the PNPC is damaged.
	 * 
	 * @param newFlinch		New flinch sequence to use, EX: ACT_MP_GESTURE_FLINCH_CHEST. Can be left blank to make the PNPC not flinch at all.
	 */
	public native void SetFlinchSequence(char[] newFlinch);

	/**
	 * Sets the PNPC's bleed particle and flinch gesture.
	 * 
	 * @param newBleed		Bleed particle.
	 * @param newFlinch		Flinch gesture, EX: ACT_MP_GESTURE_FLINCH_CHEST.
	 */
	public native void SetDamagedVFX(char[] newBleed, char[] newFlinch);

	/**
	 * Retrieves the file name of this PNPC's config, relative to sourcemod/configs/npcs.
	 * 
	 * @param output		Output buffer.
	 * @param size			Size of the output buffer.
	 * @param buildPath		If set to true, the output buffer will contain the full path needed to create a ConfigMap of this config.
	 */
	public native void GetConfigName(char[] output, int size, bool buildPath = false);

	/**
	 * Sets the file name of this PNPC's config, relative to sourcemod/configs/npcs.
	 * 
	 * @param config		New config name.
	 */
	public native void SetConfigName(char[] config);

	/**
	 * Retrieves the name of this PNPC, as displayed in-game.
	 * 
	 * @param output		Output buffer.
	 * @param size			Size of the output buffer.
	 */
	public native void GetName(char[] output, int size);

	/**
	 * Sets the name of this PNPC, as displayed in-game.
	 * 
	 * @param name		New name.
	 */
	public native void SetName(char[] name);

	/**
	 * Automatically sets this PNPC's gibs, using its config.
	 */
	public native void SetGibsFromConfig();

	/**
	 * Clears all models and attachments from this PNPC's list of gibs to use when it is gibbed.
	 */
	public native void ClearGibs();

	/**
	 * Automatically sets this PNPC's particle effects, using its config.
	 */
	public native void SetParticlesFromConfig();

	/**
	 * Automatically sets this PNPC's model attachments, using its config.
	 */
	public native void SetAttachmentsFromConfig();

	/**
	 * Automatically applies the settings for this PNPC's visual health bar, using its config.
	 */
	public native void SetHealthBarFromConfig();

	/**
	 * Retrieves the PNPC's locomotion interface.
	 */
	public native CBaseNPC_Locomotion GetLocomotion();

	/**
	 * Retrieves the CBaseNPC at the root of this PNPC.
	 */
	public native CBaseNPC GetBaseNPC();

	/**
	 * Retrieves the INextBot at the root of this PNPC.
	 */
	public native INextBot GetBot();

	/**
	 * Sets the PNPC's current sequence. The sequence is automatically checked with LookupSequence.
	 * 
	 * @param	sequence	The sequence to set.
	 * 
	 * @return	True if the sequence exists and was successfully set, false otherwise.
	 */
	public native bool SetSequence(char[] sequence);

	/**
	 * Sets the PNPC's current activity. The activity is automatically checked with LookupActivity.
	 * 
	 * @param	activity	The activity to set.
	 * 
	 * @return	True if the activity exists and was successfully set, false otherwise.
	 */
	public native bool SetActivity(char[] activity);

	/**
	 * Retrieves the index of the given activity.
	 * 
	 * @param activity	The activity to lookup.
	 * 
	 * @return	The activity's index, -1 if it does not exist.
	 */
	public native int LookupActivity(char[] activity);

	/**
	 * Sets the time in the current sequence/activity's cycle.
	 * 
	 * @param cycle		The time to set.
	 *
	 */
	public native void SetCycle(float cycle);

	/**
	 * Sets the playback rate for the PNPC's sequences and activities. Note that this is always reset to 1.0 when using SetSequence or SetActivity.
	 * 
	 * @param rate		The playback rate to set.
	 */
	public native void SetPlaybackRate(float rate);

	/**
	 * Adds a gesture to the PNPC.
	 * 
	 * @param gesture		The gesture to add. EX: "ACT_MP_ATTACK_STAND_MELEE".
	 * @param cancel		If true: cancel any currently-active gestures.
	 * @param duration		The duration of the gesture.
	 * @param autoKill		If true: automatically remove the gesture once its animation is finished.
	 * @param playbackRate	The rate at which the gesture should be animated.
	 */
	public native void AddGesture(char[] gesture, bool cancel = true, float duration = 1.0, bool autoKill = true, float playbackRate = 1.0);

	/**
	 * Removes the given gesture from a PNPC.
	 * 
	 * @param gesture		The gesture to remove.
	 */
	public native void RemoveGesture(char[] gesture);

	/**
	 * Gets this PNPC's PathFollower.
	 */
	public native PathFollower GetPathFollower();

	/**
	 * Causes this PNPC to begin moving towards its target destination.
	 */
	public native void StartPathing();

	/**
	 * Stops this PNPC from moving towards its target destination.
	 */
	public native void StopPathing();

	/**
	 * Sets the vector coordinates for this PNPC's target destination. This will automatically make them start moving, call PNPC.StopPathing after this to prevent that.
	 * Note that if this PNPC's i_PathTarget property is a valid entity, that will completely override this. To prevent this from happening, just clear i_PathTarget before 
	 * calling this method.
	 * 
	 * @param pos		The location to target.
	 */
	public native void SetGoalVector(float pos[3]);

	/**
	 * Sets the entity that this PNPC will attempt to path to. This will automatically make them start moving, call PNPC.StopPathing after this to prevent that.
	 * The PNPC will stop pathing automatically if that entity is invalid or dead. If the entity was a player who died, pathing will automatically restart once the target respawns.
	 * This can also be done by setting the PNPC.i_PathTarget property to a valid entity.
	 * 
	 * @param entity	The entity to target.
	 */
	public native void SetGoalEntity(int entity);

	/**
	 * Retrieves the PNPC's ground speed.
	 */
	public native float GetGroundSpeed();

	/**
	 * Retrieves the PNPC's ground motion vector, stored in the output vector.
	 * 
	 * @param output	Output vector.
	 */
	public native void GetGroundMotionVector(float output[3]);

	/**
	 * Forces the PNPC to ragdoll, killing it in the process.
	 * 
	 * @param vel	Optional ragdoll velocity. Can be left as NULL_VECTOR to not do anything special.
	 */
	public native void Ragdoll(float vel[3] = NULL_VECTOR);

	/**
	 * Immediately gibs the PNPC, killing it in the process. Note that only NPCs that actually have gibs will work with this, use PNPC.AddGib to create a list of gibs to be used.
	 */
	public native void Gib();

	/**
	 * Adds a model to the PNPC's list of models to be used when it is gibbed. These models must all be precached.
	 * 
	 * @param model			The model. The gib's skin is automatically set to use the same skin as the PNPC.
	 * @param attachment	The attachment this model should be spawned on. Spawns at the center of the PNPC's model if left blank.
	 */
	public native void AddGib(char[] model, char[] attachment = "");

	/**
	 * Either retrieves or sets the ragdoll force for this PNPC.
	 * 
	 * @param vel			Vector.
	 * @param override		If true: use "vel" to replace the current ragdoll force. Otherwise, stores the current ragdoll force in vel as an output vector.
	 */
	public native void PunchForce(const float vel[3], bool override);

	/**
	 * Attaches a model to the PNPC. You must precache these manually.
	 * 
	 * @param model			The model to attach.
	 * @param attachment	The bone to attach to.
	 * @param sequence		Optional sequence to apply to the model.
	 * @param skin			The skin to use. Set to -1 to automatically set the skin based on the PNPC's team.
	 * @param scale			The model's scale.
	 * @param bonemerge		If true, bonemerges the model to the PNPC (useful for cosmetics). Note that this will bypass "attachment".
	 * @param weapon		If true, this model is treated as a weapon. This is used primarily for muzzle flashes.
	 * 
	 * @return	The entity index of the attached model.
	 */
	public native int AttachModel(char[] model, char[] attachment = "", char[] sequence = "", int skin = -1, float scale = 1.0, bool bonemerge = true, bool weapon = false);

	/**
	 * Attaches a particle to the PNPC.
	 * 
	 * @param particle		The particle to attach.
	 * @param attachment	The point to attach to.
	 * @param lifespan		The duration for which the particle should exist.
	 * @param xOff			Optional X-axis offset.
	 * @param yOff			Optional Y-axis offset.
	 * @param zOff			Optional Z-axis offset.
	 * 
	 * @return	The entity index of the attached particle.
	 */
	public native int AttachParticle(char[] particle, char[] attachment = "", float lifespan = 0.0, float xOff = 0.0, float yOff = 0.0, float zOff = 0.0);

	/**
	 * Removes all specified models attached via PNPC.AttachModel.
	 * 
	 * @param cosmetics		Set to true to remove models classified as cosmetics.
	 * @param weapons		Set to true to remove models classified as weapons.
	 * @param particles		Set to true to remove particles.
	 */
	public native void RemoveAttachments(bool cosmetics = true, bool weapons = true, bool particles = true);

	/**
	 * Ignites the PNPC.
	 * 
	 * @param duration		The time to extend the PNPC's remaining afterburn duration.
	 * @param minDuration	If the PNPC's total afterburn duration would be shorter than this value after adding the specified duration, set the afterburn duration to this value.
	 * 						EX: If the PNPC's remaining afterburn duration is 2 seconds and the duration parameter is 4 seconds, the PNPC's afterburn duration will be 6 seconds.
	 * 						If we set minDuration to 8 seconds, the PNPC will instead be set to burn for 8 seconds, because 6 seconds is shorter than the minimum duration.
	 * @param maxDuration	The same as minDuration, but caps the afterburn duration instead. This does nothing if the PNPC's remaining afterburn duration is already higher than this value.
	 * 						If <= 0.0: there is no cap to afterburn duration.
	 * @param damage		The damage dealt per tick by afterburn.
	 * @param haunted		If true: the Spectral Flame Halloween spell effect will be used as the afterburn particle.
	 * @param attacker		The entity which will be credited for damage dealt by the afterburn.
	 * 
	 * @return 	True if the PNPC was successfully ignited, false if something prevented it.
	 */
	public native bool Ignite(float duration, float minDuration = 0.0, float maxDuration = 0.0, float damage = 4.0, bool haunted = false, int attacker = 0);

	/**
	 * Causes the PNPC to bleed.
	 * 
	 * @param duration		The duration of the bleed.
	 * @param damage		Damage dealt per bleed tick.
	 * @param attacker		The entity which will be credited with the bleed damage.
	 * 
	 * @return	True if the PNPC was successfully made bleeding, false if something prevented it.
	 */
	public native bool Bleed(float duration, float damage, int attacker = 0);

	/**
	 * Coats the PNPC in Mad Milk.
	 * 
	 * @param duration		The duration for which to apply Mad Milk.
	 * @param attacker		The entity which is responsible for the coating.
	 * 
	 * @return	True if the PNPC was successfully coated, false if something prevented it.
	 */
	public native bool ApplyMilk(float duration, int attacker = 0);

	/**
	 * Coats the PNPC in Jarate.
	 * 
	 * @param duration		The duration for which to apply Jarate.
	 * @param attacker		The entity which is responsible for the coating.
	 * 
	 * @return	True if the PNPC was successfully coated, false if something prevented it.
	 */
	public native bool ApplyJarate(float duration, int attacker = 0);

	/**
	 * Coats the PNPC in Gas Passer gas.
	 * 
	 * @param duration		The duration for which to apply gas.
	 * @param attacker		The entity which is responsible for the coating.
	 * 
	 * @return	True if the PNPC was successfully coated, false if something prevented it.
	 */
	public native bool ApplyGas(float duration, int attacker = 0);

	/**
	 * Removes the PNPC's Mad Milk.
	 * 
	 * @param forced	If true, the return value of PNPC_OnPNPCMilkRemoved is completely ignored, forcing the removal to go through no matter what.
	 * 
	 * @return	True if the PNPC was successfully un-milked, false otherwise.
	 */
	public native bool RemoveMilk(bool forced = false);

	/**
	 * Removes the PNPC's Jarate.
	 * 
	 * @param forced	If true, the return value of PNPC_OnPNPCJarateRemoved is completely ignored, forcing the removal to go through no matter what.
	 * 
	 * @return	True if the PNPC was successfully un-jarated, false otherwise.
	 */
	public native bool RemoveJarate(bool forced = false);

	/**
	 * Removes the PNPC's Gas Passer gas.
	 * 
	 * @param forced	If true, the return value of PNPC_OnPNPCGasRemoved is completely ignored, forcing the removal to go through no matter what.
	 * 
	 * @return	True if the PNPC was successfully un-gassed, false otherwise.
	 */
	public native bool RemoveGas(bool forced = false);

	/**
	 * Extinguishes the PNPC's afterburn.
	 * 
	 * @param forced	If true, the return value of PNPC_OnPNPCExtinguished is completely ignored, forcing the extinguish to go through no matter what.
	 * 
	 * @return	True if the PNPC was successfully extinguished, false otherwise.
	 */
	public native bool Extinguish(bool forced = false);

	/**
	 * Temporarily changes the PNPC's speed.
	 * 
	 * @param mod		The factor by which to change the PNPC's speed, relative to speedMode.
	 * @param speedMode	Used to determine how to change the PNPC's speed.
	 * 					<= 0: Multiply the PNPC's base speed by "mod" and add the difference to their speed.
	 * 					1: The same as 0, but with the PNPC's current speed instead of their base speed.
	 * 					>= 2: Directly add "mod" to the PNPC's current speed.
	 * @param duration	The duration of the speed modifier.
	 */
	public native void ApplyTemporarySpeedChange(float mod, int speedMode, float duration);

	/**
	 * Sets the bounding box of the PNPC. 
	 * 
	 * @param mins		New mins.
	 * @param maxs		New maxs.
	 * @param autoscale	If true, the mins and maxs are automatically scaled based on the PNPC's model scale.
	 */
	public native void SetBoundingBox(float mins[3], float maxs[3], bool autoscale = true);

	/**
	 * Retrieves the bounding box of the PNPC.
	 * 
	 * @param mins		Output buffer for mins.
	 * @param maxs		Output buffer for maxs.
	 * 
	 * @return	The PNPC's bounding box dimensions, stored in the output buffers.
	 */
	public native void GetBoundingBox(float mins[3], float maxs[3]);
	
	/**
	 * Checks to see if this PNPC can be at the given position without being stuck.
	 * 
	 * @param pos			The position to check.
	 * @param intersection	Optional output buffer in which to store the hull trace's hit point, if the PNPC would get stuck. This DOES NOT get set if the given position is outside of the map.
	 * 
	 * @return		True if this PNPC can be in the given position without getting stuck, false otherwise.
	 */
	public native bool IsPositionValid(float pos[3], float intersection[3] = NULL_VECTOR);

	/**
	 * Checks to see if this PNPC has a given aspect.
	 * 
	 * @param aspect		Aspect name, IE "my_aspect".
	 * @param plugin		Plugin name, IE "my_plugin".
	 * @param output		Optional output buffer to store the ConfigMap path to the aspect if it is found, IE "npc.aspects.aspect_1".
	 * @param size			Output buffer length.
	 * 
	 * @return		True if the aspect is found, false otherwise.
	 */
	public native bool HasAspect(char[] aspect, char[] plugin, char[] output = "", int size = 0);

	/**
	 * Retrieves an integer associated with a given aspect of this PNPC.
	 * 
	 * @param aspect		Aspect name, IE "my_aspect".
	 * @param plugin		Plugin name, IE "my_plugin".
	 * @param key			Key to retrieve the integer from, IE "my_key".
	 * @param defaultVal	Default value to return if the aspect or key does not exist on this PNPC.
	 * 
	 * @return		The integer value associated with the given aspect's specified key.
	 */
	public native int GetArgI(char[] aspect, char[] plugin, char[] key, int defaultVal = 0);

	/**
	 * Retrieves a float associated with a given aspect of this PNPC.
	 * 
	 * @param aspect		Aspect name, IE "my_aspect".
	 * @param plugin		Plugin name, IE "my_plugin".
	 * @param key			Key to retrieve the integer from, IE "my_key".
	 * @param defaultVal	Default value to return if the aspect or key does not exist on this PNPC.
	 * 
	 * @return		The float value associated with the given aspect's specified key.
	 */
	public native float GetArgF(char[] aspect, char[] plugin, char[] key, float defaultVal = 0.0);

	/**
	 * Retrieves a string associated with a given aspect of this PNPC, stored in the output buffer.
	 * 
	 * @param aspect		Aspect name, IE "my_aspect".
	 * @param plugin		Plugin name, IE "my_plugin".
	 * @param key			Key to retrieve the string from, IE "my_key".
	 * @param output		Output buffer to store the result in.
	 * @param size			Output buffer length.
	 * @param defaultVal	Default value to return if the aspect or key does not exist on this PNPC.
	 * 
	 * @return		The string value associated with the given aspect's specified key, stored in the output buffer.
	 */
	public native void GetArgS(char[] aspect, char[] plugin, char[] key, char[] output, int size, char[] defaultVal = "");

	/**
	 * Triggers a sound cue based on the cues in this PNPC's config.
	 * 
	 * @param cue			The sound cue to trigger.
	 * 
	 * @return		True if a sound was successfully played.
	 */
	public native bool PlayRandomSound(char cue[255]);

	/**
	 * Updates this PNPC's visual health bar, provided it has one.
	 */
	public native void UpdateHealthBar();

	property int Index
	{
		public native get();
	}

	property int i_HealthBar
	{
		public native get();
	}

	property int i_HealthBarType
	{
		public native get();
		public native set(int value);
	}

	property int i_HealthBarDisplay
	{
		public native get();
		public native set(int value);
	}

	property float f_HealthBarHeight
	{
		public native get();
		public native set(float value);
	}

	property bool b_Exists
	{
		public native get();
		public native set(bool value);
	}

	property bool b_GibsForced
	{
		public native get();
		public native set(bool value);
	}

	property bool b_Burning
	{
		public native get();
	}

	property bool b_AfterburnIsHaunted
	{
		public native get();
		public native set(bool value);
	}

	property bool b_Milked
	{
		public native get();
	}

	property bool b_Jarated
	{
		public native get();
	}

	property bool b_Gassed
	{
		public native get();
	}

	property Function g_Logic
	{
		public native set(Function value);
	}
	
	property Handle g_LogicPlugin
	{
		public native get();
		public native set(Handle value);
	}

	property TFTeam i_Team
	{
		public native get();
		public native set(TFTeam value);
	}

	property ArrayList g_AttachedCosmetics
	{
		public native get();
		public native set(ArrayList value);
	}

	property ArrayList g_AttachedWeapons
	{
		public native get();
		public native set(ArrayList value);
	}

	property ArrayList g_AttachedParticles
	{
		public native get();
		public native set(ArrayList value);
	}

	property int i_Skin
	{
		public native get();
		public native set(int value);
	}

	property int i_Health
	{
		public native get();
		public native set(int value);
	}

	property int i_MaxHealth
	{
		public native get();
		public native set(int value);
	}

	property int i_PoseMoveX
	{
		public native get();
	}

	property int i_PoseMoveY
	{
		public native get();
	}

	property int i_AfterburnAttacker
	{
		public native get();
		public native set(int value);
	}

	property int i_Milker
	{
		public native get();
		public native set(int value);
	}

	property int i_JarateApplicant
	{
		public native get();
		public native set(int value);
	}

	property int i_GasApplicant
	{
		public native get();
		public native set(int value);
	}

	property int i_PathTarget
	{
		public native get();
		public native set(int value);
	}

	property float f_Scale
	{
		public native get();
		public native set(float value);
	}

	property float f_Speed
	{
		public native get();
		public native set(float value);
	}

	property float f_MaxSpeed
	{
		public native get();
		public native set(float value);
	}

	property float f_ThinkRate
	{
		public native get();
		public native set(float value);
	}

	property float f_NextThinkTime
	{
		public native get();
		public native set(float value);
	}

	property float f_EndTime
	{
		public native get();
		public native set(float value);
	}

	property float f_AfterburnEndTime
	{
		public native get();
		public native set(float value);
	}

	property float f_AfterburnDMG
	{
		public native get();
		public native set(float value);
	}

	property float f_MilkEndTime
	{
		public native get();
		public native set(float value);
	}

	property float f_JarateEndTime
	{
		public native get();
		public native set(float value);
	}

	property float f_GasEndTime
	{
		public native get();
		public native set(float value);
	}

	property float f_YawRate
	{
		public native get();
		public native set(float value);
	}

	property float f_StepSize
	{
		public native get();
		public native set(float value);
	}

	property float f_Gravity
	{
		public native get();
		public native set(float value);
	}

	property float f_Acceleration
	{
		public native get();
		public native set(float value);
	}

	property float f_JumpHeight
	{
		public native get();
		public native set(float value);
	}

	property float f_FrictionSideways
	{
		public native get();
		public native set(float value);
	}
	
	property float f_FrictionForwards
	{
		public native get();
		public native set(float value);
	}

	property float f_DeathDropHeight
	{
		public native get();
		public native set(float value);
	}

	property float f_OverhealDecayRate
	{
		public native get();
		public native set(float value);
	}
}

//TODO: It would be a good idea to go back and make the main PNPC methodmap inherit from this eventually.
methodmap PNPC_Animator < CBaseCombatCharacter
{
	/**
	 * Creates a new custom animator entity.
	 * Animators are specialized lightweight NPCs which cannot take damage or collide with other entities.
	 * They provide absolute control over animations, which makes them perfect for things like custom viewmodels or special VFX.
	 * 
	 * @param model		The model used by this animator.
	 * @param activity	The activity to force upon spawning this animator, EX: "ACT_INTRO".
	 * @param pos		The location to spawn the animator at.
	 * @param ang		The angles to spawn the animator with.
	 * @param skin		The skin to use for the animator.
	 * @param rate		Animation playback rate.
	 * @param scale		Animator model scale.
	 * 
	 * @return	The animator's methodmap, or -1 on failure.
	 */
	public native PNPC_Animator(char[] model, char[] activity, float pos[3] = NULL_VECTOR, float ang[3] = NULL_VECTOR, int skin = 0, float rate = 1.0, float scale = 1.0);

	/**
	 * Retrieves the animator's current model, stored in the output buffer.
	 * 
	 * @param output		Output buffer.
	 * @param size			Output buffer size.
	 * 
	 * @return	The animator's model, stored in the output buffer.
	 */
	public native void GetModel(char[] output, int size);

	/**
	 * Sets the animator's current model.
	 * 
	 * @param model		The new model to set. You must precache this manually.
	 */
	public native void SetModel(char[] model);

	/**
	 * Sets the animator's current sequence. The sequence is automatically checked with LookupSequence.
	 * 
	 * @param	sequence	The sequence to set.
	 * 
	 * @return	True if the sequence exists and was successfully set, false otherwise.
	 */
	public native bool SetSequence(char[] sequence);

	/**
	 * Sets the animator's current activity. The activity is automatically checked with LookupActivity.
	 * 
	 * @param	activity	The activity to set.
	 * 
	 * @return	True if the activity exists and was successfully set, false otherwise.
	 */
	public native bool SetActivity(char[] activity);

	/**
	 * Retrieves the index of the given activity.
	 * 
	 * @param activity	The activity to lookup.
	 * 
	 * @return	The activity's index, -1 if it does not exist.
	 */
	public native int LookupActivity(char[] activity);

	/**
	 * Adds a gesture to the animator.
	 * 
	 * @param gesture		The gesture to add. EX: "ACT_MP_ATTACK_STAND_MELEE".
	 * @param cancel		If true: cancel any currently-active gestures.
	 * @param duration		The duration of the gesture.
	 * @param autoKill		If true: automatically remove the gesture once its animation is finished.
	 * @param playbackRate	The rate at which the gesture should be animated.
	 */
	public native void AddGesture(char[] gesture, bool cancel = true, float duration = 1.0, bool autoKill = true, float playbackRate = 1.0);

	/**
	 * Removes the given gesture from the animator.
	 * 
	 * @param gesture		The gesture to remove.
	 */
	public native void RemoveGesture(char[] gesture);

	property int Index
	{
		public native get();
	}

	property int i_Owner
	{
		public native get();
		public native set(int value);
	}

	property int i_Skin
	{
		public native get();
		public native set(int value);
	}

	property float f_PlaybackRate
	{
		public native get();
		public native set(float value);
	}

	property float f_Cycle
	{
		public native get();
		public native set(float value);
	}

	property float f_Scale
	{
		public native get();
		public native set(float value);
	}
}

/**
 * Called when a PNPC is headshot.
 * 
 * @param npc			The PNPC.
 * @param weapon		The weapon used to inflict this headshot. Not guaranteed to be valid!
 * @param inflictor		The inflictor which caused this headshot. Guaranteed to be valid.
 * @param attacker		The player who attacked the PNPC. Guaranteed to be valid.
 * @param multiplier	Headshot damage multiplier.
 * @param miniCrit		Set to true to make the headshot mini-crit instead of full-crit. 
 * 						Note that this *will* reduce the multiplier to 45% of its current value if the headshot was not already a mini-crit.
 * 
 * @return	Plugin_Changed if you changed any values, Plugin_Handled or Plugin_Stop to prevent the headshot, or Plugin_Continue to proceed as normal.
 */
forward Action PNPC_OnPNPCHeadshot(PNPC npc, int weapon, int inflictor, int attacker, float &multiplier, bool &miniCrit);

/**
 * Called when a PNPC is damaged.
 * 
 * @param npc			The PNPC.
 * @param damage		The damage dealt.
 * @param weapon		The weapon used.
 * @param inflictor		The entity which inflicted the damage.
 * @param attacker		The entity which attacked the PNPC.
 * @param damagetype	Damage bits.
 * @param damagecustom	Custom damage bits.
 * 
 * @return	Plugin_Changed if you changed any values, Plugin_Handled or Plugin_Stop to prevent the damage, or Plugin_Continue to proceed as normal.
 */
forward Action PNPC_OnPNPCTakeDamage(PNPC npc, float &damage, int weapon, int inflictor, int attacker, int &damagetype, int &damagecustom);

/**
 * Called when a PNPC is killed.
 * 
 * @param npc			The PNPC.
 * @param damage		The damage dealt which killed the PNPC.
 * @param weapon		The weapon used.
 * @param inflictor		The entity which killed the PNPC.
 * @param attacker		The entity which killed the PNPC.
 * @param damagetype	Damage bits.
 * 
 * @return	Plugin_Changed if you changed any values, Plugin_Handled or Plugin_Stop to prevent the PNPC from dying, or Plugin_Continue to proceed as normal.
 */
forward Action PNPC_OnPNPCKilled(PNPC npc, float damage, int weapon, int inflictor, int attacker, int &damagetype);

/**
 * Called when a PNPC is extinguished via the PNPC.Extinguish native.
 * 
 * @param npc			The PNPC.
 * 
 * @return	False to prevent the extinguish, otherwise return true. Note that this value is ignored if the "forced" parameter of PNPC.Extinguish was set to true.
 */
forward bool PNPC_OnPNPCExtinguished(PNPC npc);

/**
 * Called when a PNPC's Mad Milk is removed via the PNPC.RemoveMilk native.
 * 
 * @param npc			The PNPC.
 * @param applicant		The entity which initially applied the Mad Milk.
 * 
 * @return	False to prevent the removal, otherwise return true. Note that this value is ignored if the "forced" parameter of PNPC.RemoveMilk was set to true.
 */
forward bool PNPC_OnPNPCMilkRemoved(PNPC npc, int applicant);

/**
 * Called when a PNPC's Jarate is removed via the PNPC.RemoveJarate native.
 * 
 * @param npc			The PNPC.
 * @param applicant		The entity which initially applied the Jarate.
 * 
 * @return	False to prevent the removal, otherwise return true. Note that this value is ignored if the "forced" parameter of PNPC.RemoveJarate was set to true.
 */
forward bool PNPC_OnPNPCJarateRemoved(PNPC npc, int applicant);

/**
 * Called when a PNPC's Gas Passer gas is removed via the PNPC.RemoveGas native.
 * 
 * @param npc			The PNPC.
 * @param applicant		The entity which initially applied the gas.
 * 
 * @return	False to prevent the removal, otherwise return true. Note that this value is ignored if the "forced" parameter of PNPC.RemoveGas was set to true.
 */
forward bool PNPC_OnPNPCGasRemoved(PNPC npc, int applicant);

/**
 * Called when a PNPC is ignited.
 * 
 * @param npc		The PNPC.
 * @param burnTime	The duration of the burn.
 * @param minBurnTime	If, after applying burnTime to the current afterburn duration, the final afterburn duration would be shorter than this value: set the final afterburn duration to this value.
 * @param maxBurnTime	If, after applying burnTime to the current afterburn duration, the final afterburn duration would be longer than this value: set the final afterburn duration to this value. Does nothing if the afterburn duration is already longer than this.
 * @param attacker	The entity which will be credited for the afterburn damage.
 * @param haunted	If true, the afterburn particle will be set to Spectral Flames instead of the standard team-colored afterburn particle.
 * @param burnDMG	Damage dealt per afterburn tick.
 * 
 * @return 			Plugin_Changed if you changed any values, Plugin_Handled or Plugin_Stop to prevent the afterburn, or Plugin_Continue to do nothing.
 */
forward Action PNPC_OnPNPCIgnited(PNPC npc, float &burnTime, float &minBurnTime, float &maxBurnTime, int &attacker, bool &haunted, float &burnDMG);

/**
 * Called when a PNPC is coated in Mad Milk milk.
 * 
 * @param npc			The PNPC.
 * @param duration		The duration of the effect.
 * @param applicant		The entity responsible for the milking.
 * 
 * @return				Plugin_Changed if you changed any values, Plugin_Handled or Plugin_Stop to prevent the coating, or Plugin_Continue to do nothing.
 */
forward Action PNPC_OnPNPCMilked(PNPC npc, float &duration, int &applicant);

/**
 * Called when a PNPC is coated in Jarate.
 * 
 * @param npc			The PNPC.
 * @param duration		The duration of the effect.
 * @param applicant		The entity responsible for the jarate.
 * 
 * @return				Plugin_Changed if you changed any values, Plugin_Handled or Plugin_Stop to prevent the coating, or Plugin_Continue to do nothing.
 */
forward Action PNPC_OnPNPCJarated(PNPC npc, float &duration, int &applicant);

/**
 * Called when a PNPC is coated in Gas Passer gas.
 * 
 * @param npc			The PNPC.
 * @param duration		The duration of the effect.
 * @param applicant		The entity responsible for the gassing.
 * 
 * @return				Plugin_Changed if you changed any values, Plugin_Handled or Plugin_Stop to prevent the coating, or Plugin_Continue to do nothing.
 */
forward Action PNPC_OnPNPCGassed(PNPC npc, float &duration, int &applicant);

/**
 * Called when bleed is applied to a PNPC.
 * 
 * @param npc		The PNPC.
 * @param bleedTime	The duration of the bleed.
 * @param bleedDMG	The damage the bleed will inflict per tick.
 * @param attacker	The entity which will be credited for the bleed damage.
 * 
 * @return 			Plugin_Changed if you changed any values, Plugin_Handled or Plugin_Stop to prevent the bleed, or Plugin_Continue to do nothing.
 */
forward Action PNPC_OnPNPCBleed(PNPC npc, float &bleedTime, float &bleedDMG, int &attacker);

/**
 * Called when a jar (Mad Milk, Jarate, Gas Passer) collides with something.
 * 
 * @param jar		The jar.
 * @param owner		The entity which owns the jar.
 * @param launcher	The weapon which launched the jar.
 * 
 * @return			Return true to run the Portable NPC System's custom jar logic, otherwise return false to prevent it.
 */
forward bool PNPC_OnPNPCJarCollide(int jar, int owner, int launcher);

/**
 * Called when any default explosive projectile (rocket, grenade, etc) explodes.
 * 
 * @param entity	The projectile.
 * @param owner		The entity which owns the projectile.
 * @param launcher	The weapon which launched the projectile.
 * 
 * @return			Return true to run the Portable NPC System's custom explosion simulation, otherwise return false to prevent it.
 */
forward bool PNPC_OnPNPCProjectileExplode(int rocket, int owner, int launcher);

/**
 * Called when an entity is healed via PNPC_HealEntity.
 * 
 * @param target		The entity being healed.
 * @param amount		The amount of healing to provide.
 * @param maxHeal		The maximum percentage of the target's max health to which this event can heal them. EX: If this is 1.5, then this heal event can provide up to 50% overheal.
 * @param healer		The entity responsible for the healing.
 * 
 * @return	Plugin_Changed if you changed any values, Plugin_Continue to continue with the heal event as normal, Plugin_Stop or Plugin_Handled to prevent the heal.
 */
forward Action PNPC_OnPNPCHeal(int target, int &amount, float &maxHeal, int &healer);

/**
 * Called when a PNPC's health bar is about to be updated and displayed to the world.
 * 
 * @param npc		The PNPC.
 * @param text		The health bar's text.
 * @param r			The R value of the health bar's color.
 * @param g			The G value of the health bar's color.
 * @param b			The B value of the health bar's color.
 * @param a			The alpha value of the health bar's color. 
 * 
 * @return Plugin_Changed if you changed a value, Plugin_Handled/Plugin_Stop to prevent the health bar from being updated (this does not hide the health bar, change PNPC.i_HealthBarDisplay for that), Plugin_Continue to do nothing.
 */
forward Action PNPC_OnHealthBarDisplayed(PNPC npc, char[] text, int &r, int &g, int &b, int &a);

/**
 * Called when a PNPC is created.
 * 
 * @param entity	The PNPC.
 */
forward void PNPC_OnPNPCCreated(int entity);

/**
 * Called when a PNPC is destroyed.
 * 
 * @param entity	The PNPC.
 */
forward void PNPC_OnPNPCDestroyed(int entity);

/**
 * Called when checking whether or not a medigun should be allowed to heal a PNPC.
 * 
 * @param npc		The PNPC.
 * @param client	The player holding the medigun.
 * @param medigun	The medigun.
 * 
 * @return	Return false to prevent the medigun from attaching, otherwise return true.
 */
forward bool PNPC_OnCheckMedigunCanAttach(PNPC npc, int client, int medigun);

/**
 * Called when the Portable NPC System's custom melee logic is about to initiate a melee attack.
 * 
 * @param attacker		The attacker.
 * @param weapon		The weapon used for the attack.
 * @param boundsMult	The amount to multiply the melee attack's bounds.
 * @param rangeMult		The amount to multiply the melee attack's range.
 */
forward void PNPC_OnCustomMeleeLogic(int attacker, int weapon, float &boundsMult, float &rangeMult);

/**
 * Called when the Portable NPC System's custom melee logic found a target and is about to hit them.
 * 
 * @param attacker		The attacker.
 * @param weapon		The weapon used for the attack.
 * @param target		The entity which is about to be hit.
 * @param damage		The melee's base damage.
 * @param crit			Whether or not the attack should crit.
 * @param canStab		Whether or not the attack should be able to backstab.
 * @param forceStab		Set to true to force this attack to be a backstab. Note that this only works if canStab is true. This does not bypass backstab immunity, such as the razorback or backstab immunity attributes.
 * 
 * @return	True to allow the melee hit to go through, false to prevent it.
 */
forward bool PNPC_OnMeleeHit(int attacker, int weapon, int target, float &damage, bool &crit, bool &canStab, bool &forceStab);

/**
 * Called when a player or NPC is backstabbed. Only runs if the Portable NPC System's custom melee hitreg is enabled.
 * 
 * @param attacker		The attacker.
 * @param victim		The entity which was backstabbed.
 * @param damage		The damage the backstab should deal. Can be changed.
 * 
 * @return				True to allow the backstab, false to block it.
 */
forward bool PNPC_OnBackstab(int attacker, int victim, float &damage);

/**
 * Called when a player's ragdoll is created.
 * 
 * @param victim		The player whose ragdoll spawned.
 * @param attacker		The player who killed them.
 * @param inflictor		The entity which killed the victim.
 * @param freeze		Set to true to freeze the ragdoll (Spycicle ice statue effect).
 * @param cloaked		Set to true to make the ragdoll immediately cloak and become invisible (Your Eternal Reward effect).
 * @param ash			Set to true to turn the ragdoll to ash (this is NOT the Cow Mangler effect, I actually have no idea what weapon does this in vanilla TF2, it might be the Mannmelter?)
 * @param gold			Set to true to turn the ragdoll to gold (Saxxy/Golden Wrench effect).
 * @param shocked		Set to true to electrocute the ragdoll (dropped über effect).
 * @param burning		Set to true to light the ragdoll on fire (afterburn effect).
 * @param gib			Set to true to gib the ragdoll.
 */
forward void PNPC_OnPlayerRagdoll(int victim, int attacker, int inflictor, bool &freeze, bool &cloaked, bool &ash, bool &gold, bool &shocked, bool &burning, bool &gib);

/**
 * Checks if a given PNPC has a specified aspect.
 *
 * @param NPC			The PNPC whose aspects to check.
 * @param pluginName	The plugin name of the aspect, as specified in the config as "plugin_name".
 * @param aspectName	The aspect name of the aspect, as specified in the config as "aspect_name".
 *
 * @return True if the NPC's character has the specified aspect, false if not.
 */
native bool PNPC_HasAspect(int NPC, char pluginName[255], char aspectName[255]);

/**
 * Gets an int value from a specified aspect's arg.
 *
 * @param NPC			The PNPC whose aspects to check.
 * @param pluginName	The plugin name of the aspect, as specified in the config as "plugin_name".
 * @param aspectName	The aspect name of the aspect, as specified in the config as "aspect_name".
 * @param argName		The arg to check.
 *
 * @return An int equal to the value obtained from the given aspect's specified arg, -1 if no such value was present.
 */
native int PNPC_GetArgI(int NPC, char pluginName[255], char aspectName[255], char argName[255]);

/**
 * Gets a float value from a specified aspect's arg.
 *
 * @param NPC			The PNPC whose aspects to check.
 * @param pluginName	The plugin name of the aspect, as specified in the config as "plugin_name".
 * @param aspectName	The aspect name of the aspect, as specified in the config as "aspect_name".
 * @param argName		The arg to check.
 *
 * @return A float equal to the value obtained from the given aspect's specified arg, -1.0 if no such value was present.
 */
native float PNPC_GetArgF(int NPC, char pluginName[255], char aspectName[255], char argName[255]);

/**
 * Gets a string value from a specified aspect's arg.
 *
 * @param NPC			The PNPC whose aspects to check.
 * @param pluginName	The plugin name of the aspect, as specified in the config as "plugin_name".
 * @param aspectName	The aspect name of the aspect, as specified in the config as "aspect_name".
 * @param argName		The arg to check.
 * @param buffer		Output buffer.
 * @param size			Size of the output buffer.
 *
 * @return The string obtained from the given aspect's specified arg (empty if the arg was not found), stored in the output buffer.
 */
native PNPC_GetArgS(int NPC, char pluginName[255], char aspectName[255], char argName[255], char output[255], int size);

/**
 * Retrieves the coordinates of the center of the given entity based on its collision hull, stored in the output buffer.
 *
 * @param entity		The entity to get the center of.
 * @param output		Output buffer to store the coordinates in.
 *
 * @return		The coordinates of the entity's center.
 */
native void PNPC_WorldSpaceCenter(int entity, float output[3]);

/**
 * Checks whether or not the given entity is valid and matches a set of given requirements.
 *
 * @param entity		The entity to check.
 * @param team			The team the entity must be on, or TFTeam_Unassigned to ignore teams.
 * @param plugin		Name of the plugin which is calling this native. Only necessary if "filter" is used.
 * @param filter		Optional function for you to add your own extra requirements to. This function must take one int as a parameter, that being the entity's index.
 *
 * @return		True if the entity is both a valid entity and matches the given requirements, false otherwise.
 */
native bool PNPC_IsValidTarget(int entity, TFTeam team, char[] plugin = "", Function filter = INVALID_FUNCTION);

/**
 * Retrieves the entity nearest to the given point, with optional filters so that only certain entities are included.
 *
 * @param pos				The position to search from.
 * @param IncludeEntities	If set to true, this native will cycle through ALL entities instead of just players, which is much more expensive. Only set to true if you absolutely need to.
 * @param distance			Optional return parameter in which the distance from "pos" too the nearest entity will be stored.
 * @param maxDistance		The maximum possible distance an entity can be from "pos" to be counted. <= 0.0: no limit.
 * @param team				The team an entity must be on in order to be counted, or TFTeam_Unassigned to ignore teams.
 * @param plugin			Name of the plugin which is calling this native. Only necessary if "filter" is used.
 * @param filter			Optional function for you to add your own extra requirements to. This function must take one int as a parameter, that being the entity's index, and return a bool.
 *
 * @return		True if the entity is both a valid entity and matches the given requirements, false otherwise.
 */
native int PNPC_GetClosestTarget(float pos[3], bool IncludeEntities = false, float &distance = 0.0, float maxDistance = 0.0, TFTeam team = TFTeam_Unassigned, char[] plugin = "", Function filter = INVALID_FUNCTION);

/**
 * Triggers an instance of area-of-effect damage at the given location. Guaranteed to be compatible with NPCs, as well as the engineer's buildings.
 *
 * @param pos					The location of the explosion.
 * @param radius				The radius of the explosion.
 * @param damage				The base damage of the explosion.
 * @param falloffStartRange		The distance at which radius-based damage falloff begins. If less than 0.0: radius falloff is skipped.
 * @param falloffEndRange		The distance at which radius-based damage falloff reaches its peak.
 * @param falloffMax			The maximum percentage of damage to subtract from the explosion based on radius falloff. IE: 0.25 will subtract up to a maximum of 25% of the damage based on the victim's distance from the center of the explosion.
 * @param inflictor				The entity which will inflict the damage, such as a rocket or a grenade.
 * @param weapon				The weapon which will inflict the damage, such as a rocket launcher or a grenade launcher.
 * @param attacker				The entity which will be credited for the damage, such as a client index.
 * @param damagetype			The damage flags to use.
 * @param skipLOS				If true: line of sight is not required for this explosion to hit its victims.
 * @param ignoreInvuln			If true: the explosion will still hit victims even if they are invulnerable. This does not necessarily mean they will take damage, but it WILL trigger damage events.
 * @param hitAttacker			If true: this explosion can hit the "attacker" entity.
 * @param filterFunction		The function to call to check if a given entity can be hit by this explosion.
 * 								This function must take the following parameters by reference (not including victim): victim (int), attacker (int), inflictor (int), weapon (int), damage (float).
 * 								It must also return a bool (true to allow the victim to be hit, false otherwise).
 * 								EXAMPLE: bool MyFilter(int victim, int &attacker, int &inflictor, int &weapon, float &damage)
 * @param filterPlugin			The name of the plugin which contains filterFunction.
 * @param hitFunction			The function to call when this explosion hits a victim.
 * 								This function must take all of the same parameters as filterFunction, in the same order, and does not need to return a value.
 * 								EXAMPLE: void OnHit(int victim, int &attacker, int &inflictor, int &weapon, float &damage)
 * @param hitPlugin				The name of the plugin which contains hitFunction.
 */
native PNPC_Explosion(float pos[3], float radius, float damage, float falloffStartRange = 0.0, float falloffEndRange = 0.0, float falloffMax = 0.5, int inflictor = 0, 
						int weapon = 0, int attacker = 0, int damagetype = 0, bool skipLOS = false, bool ignoreInvuln = false, bool hitAttacker = true, 
						Function filterFunction = INVALID_FUNCTION, char filterPlugin[255] = "", Function hitFunction = INVALID_FUNCTION, char hitPlugin[255] = "");

/**
 * Checks if a given entity is a PNPC or base_boss.
 * 
 * @param entity	The entity to check.
 * 
 * @return	True if the entity is a PNPC or base_boss, false otherwise.
 */
native bool PNPC_IsNPC(int entity);

/**
 * Heals an entity.
 * 
 * @param entity	The entity to heal.
 * @param amount	The amount of healing to give.
 * @param maxHeal	The maximum percentage of the target entity to which this effect can heal. EX: 1.5 means this effect can provide up to 50% overheal.
 * @param healer	The entity credited for the heal.
 * 
 * @return	True if the heal was successful, false if it was blocked by something.
 */
native bool PNPC_HealEntity(int entity, int amount, float maxHeal = 1.0, int healer = 0);

/**
 * Retrieves an ArrayList of all CNavAreas within a certain radius of a given position.
 * 
 * @param pos		The position.
 * @param radius	The radius in which to grab CNavAreas.
 * 
 * @return	An ArrayList containing all valid CNavAreas within the given radius of pos.
 */
native ArrayList PNPC_GetNearbyNavAreas(float pos[3], float radius);

/**
 * Retrieves a random CNavArea within a given radius of the specified position.
 * 
 * @param pos		The position.
 * @param radius	The radius.
 * 
 * @return A random CNavArea near the given position.
 */
native CNavArea PNPC_GetRandomNearbyArea(float pos[3], float radius);

/**
 * Retrieves the CNavArea closest to the given position.
 * 
 * @param pos		The position.
 * 
 * @return 	The CNavArea closest to the given position.
 */
native CNavArea PNPC_GetClosestNavArea(float pos[3]);

/**
 * Called when an entity touches the PNPC.
 * 
 * @param npc		The PNPC.
 * @param entity	The entity which touched the PNPC.
 * @param classname	The classname of the entity.
 */
forward void PNPC_OnTouch(PNPC npc, int entity, char[] classname);