#if defined _pnpc_included_
  #endinput
#endif
#define _pnpc_included_

/**
 * Checks if a given entity is a PNPC.
 *
 * @param entity		The entity to check.
 *
 * @return True if the entity is a PNPC, false otherwise.
 */
native bool PNPC_IsPNPC(int NPC);

/**
 * Retrieves a given PNPC's team.
 *
 * @param NPC		The PNPC whose team to retrieve.
 *
 * @return The PNPC's team affiliation. Defaults to TFTeam_Unassigned for invalid PNPCs, but this DOES NOT automatically mean all entities which return TFTeam_Unassigned are invalid.
 */
native TFTeam PNPC_GetPNPCTeam(int NPC);

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