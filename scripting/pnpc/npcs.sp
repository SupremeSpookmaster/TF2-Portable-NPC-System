#define NPC_NAME	"pnpc_base_npc"

#define VFX_AFTERBURN_RED		"burningplayer_red"
#define VFX_AFTERBURN_BLUE		"burningplayer_blue"
#define VFX_AFTERBURN_HAUNTED	"halloween_burningplayer_flyingbits"
#define VFX_DEFAULT_BLEED		"blood_impact_red_01_goop"
#define VFX_MILK				"peejar_drips_milk"
#define VFX_JARATE				"peejar_drips"
#define VFX_GAS_RED				"gas_can_drips_red"
#define VFX_GAS_BLUE			"gas_can_drips_blue"

#define PARTICLE_JAR_EXPLODE_MILK			"peejar_impact_milk"
#define PARTICLE_JAR_EXPLODE_JARATE			"peejar_impact"
#define PARTICLE_JAR_EXPLODE_GAS_RED		"gas_can_impact_red"
#define PARTICLE_JAR_EXPLODE_GAS_BLUE		"gas_can_impact_blue"
#define PARTICLE_EXTINGUISH					"doublejump_smoke"
#define PARTICLE_EXPLOSION_GENERIC			"ExplosionCore_MidAir"
#define PARTICLE_EXPLOSION_FIREBALL_RED		"spell_fireball_tendril_parent_red"
#define PARTICLE_EXPLOSION_FIREBALL_BLUE	"spell_fireball_tendril_parent_blue"
#define PARTICLE_EXPLOSION_FLARE_RED		"ExplosionCore_MidAir_Flare"
#define PARTICLE_EXPLOSION_FLARE_BLUE		"ExplosionCore_MidAir_Flare"

#define SND_SANDMAN_HIT			")player/pl_impact_stun.wav"
#define SND_CLEAVER_HIT			")weapons/cleaver_hit_03.wav"
#define SND_JAR_EXPLODE			")weapons/jar_explode.wav"
#define SND_GAS_EXPLODE			")weapons/gas_can_explode.wav"
#define SND_EXTINGUISH			")player/flame_out.wav"
#define SND_EXPLOSION_FLARE		")weapons/flare_detonator_explode.wav"
#define SND_EXPLOSION_GENERIC_1	")weapons/explode1.wav"
#define SND_EXPLOSION_GENERIC_2	")weapons/explode2.wav"
#define SND_EXPLOSION_GENERIC_3	")weapons/explode3.wav"
#define SND_EXPLOSION_FIREBALL	")misc/halloween/spell_fireball_impact.wav"

static char SFX_GenericExplosion[][] = {
	SND_EXPLOSION_GENERIC_1,
	SND_EXPLOSION_GENERIC_2,
	SND_EXPLOSION_GENERIC_3
};

static char Gibs_Scout_Models[][] = {
	"models/player/gibs/scoutgib001.mdl",
	"models/player/gibs/scoutgib002.mdl",
	"models/player/gibs/scoutgib003.mdl",
	"models/player/gibs/scoutgib004.mdl",
	"models/player/gibs/scoutgib005.mdl",
	"models/player/gibs/scoutgib006.mdl",
	"models/player/gibs/scoutgib007.mdl",
	"models/player/gibs/scoutgib008.mdl",
	"models/player/gibs/scoutgib009.mdl",
};

static char Gibs_Scout_Attachments[][] = {
	"foot_R",
	"foot_L",
	"back_lower",
	"effect_hand_L",
	"effect_hand_R",
	"back_upper",
	"head",
	"partyhat",
	"partyhat"
};

static char Gibs_Soldier_Models[][] = {
	"models/player/gibs/soldiergib001.mdl",
	"models/player/gibs/soldiergib002.mdl",
	"models/player/gibs/soldiergib003.mdl",
	"models/player/gibs/soldiergib004.mdl",
	"models/player/gibs/soldiergib006.mdl",
	"models/player/gibs/soldiergib007.mdl",
	"models/player/gibs/soldiergib008.mdl"
};

static char Gibs_Soldier_Attachments[][] = {
	"foot_R",
	"foot_L",
	"effect_hand_R",
	"prop_bone",
	"flag",
	"head",
	"partyhat"
};

static char Gibs_Pyro_Models[][] = {
	"models/player/gibs/pyrogib001.mdl",
	"models/player/gibs/pyrogib002.mdl",
	"models/player/gibs/pyrogib003.mdl",
	"models/player/gibs/pyrogib004.mdl",
	"models/player/gibs/pyrogib007.mdl",
	"models/player/gibs/pyrogib008.mdl"
};

static char Gibs_Pyro_Attachments[][] = {
	"foot_L",
	"foot_R",
	"effect_hand_L",
	"effect_hand_R",
	"flag",
	"head"
};

static char Gibs_Demo_Models[][] = {
	"models/player/gibs/demogib001.mdl",
	"models/player/gibs/demogib002.mdl",
	"models/player/gibs/demogib003.mdl",
	"models/player/gibs/demogib004.mdl",
	"models/player/gibs/demogib005.mdl",
	"models/player/gibs/demogib006.mdl"
};

static char Gibs_Demo_Attachments[][] = {
	"foot_L",
	"foot_R",
	"effect_hand_L",
	"effect_hand_R",
	"flag",
	"head"
};

static char Gibs_Heavy_Models[][] = {
	"models/player/gibs/heavygib001.mdl",
	"models/player/gibs/heavygib002.mdl",
	"models/player/gibs/heavygib004.mdl",
	"models/player/gibs/heavygib005.mdl",
	"models/player/gibs/heavygib006.mdl",
	"models/player/gibs/heavygib007.mdl"
};

static char Gibs_Heavy_Attachments[][] = {
	"foot_R",
	"foot_L",
	"back_lower",
	"effect_hand_R",
	"flag",
	"head"
};

static char Gibs_Engineer_Models[][] = {
	"models/player/gibs/engineergib001.mdl",
	"models/player/gibs/engineergib002.mdl",
	"models/player/gibs/engineergib003.mdl",
	"models/player/gibs/engineergib005.mdl",
	"models/player/gibs/engineergib006.mdl",
	"models/player/gibs/engineergib007.mdl"
};

static char Gibs_Engineer_Attachments[][] = {
	"foot_L",
	"back_lower",
	"effect_hand_R",
	"flag",
	"head",
	"partyhat"
};

static char Gibs_Medic_Models[][] = {
	"models/player/gibs/medicgib001.mdl",
	"models/player/gibs/medicgib002.mdl",
	"models/player/gibs/medicgib003.mdl",
	"models/player/gibs/medicgib004.mdl",
	"models/player/gibs/medicgib005.mdl",
	"models/player/gibs/medicgib006.mdl",
	"models/player/gibs/medicgib007.mdl",
	"models/player/gibs/medicgib008.mdl"
};

static char Gibs_Medic_Attachments[][] = {
	"foot_R",
	"foot_L",
	"back_lower",
	"effect_hand_L",
	"effect_hand_R",
	"flag",
	"head",
	"eyes"
};

static char Gibs_Sniper_Models[][] = {
	"models/player/gibs/snipergib001.mdl",
	"models/player/gibs/snipergib002.mdl",
	"models/player/gibs/snipergib003.mdl",
	"models/player/gibs/snipergib004.mdl",
	"models/player/gibs/snipergib005.mdl",
	"models/player/gibs/snipergib006.mdl",
	"models/player/gibs/snipergib007.mdl"
};

static char Gibs_Sniper_Attachments[][] = {
	"foot_L",
	"foot_R",
	"effect_hand_L",
	"flag",
	"head",
	"eyes",
	"partyhat"
};

static char Gibs_Spy_Models[][] = {
	"models/player/gibs/spygib001.mdl",
	"models/player/gibs/spygib002.mdl",
	"models/player/gibs/spygib003.mdl",
	"models/player/gibs/spygib004.mdl",
	"models/player/gibs/spygib006.mdl",
	"models/player/gibs/spygib007.mdl"
};

static char Gibs_Spy_Attachments[][] = {
	"foot_R",
	"foot_L",
	"effect_hand_R",
	"effect_hand_L",
	"flag",
	"head"
};

static float DEFAULT_MINS[3] = { -24.0, -24.0, 0.0 };
static float DEFAULT_MAXS[3] = { 24.0, 24.0, 82.0 };

Function PNPC_Logic[2049] = { INVALID_FUNCTION, ... };
Handle PNPC_LogicPlugin[2049] = { null, ... };

int i_TotalNPCs[2049] = { -1, ... };
int i_AfterburnAttacker[2049] = { -1, ... };
int i_BleedStacks[2049] = { 0, ... };
int i_Milker[2049] = { -1, ... };
int i_Jarater[2049] = { -1, ... };
int i_Gasser[2049] = { -1, ... };
int i_PillCollideTarget[2049] = { -1, ... };
int i_PathTarget[2049] = { -1, ... };

float PNPC_Speed[2049] = { 0.0, ... };
float PNPC_ThinkRate[2049] = { 0.0, ... };
float PNPC_NextThinkTime[2049] = { 0.0, ... };
float PNPC_EndTime[2049] = { 0.0, ... };
float f_AfterburnEndTime[2049] = { 0.0, ... };
float f_AfterburnDMG[2049] = { 0.0, ... };
float f_NextBurn[2049] = { 0.0, ... };
float f_NextFlinch[2049] = { 0.0, ... };
float f_MilkEndTime[2049] = { 0.0, ... };
float f_JarateEndTime[2049] = { 0.0, ... };
float f_GasEndTime[2049] = { 0.0, ... };
float f_PunchForce[2049][3];

bool b_IsInUpdateGroundConstraint = false;
bool IExist[2049] = { false, ... };
bool ForcedToGib[2049] = { false, ... };
bool b_AfterburnHaunted[2049] = { false, ... };
bool b_MiniCrit[2049] = { false, ... };
bool I_AM_DEAD[2049] = { false, ... };
bool b_PillAlreadyBounced[2049] = { false, ... };
bool b_IsProjectile[2049] = { false, ... };

char PNPC_Model[2049][255];
char PNPC_BleedParticle[2049][255];
char PNPC_FlinchSequence[2049][255];

char PNPC_ConfigName[2049][255];
char PNPC_Name[2049][255];

GlobalForward g_OnPNPCCreated;
GlobalForward g_OnPNPCDestroyed;
GlobalForward g_OnPNPCHeadshot;
GlobalForward g_OnPNPCDamaged;
GlobalForward g_OnPNPCKilled;
GlobalForward g_OnPNPCExtinguished;
GlobalForward g_OnPNPCIgnited;
GlobalForward g_OnPNPCBleed;
GlobalForward g_OnPNPCMilkRemoved;
GlobalForward g_OnPNPCJarateRemoved;
GlobalForward g_OnPNPCGasRemoved;
GlobalForward g_OnPNPCMilked;
GlobalForward g_OnPNPCJarated;
GlobalForward g_OnPNPCGassed;
GlobalForward g_OnJarCollide;
GlobalForward g_OnProjectileExplode;
GlobalForward g_OnHeal;

Handle g_hLookupActivity;
Handle SDK_Ragdoll;

PathFollower g_PathFollowers[2049];

ArrayList g_Gibs[2049];
ArrayList g_GibAttachments[2049];
ArrayList g_AttachedModels[2049];
ArrayList g_AttachedWeaponModels[2049];

DynamicHook g_DHookGrenadeExplode;
DynamicHook g_DHookStickyExplode;
DynamicHook g_DHookFireballExplode;
DynamicHook g_DHookRocketExplode;

Handle g_DHookPillCollide;
Handle g_hSDKWorldSpaceCenter;
//DynamicHook g_DHookFlareExplode;

enum //hitgroup_t
{
	HITGROUP_GENERIC,
	HITGROUP_HEAD,
	HITGROUP_CHEST,
	HITGROUP_STOMACH,
	HITGROUP_LEFTARM,
	HITGROUP_RIGHTARM,
	HITGROUP_LEFTLEG,
	HITGROUP_RIGHTLEG,
	
	NUM_HITGROUPS
};

void PNPC_MapStart()
{
	for (int i = MaxClients + 1; i < 2049; i++)
		g_PathFollowers[i] = PathFollower(PNPC_PathCost, Path_FilterIgnoreActors, Path_FilterOnlyActors);

	PrecacheParticleEffect(VFX_AFTERBURN_RED);
	PrecacheParticleEffect(VFX_AFTERBURN_BLUE);
	PrecacheParticleEffect(VFX_AFTERBURN_HAUNTED);
	PrecacheParticleEffect(VFX_DEFAULT_BLEED);
	PrecacheParticleEffect(VFX_MILK);
	PrecacheParticleEffect(VFX_JARATE);
	PrecacheParticleEffect(VFX_GAS_RED);
	PrecacheParticleEffect(VFX_GAS_BLUE);

	PrecacheEffect("ParticleEffect");
	PrecacheEffect("ParticleEffectStop");

	PrecacheSound(SND_SANDMAN_HIT);
	PrecacheSound(SND_CLEAVER_HIT);
	PrecacheSound(SND_JAR_EXPLODE);
	PrecacheSound(SND_GAS_EXPLODE);
	PrecacheSound(SND_EXTINGUISH);
	PrecacheSound(SND_EXPLOSION_FLARE);
	PrecacheSound(SND_EXPLOSION_GENERIC_1);
	PrecacheSound(SND_EXPLOSION_GENERIC_2);
	PrecacheSound(SND_EXPLOSION_GENERIC_3);
	PrecacheSound(SND_EXPLOSION_FIREBALL);

	for (int i = 0; i < sizeof(Gibs_Scout_Models); i++)
		PrecacheModel(Gibs_Scout_Models[i]);

	for (int i = 0; i < sizeof(Gibs_Soldier_Models); i++)
		PrecacheModel(Gibs_Soldier_Models[i]);

	for (int i = 0; i < sizeof(Gibs_Pyro_Models); i++)
		PrecacheModel(Gibs_Pyro_Models[i]);

	for (int i = 0; i < sizeof(Gibs_Demo_Models); i++)
		PrecacheModel(Gibs_Demo_Models[i]);
	
	for (int i = 0; i < sizeof(Gibs_Heavy_Models); i++)
		PrecacheModel(Gibs_Heavy_Models[i]);

	for (int i = 0; i < sizeof(Gibs_Engineer_Models); i++)
		PrecacheModel(Gibs_Engineer_Models[i]);

	for (int i = 0; i < sizeof(Gibs_Medic_Models); i++)
		PrecacheModel(Gibs_Medic_Models[i]);

	for (int i = 0; i < sizeof(Gibs_Sniper_Models); i++)
		PrecacheModel(Gibs_Sniper_Models[i]);
	
	for (int i = 0; i < sizeof(Gibs_Spy_Models); i++)
		PrecacheModel(Gibs_Spy_Models[i]);
}

void PNPC_MapEnd()
{
	for (int i = MaxClients + 1; i < 2049; i++)
	{
		if (g_PathFollowers[i].IsValid())
			g_PathFollowers[i].Destroy();

		delete g_Gibs[i];
		delete g_GibAttachments[i];
		delete g_AttachedModels[i];
		delete g_AttachedWeaponModels[i];
	}
}

public float PNPC_PathCost(INextBot bot, CNavArea area, CNavArea from_area, CNavLadder ladder, int iElevator, float length)
{
	float dist;
	if (length != 0.0) 
	{
		dist = length;
	}
	else 
	{
		float vecCenter[3], vecFromCenter[3];
		area.GetCenter(vecCenter);
		from_area.GetCenter(vecFromCenter);
		
		float vecSubtracted[3];
		SubtractVectors(vecCenter, vecFromCenter, vecSubtracted);
		
		dist = GetVectorLength(vecSubtracted);
	}
	
	float cost = dist * ((1.0 + (GetRandomFloat(0.0, 1.0)) + 1.0) * 25.0);
	
	return from_area.GetCostSoFar() + cost;
}

void PNPC_MakeForwards()
{
	g_OnPNPCCreated = new GlobalForward("PNPC_OnPNPCCreated", ET_Ignore, Param_Cell);
	g_OnPNPCDestroyed = new GlobalForward("PNPC_OnPNPCDestroyed", ET_Ignore, Param_Cell);
	g_OnPNPCHeadshot = new GlobalForward("PNPC_OnPNPCHeadshot", ET_Event, Param_Any, Param_Cell, Param_Cell, Param_Cell, Param_FloatByRef, Param_CellByRef);
	g_OnPNPCDamaged = new GlobalForward("PNPC_OnPNPCTakeDamage", ET_Event, Param_Any, Param_FloatByRef, Param_Cell, Param_Cell, Param_Cell, Param_CellByRef, Param_CellByRef);
	g_OnPNPCKilled = new GlobalForward("PNPC_OnPNPCKilled", ET_Event, Param_Any, Param_Float, Param_Cell, Param_Cell, Param_Cell, Param_CellByRef);
	g_OnPNPCExtinguished = new GlobalForward("PNPC_OnPNPCExtinguished", ET_Single, Param_Any);
	g_OnPNPCIgnited = new GlobalForward("PNPC_OnPNPCIgnited", ET_Event, Param_Any, Param_FloatByRef, Param_FloatByRef, Param_FloatByRef, Param_CellByRef, Param_CellByRef, Param_FloatByRef);
	g_OnPNPCBleed = new GlobalForward("PNPC_OnPNPCBleed", ET_Event, Param_Any, Param_FloatByRef, Param_FloatByRef, Param_CellByRef);
	g_OnPNPCMilkRemoved = new GlobalForward("PNPC_OnPNPCMilkRemoved", ET_Single, Param_Cell, Param_Cell);
	g_OnPNPCJarateRemoved = new GlobalForward("PNPC_OnPNPCJarateRemoved", ET_Single, Param_Cell, Param_Cell);
	g_OnPNPCGasRemoved = new GlobalForward("PNPC_OnPNPCGasRemoved", ET_Single, Param_Cell, Param_Cell);
	g_OnPNPCMilked = new GlobalForward("PNPC_OnPNPCMilked", ET_Event, Param_Cell, Param_FloatByRef, Param_CellByRef);
	g_OnPNPCJarated = new GlobalForward("PNPC_OnPNPCJarated", ET_Event, Param_Cell, Param_FloatByRef, Param_CellByRef);
	g_OnPNPCGassed = new GlobalForward("PNPC_OnPNPCGassed", ET_Event, Param_Cell, Param_FloatByRef, Param_CellByRef);
	g_OnJarCollide = new GlobalForward("PNPC_OnPNPCJarCollide", ET_Single, Param_Cell, Param_Cell, Param_Cell);
	g_OnProjectileExplode = new GlobalForward("PNPC_OnPNPCProjectileExplode", ET_Single, Param_Cell, Param_Cell, Param_Cell);
	g_OnHeal = new GlobalForward("PNPC_OnPNPCHeal", ET_Event, Param_Cell, Param_CellByRef, Param_FloatByRef, Param_CellByRef);

	/*NextBotActionFactory AcFac = new NextBotActionFactory("PNPCMainAction");
	AcFac.SetEventCallback(EventResponderType_OnActorEmoted, PluginBot_OnActorEmoted);*/

	CEntityFactory PNPC_Factory = new CEntityFactory(NPC_NAME, PNPC_OnCreate, PNPC_OnDestroy);
	PNPC_Factory.DeriveFromNPC();
	//PNPC_Factory.SetInitialActionFactory(AcFac);
	PNPC_Factory.BeginDataMapDesc().DefineIntField("pnpc_pPath").EndDataMapDesc();
	PNPC_Factory.Install();

	GameData gd = LoadGameConfigFile("portable_npc_system");

	//LookupActivity:
	StartPrepSDKCall(SDKCall_Static);
	PrepSDKCall_SetFromConf(gd, SDKConf_Signature, "LookupActivity");
	PrepSDKCall_AddParameter(SDKType_PlainOldData, SDKPass_Plain);	//pStudioHdr
	PrepSDKCall_AddParameter(SDKType_String, SDKPass_Pointer);		//label
	PrepSDKCall_SetReturnInfo(SDKType_PlainOldData, SDKPass_Plain);	//return index
	if((g_hLookupActivity = EndPrepSDKCall()) == INVALID_HANDLE) SetFailState("Failed to create Call for LookupActivity.");

	StartPrepSDKCall(SDKCall_Entity);
	PrepSDKCall_SetFromConf(gd, SDKConf_Virtual, "CBaseAnimating::BecomeRagdollOnClient");
	PrepSDKCall_AddParameter(SDKType_Vector, SDKPass_ByRef);
	SDK_Ragdoll = EndPrepSDKCall();
	if(!SDK_Ragdoll)
		LogError("[Gamedata] Could not find CBaseAnimating::BecomeRagdollOnClient");

	g_DHookGrenadeExplode = DHook_CreateVirtual(gd, "CBaseGrenade::Explode");
	g_DHookStickyExplode = DHook_CreateVirtual(gd, "CBaseGrenade::Detonate");
	g_DHookFireballExplode = DHook_CreateVirtual(gd, "CTFProjectile_SpellFireball::Explode");
	g_DHookRocketExplode = DHook_CreateVirtual(gd, "CTFBaseRocket::Explode");

	DHook_CreateDetour(gd, "JarExplode()", PNPC_OnJarExplodePre);
	DHook_CreateDetour(gd, "CTFProjectile_Flare::Explode_Air()", PNPC_OnFlareExplodePre);
	DHook_CreateDetour(gd, "NextBotGroundLocomotion::UpdateGroundConstraint", PNPC_UpdateGroundConstraint_Pre, PNPC_UpdateGroundConstraint_Post);

	g_DHookPillCollide = CheckedDHookCreateFromConf(gd, "CTFGrenadePipebombProjectile::PipebombTouch");

	//WorldSpaceCenter:
	StartPrepSDKCall(SDKCall_Entity);
	PrepSDKCall_SetFromConf(gd, SDKConf_Virtual, "CBaseEntity::WorldSpaceCenter");
	PrepSDKCall_SetReturnInfo(SDKType_Vector, SDKPass_ByRef);
	if ((g_hSDKWorldSpaceCenter = EndPrepSDKCall()) == null) SetFailState("Failed to create SDKCall for CBaseEntity::WorldSpaceCenter offset!");

	delete gd;
}

public MRESReturn PNPC_UpdateGroundConstraint_Pre(DHookParam param)
{
	b_IsInUpdateGroundConstraint = true;
	return MRES_Ignored;
}

public MRESReturn PNPC_UpdateGroundConstraint_Post(DHookParam param)
{
	b_IsInUpdateGroundConstraint = false;
	return MRES_Ignored;
}

void PNPC_MakeNatives()
{
	//Constructors:
	CreateNative("PNPC.PNPC", Native_PNPCConstructor);

	//Index:
	CreateNative("PNPC.Index.get", Native_PNPCGetIndex);

	//Logic and LogicPlugin:
	CreateNative("PNPC.g_Logic.set", Native_PNPCSetLogic);
	CreateNative("PNPC.g_LogicPlugin.get", Native_PNPCGetLogicPlugin);
	CreateNative("PNPC.g_LogicPlugin.set", Native_PNPCSetLogicPlugin);

	//Team:
	CreateNative("PNPC.i_Team.set", Native_PNPCSetTeam);
	CreateNative("PNPC.i_Team.get", Native_PNPCGetTeam);

	//Skin:
	CreateNative("PNPC.i_Skin.set", Native_PNPCSetSkin);
	CreateNative("PNPC.i_Skin.get", Native_PNPCGetSkin);

	//Scale:
	CreateNative("PNPC.f_Scale.set", Native_PNPCSetScale);
	CreateNative("PNPC.f_Scale.get", Native_PNPCGetScale);
	CreateNative("PNPC.SetBoundingBox", Native_PNPCSetBoundingBox);

	//Speed:
	CreateNative("PNPC.f_Speed.set", Native_PNPCSetSpeed);
	CreateNative("PNPC.f_Speed.get", Native_PNPCGetSpeed);
	CreateNative("PNPC.f_MaxSpeed.set", Native_PNPCSetMaxSpeed);
	CreateNative("PNPC.f_MaxSpeed.get", Native_PNPCGetMaxSpeed);

	//Think Rate and Next Think Time:
	CreateNative("PNPC.f_ThinkRate.set", Native_PNPCSetThinkRate);
	CreateNative("PNPC.f_ThinkRate.get", Native_PNPCGetThinkRate);
	CreateNative("PNPC.f_NextThinkTime.set", Native_PNPCSetNextThinkTime);
	CreateNative("PNPC.f_NextThinkTime.get", Native_PNPCGetNextThinkTime);

	//End Time:
	CreateNative("PNPC.f_EndTime.set", Native_PNPCSetEndTime);
	CreateNative("PNPC.f_EndTime.get", Native_PNPCGetEndTime);

	//Model:
	CreateNative("PNPC.SetModel", Native_PNPCSetModel);
	CreateNative("PNPC.GetModel", Native_PNPCGetModel);

	//Health and Max Health:
	CreateNative("PNPC.i_Health.set", Native_PNPCSetHealth);
	CreateNative("PNPC.i_Health.get", Native_PNPCGetHealth);
	CreateNative("PNPC.i_MaxHealth.set", Native_PNPCSetMaxHealth);
	CreateNative("PNPC.i_MaxHealth.get", Native_PNPCGetMaxHealth);

	//Exists:
	CreateNative("PNPC.b_Exists.set", Native_PNPCSetExists);
	CreateNative("PNPC.b_Exists.get", Native_PNPCGetExists);

	//Locomotion:
	CreateNative("PNPC.GetLocomotion", Native_PNPCGetLocomotion);
	CreateNative("PNPC.GetGroundMotionVector", Native_PNPCGetGroundMotionVector);

	//CBaseNPC:
	CreateNative("PNPC.GetBaseNPC", Native_PNPCGetBaseNPC);

	//INextBot:
	CreateNative("PNPC.GetBot", Native_PNPCGetBot);

	//Sequences, Activities, Pose Parameters, and Gestures:
	CreateNative("PNPC.SetSequence", Native_PNPCSetSequence);
	CreateNative("PNPC.LookupActivity", Native_PNPCLookupActivity);
	CreateNative("PNPC.SetActivity", Native_PNPCSetActivity);
	CreateNative("PNPC.SetCycle", Native_PNPCSetCycle);
	CreateNative("PNPC.SetPlaybackRate", Native_PNPCSetPlaybackRate);
	CreateNative("PNPC.AddGesture", Native_PNPCAddGesture);
	CreateNative("PNPC.RemoveGesture", Native_PNPCRemoveGesture);
	CreateNative("PNPC.i_PoseMoveX.get", Native_PNPCGetPoseMoveX);
	CreateNative("PNPC.i_PoseMoveY.get", Native_PNPCGetPoseMoveY);

	//Pathing and Movement:
	CreateNative("PNPC.GetPathFollower", Native_PNPCGetPathFollower);
	CreateNative("PNPC.StartPathing", Native_PNPCStartPathing);
	CreateNative("PNPC.StopPathing", Native_PNPCStopPathing);
	CreateNative("PNPC.SetGoalVector", Native_PNPCSetGoalVector);
	CreateNative("PNPC.SetGoalEntity", Native_PNPCSetGoalEntity);
	CreateNative("PNPC.GetGroundSpeed", Native_PNPCGetGroundSpeed);
	CreateNative("PNPC.ApplyTemporarySpeedChange", Native_PNPCModifySpeed);
	CreateNative("PNPC.i_PathTarget.get", Native_PNPCGetPathTarget);
	CreateNative("PNPC.i_PathTarget.set", Native_PNPCSetPathTarget);

	//CBaseNPC Base Values:
	CreateNative("PNPC.f_YawRate.get", Native_PNPCGetYawRate);
	CreateNative("PNPC.f_YawRate.set", Native_PNPCSetYawRate);
	CreateNative("PNPC.f_StepSize.get", Native_PNPCGetStepSize);
	CreateNative("PNPC.f_StepSize.set", Native_PNPCSetStepSize);
	CreateNative("PNPC.f_Gravity.get", Native_PNPCGetGravity);
	CreateNative("PNPC.f_Gravity.set", Native_PNPCSetGravity);
	CreateNative("PNPC.f_Acceleration.get", Native_PNPCGetAcceleration);
	CreateNative("PNPC.f_Acceleration.set", Native_PNPCSetAcceleration);
	CreateNative("PNPC.f_JumpHeight.get", Native_PNPCGetJumpHeight);
	CreateNative("PNPC.f_JumpHeight.set", Native_PNPCSetJumpHeight);
	CreateNative("PNPC.f_FrictionSideways.get", Native_PNPCGetFrictionSideways);
	CreateNative("PNPC.f_FrictionSideways.set", Native_PNPCSetFrictionSideways);
	CreateNative("PNPC.f_FrictionForwards.get", Native_PNPCGetFrictionForwards);
	CreateNative("PNPC.f_FrictionForwards.set", Native_PNPCSetFrictionForwards);
	CreateNative("PNPC.f_DeathDropHeight.get", Native_PNPCGetDeathDropHeight);
	CreateNative("PNPC.f_DeathDropHeight.set", Native_PNPCSetDeathDropHeight);

	//Gibs and Ragdolls:
	CreateNative("PNPC.Ragdoll", Native_PNPCRagdoll);
	CreateNative("PNPC.PunchForce", Native_PNPCPunchForce);
	CreateNative("PNPC.Gib", Native_PNPCGib);
	CreateNative("PNPC.AddGib", Native_PNPCAddGib);
	CreateNative("PNPC.b_GibsForced.get", Native_PNPCGetForcedGib);
	CreateNative("PNPC.b_GibsForced.set", Native_PNPCSetForcedGib);
	CreateNative("PNPC.SetGibsFromConfig", Native_PNPCSetGibsFromConfig);
	CreateNative("PNPC.ClearGibs", Native_PNPCClearGibs);

	//Damage VFX:
	CreateNative("PNPC.SetBleedParticle", Native_PNPCSetBleedEffect);
	CreateNative("PNPC.GetBleedParticle", Native_PNPCGetBleedEffect);
	CreateNative("PNPC.SetFlinchSequence", Native_PNPCSetFlinchSequence);
	CreateNative("PNPC.GetFlinchSequence", Native_PNPCGetFlinchSequence);
	CreateNative("PNPC.SetDamagedVFX", Native_PNPCSetDamageVFX);

	//Attachments:
	CreateNative("PNPC.AttachModel", Native_PNPCAttachModel);
	CreateNative("PNPC.g_AttachedCosmetics.get", Native_PNPCGetAttachedCosmetics);
	CreateNative("PNPC.g_AttachedCosmetics.set", Native_PNPCSetAttachedCosmetics);
	CreateNative("PNPC.g_AttachedWeapons.get", Native_PNPCGetAttachedWeapons);
	CreateNative("PNPC.g_AttachedWeapons.set", Native_PNPCSetAttachedWeapons);
	CreateNative("PNPC.RemoveAttachments", Native_PNPCRemoveAttachments);
	CreateNative("PNPC.SetParticlesFromConfig", Native_PNPCSetParticlesFromConfig);
	CreateNative("PNPC.SetAttachmentsFromConfig", Native_PNPCSetAttachmentsFromConfig);

	//Afterburn:
	CreateNative("PNPC.b_Burning.get", Native_PNPCGetBurning);
	CreateNative("PNPC.f_AfterburnEndTime.get", Native_PNPCGetAfterburnEndTime);
	CreateNative("PNPC.f_AfterburnEndTime.set", Native_PNPCSetAfterburnEndTime);
	CreateNative("PNPC.f_AfterburnDMG.get", Native_PNPCGetAfterburnDMG);
	CreateNative("PNPC.f_AfterburnDMG.set", Native_PNPCSetAfterburnDMG);
	CreateNative("PNPC.i_AfterburnAttacker.get", Native_PNPCGetAfterburnAttacker);
	CreateNative("PNPC.i_AfterburnAttacker.set", Native_PNPCSetAfterburnAttacker);
	CreateNative("PNPC.b_AfterburnIsHaunted.get", Native_PNPCGetAfterburnHaunted);
	CreateNative("PNPC.b_AfterburnIsHaunted.set", Native_PNPCSetAfterburnHaunted);
	CreateNative("PNPC.Ignite", Native_PNPCIgnite);
	CreateNative("PNPC.Extinguish", Native_PNPCExtinguish);

	//Milk:
	CreateNative("PNPC.b_Milked.get", Native_PNPCGetMilked);
	CreateNative("PNPC.f_MilkEndTime.get", Native_PNPCGetMilkEndTime);
	CreateNative("PNPC.f_MilkEndTime.set", Native_PNPCSetMilkEndTime);
	CreateNative("PNPC.i_Milker.get", Native_PNPCGetMilker);
	CreateNative("PNPC.i_Milker.set", Native_PNPCSetMilker);
	CreateNative("PNPC.ApplyMilk", Native_PNPCApplyMilk);
	CreateNative("PNPC.RemoveMilk", Native_PNPCRemoveMilk);

	//Jarate:
	CreateNative("PNPC.b_Jarated.get", Native_PNPCGetJarated);
	CreateNative("PNPC.f_JarateEndTime.get", Native_PNPCGetJarateEndTime);
	CreateNative("PNPC.f_JarateEndTime.set", Native_PNPCSetJarateEndTime);
	CreateNative("PNPC.i_JarateApplicant.get", Native_PNPCGetJarateApplicant);
	CreateNative("PNPC.i_JarateApplicant.set", Native_PNPCSetJarateApplicant);
	CreateNative("PNPC.ApplyJarate", Native_PNPCApplyJarate);
	CreateNative("PNPC.RemoveJarate", Native_PNPCRemoveJarate);

	//Gas:
	CreateNative("PNPC.b_Gassed.get", Native_PNPCGetGassed);
	CreateNative("PNPC.f_GasEndTime.get", Native_PNPCGetGasEndTime);
	CreateNative("PNPC.f_GasEndTime.set", Native_PNPCSetGasEndTime);
	CreateNative("PNPC.i_GasApplicant.get", Native_PNPCGetGasApplicant);
	CreateNative("PNPC.i_GasApplicant.set", Native_PNPCSetGasApplicant);
	CreateNative("PNPC.ApplyGas", Native_PNPCApplyGas);
	CreateNative("PNPC.RemoveGas", Native_PNPCRemoveGas);

	//Bleed:
	CreateNative("PNPC.Bleed", Native_PNPCBleed);
	CreateNative("PNPC.b_Bleeding.get", Native_PNPCGetBleeding);

	//Sound:
	CreateNative("PNPC.PlayRandomSound", Native_PNPC_PlayRandomSound);

	//Config:
	CreateNative("PNPC.GetConfigName", Native_PNPC_GetConfigName);
	CreateNative("PNPC.SetConfigName", Native_PNPC_SetConfigName);
	CreateNative("PNPC.GetConfigMap", Native_PNPC_GetConfigMap);
	CreateNative("PNPC.HasAspect", Native_PNPC_HasAspect);
	CreateNative("PNPC.GetArgI", Native_PNPC_GetArgI);
	CreateNative("PNPC.GetArgF", Native_PNPC_GetArgF);
	CreateNative("PNPC.GetArgS", Native_PNPC_GetArgS);

	//Name:
	CreateNative("PNPC.GetName", Native_PNPC_GetName);
	CreateNative("PNPC.SetName", Native_PNPC_SetName);

	//Global (not specific to the PNPC methodmap) Natives:
	CreateNative("PNPC_Explosion", Native_PNPCExplosion);
	CreateNative("PNPC_IsNPC", Native_PNPCIsThisAnNPC);
	CreateNative("PNPC_HealEntity", Native_PNPCHealEntity);
	CreateNative("PNPC_IsValidTarget", Native_PNPC_IsValidTarget);
	CreateNative("PNPC_WorldSpaceCenter", Native_PNPC_WorldSpaceCenter);
	CreateNative("PNPC_GetClosestTarget", Native_PNPC_GetClosestTarget);
}

public any Native_PNPC_HasAspect(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	ConfigMap conf = npc.GetConfigMap();
	if (conf == null)
		return false;

	char aspect[255], pluginName[255];
	GetNativeString(2, aspect, sizeof(aspect));
	GetNativeString(3, pluginName, sizeof(pluginName));

	ConfigMap aspects = conf.GetSection("npc.aspects");
	if (aspects == null)
	{
		DeleteCfg(conf);
		return false;
	}

	bool success = false;
	char name[255];
	int slot = 1;
	Format(name, sizeof(name), "aspect_%i", slot);
	ConfigMap specificAspect = aspects.GetSection(name);
	while (specificAspect != null && !success)
	{
		char thisAspect[255], thisPlugin[255];
		specificAspect.Get("aspect_name", thisAspect, sizeof(thisAspect));
		specificAspect.Get("plugin_name", thisPlugin, sizeof(thisPlugin));
		if (StrEqual(thisAspect, aspect) && StrEqual(thisPlugin, pluginName))
		{
			char fullPath[255];
			Format(fullPath, sizeof(fullPath), "npc.aspects.%s", name);
			SetNativeString(4, fullPath, GetNativeCell(5));
			success = true;
		}

		slot++;
		Format(name, sizeof(name), "aspect_%i", slot);
		specificAspect = aspects.GetSection(name)
	}

	DeleteCfg(conf);
	return success;
}

public int Native_PNPC_GetArgI(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	ConfigMap conf = npc.GetConfigMap();
	if (conf == null)
		return false;

	char aspect[255], pluginName[255], key[255], path[255];
	GetNativeString(2, aspect, sizeof(aspect));
	GetNativeString(3, pluginName, sizeof(pluginName));
	GetNativeString(4, key, sizeof(key));
	int defaultVal = GetNativeCell(5);

	if (!npc.HasAspect(aspect, pluginName, path, sizeof(path)))
	{
		DeleteCfg(conf);
		return defaultVal;
	}

	Format(path, sizeof(path), "%s.%s", path, key);
	int returnVal = GetIntFromConfigMap(conf, path, defaultVal);

	DeleteCfg(conf);

	return returnVal;
}

public any Native_PNPC_GetArgF(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	ConfigMap conf = npc.GetConfigMap();
	if (conf == null)
		return false;

	char aspect[255], pluginName[255], key[255], path[255];
	GetNativeString(2, aspect, sizeof(aspect));
	GetNativeString(3, pluginName, sizeof(pluginName));
	GetNativeString(4, key, sizeof(key));
	float defaultVal = GetNativeCell(5);

	if (!npc.HasAspect(aspect, pluginName, path, sizeof(path)))
	{
		DeleteCfg(conf);
		return defaultVal;
	}

	Format(path, sizeof(path), "%s.%s", path, key);
	int returnVal = GetFloatFromConfigMap(conf, path, defaultVal);
	
	DeleteCfg(conf);

	return returnVal;
}

public int Native_PNPC_GetArgS(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	ConfigMap conf = npc.GetConfigMap();
	if (conf == null)
		return false;

	char aspect[255], pluginName[255], key[255], path[255], defaultVal[255], returnVal[255];
	GetNativeString(2, aspect, sizeof(aspect));
	GetNativeString(3, pluginName, sizeof(pluginName));
	GetNativeString(4, key, sizeof(key));
	GetNativeString(7, defaultVal, sizeof(defaultVal));

	if (!npc.HasAspect(aspect, pluginName, path, sizeof(path)))
	{
		DeleteCfg(conf);
		SetNativeString(5, defaultVal, GetNativeCell(6));
		return 0;
	}

	Format(path, sizeof(path), "%s.%s", path, key);
	conf.Get(path, returnVal, sizeof(returnVal));
	SetNativeString(5, returnVal, GetNativeCell(6));
	
	DeleteCfg(conf);

	return 0;
}

public int Native_PNPC_GetConfigName(Handle plugin, int numParams) { SetNativeString(2, PNPC_ConfigName[GetNativeCell(1)], GetNativeCell(3)); return 0; }

public int Native_PNPC_SetConfigName(Handle plugin, int numParams)
{
	char conf[255];
	GetNativeString(2, conf, sizeof(conf));
	strcopy(PNPC_ConfigName[GetNativeCell(1)], 255, conf);
	return 0;
}

public int Native_PNPC_GetName(Handle plugin, int numParams) { SetNativeString(2, PNPC_Name[GetNativeCell(1)], GetNativeCell(3)); return 0; }

public int Native_PNPC_SetName(Handle plugin, int numParams)
{
	char conf[255];
	GetNativeString(2, conf, sizeof(conf));
	strcopy(PNPC_Name[GetNativeCell(1)], 255, conf);
	return 0;
}

public void PNPC_OnEntityCreated(int entity, const char[] classname)
{
	if (StrContains(classname, "tf_projectile") != -1)
		b_IsProjectile[entity] = true;

	//All projectiles that have any sort of explosion (not including wrap assassin) need to have custom explosion logic so that they work seamlessly with NPCs:
	if (StrEqual(classname, "tf_projectile_pipe"))
	{
		g_DHookGrenadeExplode.HookEntity(Hook_Pre, entity, PNPC_GrenadeExplode);
		DHookEntity(g_DHookPillCollide, false, entity, _, PNPC_GrenadeCollide);
	}

	if (StrEqual(classname, "tf_projectile_pipe_remote"))
	{
		g_DHookStickyExplode.HookEntity(Hook_Pre, entity, PNPC_StickyExplode);
	}

	if (StrContains(classname, "tf_projectile_spellfireball") != -1)
	{
		g_DHookFireballExplode.HookEntity(Hook_Pre, entity, PNPC_FireballExplode);
	}

	if (StrContains(classname, "tf_projectile_rocket") != -1 || StrContains(classname, "tf_projectile_sentryrocket") != -1)
	{
		g_DHookRocketExplode.HookEntity(Hook_Pre, entity, PNPC_RocketExplode);
	}
}

public void PNPC_OnEntityDestroyed(int entity)
{
	i_PillCollideTarget[entity] = -1;
	b_PillAlreadyBounced[entity] = false;
	b_IsProjectile[entity] = false;
}

MRESReturn PNPC_OnFlareExplodePre(int entity, Handle hParams) 
{
	CPrintToChatAll("Flare exploded!");

	float damage = GetEntPropFloat(entity, Prop_Send, "m_flDamage");	//TODO: This is almost certainly incorrect, won't know until we get the flare explosion logic working in the first place.
	if (PNPC_TriggerProjectileExplosion(entity, 110.0, damage, SND_EXPLOSION_FLARE, PARTICLE_EXPLOSION_FLARE_RED, PARTICLE_EXPLOSION_FLARE_BLUE, true, 10.0, 0.0, 146.0, 0.5, -1))
		return MRES_Supercede;
	
	return MRES_Ignored;
}

static MRESReturn PNPC_GrenadeCollide(int self, Handle params) 
{
	int other = DHookGetParam(params, 1);

	TFTeam team = view_as<TFTeam>(GetEntProp(self, Prop_Send, "m_iTeamNum"));
	if (team == TFTeam_Red)
		team = TFTeam_Blue;
	else
		team = TFTeam_Red;

	if (PNPC_IsValidTarget(other, team) && !b_PillAlreadyBounced[self])
		i_PillCollideTarget[self] = EntIndexToEntRef(other);

	b_PillAlreadyBounced[self] = true;

	return MRES_Ignored;
}

public MRESReturn PNPC_GrenadeExplode(int entity)
{
	float damage = GetEntPropFloat(entity, Prop_Send, "m_flDamage");

	if (PNPC_TriggerProjectileExplosion(entity, 146.0, damage, SFX_GenericExplosion[GetRandomInt(0, sizeof(SFX_GenericExplosion) - 1)], PARTICLE_EXPLOSION_GENERIC, PARTICLE_EXPLOSION_GENERIC, true, 0.0, 0.0, 146.0, 0.5, EntRefToEntIndex(i_PillCollideTarget[entity])))
		return MRES_Supercede;

	return MRES_Ignored;
}

public MRESReturn PNPC_StickyExplode(int entity)
{
	float damage = GetEntPropFloat(entity, Prop_Send, "m_flDamage");
	if (PNPC_TriggerProjectileExplosion(entity, 146.0, damage, SFX_GenericExplosion[GetRandomInt(0, sizeof(SFX_GenericExplosion) - 1)], PARTICLE_EXPLOSION_GENERIC, PARTICLE_EXPLOSION_GENERIC, true, 0.0, 0.0, 146.0, 0.5, -1))
		return MRES_Supercede;

	return MRES_Ignored;
}

public MRESReturn PNPC_FireballExplode(int entity)
{
	if (PNPC_TriggerProjectileExplosion(entity, 146.0, 100.0, SND_EXPLOSION_FIREBALL, PARTICLE_EXPLOSION_FIREBALL_RED, PARTICLE_EXPLOSION_FIREBALL_BLUE, false, 5.0, -1.0, 0.0, 0.0, -1))
		return MRES_Supercede;
	
	return MRES_Ignored;
}

public MRESReturn PNPC_RocketExplode(int entity)
{
	float damage = GetEntDataFloat(entity, FindSendPropInfo("CTFProjectile_Rocket", "m_iDeflected") + 4);
	if (PNPC_TriggerProjectileExplosion(entity, 146.0, damage, SFX_GenericExplosion[GetRandomInt(0, sizeof(SFX_GenericExplosion) - 1)], PARTICLE_EXPLOSION_GENERIC, PARTICLE_EXPLOSION_GENERIC, true, 0.0, 0.0, 146.0, 0.5, -1))
		return MRES_Supercede;
	
	return MRES_Ignored;
}

float currentIgniteTime = 0.0;
float currentFullDMG = 0.0;
int currentDirectVictim = -1;
public bool PNPC_TriggerProjectileExplosion(int entity, float radius, float damage, char[] sound, char redParticle[255], char blueParticle[255], bool hitOwner, float igniteTime, float falloffStart, float falloffEnd, float falloffMax, int directTarget)
{
	int launcher = -1;
	int owner = -1;
	if (PNPC_CheckAllowCustomExplosionLogic(entity, owner, launcher))
	{
		PNPC_CalculateExplosionBaseStats(launcher, damage, radius);

		float pos[3];
		GetEntPropVector(entity, Prop_Data, "m_vecAbsOrigin", pos);

		int team = GetEntProp(entity, Prop_Send, "m_iTeamNum");

		if (!StrEqual(redParticle, "") && view_as<int>(TFTeam_Red) == team)
			SpawnParticle(pos, redParticle, 2.0);
		else if (!StrEqual(blueParticle, "") && view_as<int>(TFTeam_Blue) == team)
			SpawnParticle(pos, blueParticle, 2.0);

		if (!StrEqual(sound, ""))
			EmitSoundToAll(sound, entity);

		int damagetype = DMG_BLAST;

		if (damage > 100.0)
			damagetype |= DMG_ALWAYSGIB;
		if (GetEntProp(entity, Prop_Send, "m_bCritical") > 0)
			damagetype |= DMG_ACID;

		currentIgniteTime = igniteTime;
		currentFullDMG = damage;
		currentDirectVictim = directTarget;

		if (igniteTime > 0.0)
			PNPC_Explosion(pos, radius, damage, falloffStart, falloffEnd, falloffMax, entity, launcher, owner, damagetype, _, true, hitOwner, _, _, PNPC_IgniteOnHit, PLUGIN_NAME);
		else
			PNPC_Explosion(pos, radius, damage, falloffStart, falloffEnd, falloffMax, entity, launcher, owner, damagetype, _, true, hitOwner, _, _, PNPC_DirectHitCheck, PLUGIN_NAME);

		RemoveEntity(entity);

		return true;
	}

	return false;
}

public void PNPC_IgniteOnHit(int victim, int &attacker, int &inflictor, int &weapon, float &damage)
{
	if (PNPC_IsNPC(victim))
	{
		view_as<PNPC>(victim).Ignite(currentIgniteTime, currentIgniteTime, currentIgniteTime, _, _, attacker)
	}
	else if (IsValidMulti(victim))
	{
		TF2_IgnitePlayer(victim, attacker, currentIgniteTime);
	}

	if (victim == currentDirectVictim)
		damage = currentFullDMG;
}

public void PNPC_DirectHitCheck(int victim, int &attacker, int &inflictor, int &weapon, float &damage)
{
	if (victim == currentDirectVictim)
		damage = currentFullDMG;
}

bool PNPC_CheckAllowCustomExplosionLogic(int entity, int &owner = -1, int &launcher = -1)
{
	if (!IsValidEntity(entity))
		return false;

	owner = GetEntPropEnt(entity, Prop_Send, "m_hOwnerEntity");
	if (!IsValidEntity(owner) && HasEntProp(entity, Prop_Send, "m_hThrower"))
		owner = GetEntPropEnt(entity, Prop_Send, "m_hThrower");

	launcher = GetEntPropEnt(entity, Prop_Send, "m_hOriginalLauncher");

	bool success = true;

	Call_StartForward(g_OnProjectileExplode);

	Call_PushCell(entity);
	Call_PushCell(owner);
	Call_PushCell(launcher);

	Call_Finish(success);

	return success;
}

void PNPC_CalculateExplosionBaseStats(int launcher, float &damage, float &radius)
{
	if (IsValidEntity(launcher))
	{
		radius *= GetAttributeValue(launcher, 99, 1.0) * GetAttributeValue(launcher, 100, 1.0);
		damage *= GetAttributeValue(launcher, 1, 1.0) * GetAttributeValue(launcher, 2, 1.0);
	}
}

void PNPC_OnCreate(int npc)
{
	PNPC alive = view_as<PNPC>(npc);

	for (int i = MaxClients + 1; i < 2049; i++)
	{
		int entity = EntRefToEntIndex(i_TotalNPCs[i]);
		if (!IsValidEntity(entity))
		{
			alive.SetProp(Prop_Data, "pnpc_pPath", view_as<int>(g_PathFollowers[i]));
			i_TotalNPCs[i] = EntIndexToEntRef(alive.Index);
			break;
		}
	}

	Call_StartForward(g_OnPNPCCreated);
	Call_PushCell(npc);
	Call_Finish();

	alive.b_Exists = true;
	I_AM_DEAD[npc] = false;
}

void PNPC_OnDestroy(int npc)
{
	Call_StartForward(g_OnPNPCDestroyed);
	Call_PushCell(npc);
	Call_Finish();

	SDKUnhook(npc, SDKHook_OnTakeDamagePost, PNPC_PostDamage);
	SDKUnhook(npc, SDKHook_OnTakeDamage, PNPC_OnDamage);
	SDKUnhook(npc, SDKHook_ThinkPost, PNPC_ThinkPost);
	SDKUnhook(npc, SDKHook_Think, PNPC_Think);
	SDKUnhook(npc, SDKHook_TraceAttack, PNPC_TraceAttack);
	SDKUnhook(npc, SDKHook_Touch, PNPC_Touch);

	PNPC dead = view_as<PNPC>(npc);
	if(dead.GetPathFollower().IsValid())
	{
		dead.GetPathFollower().Invalidate(); //Remove its current path
	}
	dead.SetProp(Prop_Data, "pnpc_pPath", -1);

	PNPC_RemoveFromPaths(dead);

	delete g_Gibs[npc];
	delete g_GibAttachments[npc];
	delete g_AttachedModels[npc];
	delete g_AttachedWeaponModels[npc];
	i_BleedStacks[npc] = 0;

	strcopy(PNPC_ConfigName[npc], 255, "");
	strcopy(PNPC_Name[npc], 255, "");

	dead.b_Exists = false;
	I_AM_DEAD[npc] = true;
}

void PNPC_RemoveFromPaths(PNPC npc)
{
	for (int i = MaxClients + 1; i < 2049; i++)
	{
		int entity = EntRefToEntIndex(i_TotalNPCs[i]);
		if (entity == npc.Index)
		{
			npc.SetProp(Prop_Data, "pnpc_pPath", 0);
			i_TotalNPCs[i] = -1;
			break;
		}
	}
}

public int Native_PNPCConstructor(Handle plugin, int numParams)
{
	char model[255], logicPlugin[255], configName[255], name[255];
	float pos[3], ang[3];

	GetNativeString(1, model, sizeof(model));
	TFTeam team = GetNativeCell(2);
	int health = GetNativeCell(3);
	int maxHealth = GetNativeCell(4);
	int skin = GetNativeCell(5);
	float scale = GetNativeCell(6);
	float speed = GetNativeCell(7);
	Function logic = GetNativeFunction(8);
	GetNativeString(9, logicPlugin, sizeof(logicPlugin));
	float thinkRate = GetNativeCell(10);
	GetNativeArray(11, pos, sizeof(pos));
	GetNativeArray(12, ang, sizeof(ang));
	float lifespan = GetNativeCell(13);
	GetNativeString(14, configName, sizeof(configName));
	GetNativeString(15, name, sizeof(name));

	int ent = CreateEntityByName(NPC_NAME);
	if (IsValidEntity(ent))
	{
		PNPC npc = view_as<PNPC>(ent);
		CBaseNPC base = npc.GetBaseNPC();

		npc.g_Logic = logic;
		npc.g_LogicPlugin = GetPluginHandle(logicPlugin);
		npc.i_Team = team;
		npc.i_Health = health;
		npc.i_MaxHealth = maxHealth;
		npc.SetModel(model);
		npc.i_Skin = skin;
		npc.f_Scale = scale;
		npc.f_Speed = speed;
		npc.f_MaxSpeed = speed;
		npc.f_ThinkRate = thinkRate;
		npc.SetBleedParticle(VFX_DEFAULT_BLEED);
		npc.SetBoundingBox(DEFAULT_MINS, DEFAULT_MAXS);
		npc.SetConfigName(configName);
		npc.SetName(name);

		if (lifespan > 0.0)
			npc.f_EndTime = GetGameTime() + lifespan;
		else
			npc.f_EndTime = 0.0;

		DispatchSpawn(ent);
		ActivateEntity(ent);

		CBaseNPC_Locomotion loco = npc.GetLocomotion();
		loco.SetCallback(LocomotionCallback_ShouldCollideWith, PNPC_ShouldCollide);
		loco.SetCallback(LocomotionCallback_IsEntityTraversable, PNPC_IsTraversable);

		SetEntProp(ent, Prop_Data, "m_nSolidType", 2); 
		SetEntityFlags(ent, FL_NPC);
		SetEntProp(ent, Prop_Send, "m_bGlowEnabled", false);
		SetEntProp(ent, Prop_Data, "m_bSequenceLoops", true);
		SetEntProp(ent, Prop_Data, "m_bloodColor", -1);

		base.flStepSize = 17.0;
		base.flGravity = 800.0;
		base.flAcceleration = 6000.0;
		base.flJumpHeight = 250.0;
		base.flFrictionSideways = 5.0;
		base.flMaxYawRate = 225.0;
		base.flDeathDropHeight = 999999.0;

		TeleportEntity(ent, pos, ang);

		RequestFrame(PNPC_InternalLogic, EntIndexToEntRef(ent));

		SDKHook(ent, SDKHook_OnTakeDamagePost, PNPC_PostDamage);
		SDKHook(ent, SDKHook_OnTakeDamage, PNPC_OnDamage);
		SDKHook(ent, SDKHook_Think, PNPC_Think);
		SDKHook(ent, SDKHook_ThinkPost, PNPC_ThinkPost);
		SDKHook(ent, SDKHook_TraceAttack, PNPC_TraceAttack);
		SDKHook(ent, SDKHook_Touch, PNPC_Touch);

		return ent;
	}

	return -1;
}

public void PNPC_Touch(int entity, int other)
{
	if (!HasEntProp(other, Prop_Send, "m_iTeamNum"))
		return;

	if (GetEntProp(other, Prop_Send, "m_iTeamNum") == GetEntProp(entity, Prop_Send, "m_iTeamNum"))
		return;

	PNPC npc = view_as<PNPC>(entity);

	char classname[255];
	GetEntityClassname(other, classname, sizeof(classname));

	float pos[3];

	bool remove = false;
	if (StrEqual(classname, "tf_projectile_cleaver"))
	{
		bool live = view_as<bool>(GetEntProp(other, Prop_Send, "m_bTouched"));
		if (!live)
		{
			float dmg = 50.0;

			int owner = GetEntPropEnt(other, Prop_Send, "m_hThrower");
			int launcher = GetEntPropEnt(other, Prop_Send, "m_hOriginalLauncher");

			if (IsValidEntity(launcher))
				dmg *= GetAttributeValue(launcher, 1, 1.0) * GetAttributeValue(launcher, 2, 1.0);

			GetEntPropVector(other, Prop_Send, "m_vecOrigin", pos);

			SetEntProp(other, Prop_Send, "m_bTouched", 1);
			SDKHooks_TakeDamage(entity, other, owner, dmg, GetEntProp(other, Prop_Send, "m_bCritical") > 0 ? DMG_CLUB|DMG_ACID : DMG_CLUB, launcher, _, pos, false);

			if (IsValidClient(owner))
			{
				EmitSoundToClient(owner, SND_CLEAVER_HIT);
			}

			EmitSoundToAll(SND_CLEAVER_HIT, other);

			remove = true;
		}
	}
	else if (StrEqual(classname, "tf_projectile_stun_ball"))
	{
		bool live = view_as<bool>(GetEntProp(other, Prop_Send, "m_bTouched"));
		if (!live)
		{
			float dmg = 15.0;

			int launcher = GetEntPropEnt(other, Prop_Send, "m_hOriginalLauncher");
			int owner = GetEntPropEnt(other, Prop_Send, "m_hOwnerEntity");
			GetEntPropVector(other, Prop_Send, "m_vecOrigin", pos);

			if (IsValidEntity(launcher))
				dmg *= GetAttributeValue(launcher, 1, 1.0) * GetAttributeValue(launcher, 2, 1.0);

			SDKHooks_TakeDamage(entity, other, owner, dmg, GetEntProp(other, Prop_Send, "m_bCritical") > 0 ? DMG_CLUB|DMG_ACID : DMG_CLUB, launcher, _, pos, false);
			npc.ApplyTemporarySpeedChange(0.5, 1, 6.0);
			SetEntProp(other, Prop_Send, "m_bTouched", 1);

			if (IsValidClient(owner))
			{
				EmitSoundToClient(owner, SND_SANDMAN_HIT);
			}

			EmitSoundToAll(SND_SANDMAN_HIT, other);
		}
	}

	if (remove)
		RemoveEntity(other);
}

MRESReturn PNPC_OnJarExplodePre(Handle hParams) 
{
	int jar = DHookGetParam(hParams, 1);
	if (PNPC_JarTouch(jar))
		return MRES_Supercede;

	return MRES_Ignored;
}

int Jar_Thrower = -1;

public bool PNPC_JarTouch(int entity)
{
	char classname[255];
	GetEntityClassname(entity, classname, sizeof(classname));

	int team = GetEntProp(entity, Prop_Send, "m_iTeamNum");
	bool isRed = team == view_as<int>(TFTeam_Red);

	int owner = GetEntPropEnt(entity, Prop_Send, "m_hThrower");
	int launcher = GetEntPropEnt(entity, Prop_Send, "m_hOriginalLauncher");

	bool allow = true;

	Call_StartForward(g_OnJarCollide);

	Call_PushCell(entity);
	Call_PushCell(owner);
	Call_PushCell(launcher);

	Call_Finish(allow);

	if (allow)
	{
		float radMult = 1.0;

		if (IsValidEntity(launcher))
		{
			if (GetEntSendPropOffs(launcher, "m_AttributeList") > 0)
			{
				radMult *= GetAttributeValue(launcher, 99, 1.0) * GetAttributeValue(launcher, 100, 1.0);
			}
		}

		float pos[3];

		if (StrEqual(classname, "tf_projectile_jar"))
		{
			GetEntPropVector(entity, Prop_Send, "m_vecOrigin", pos);

			SpawnParticle(pos, PARTICLE_JAR_EXPLODE_JARATE, 2.0);
			EmitSoundToAll(SND_JAR_EXPLODE, entity);

			float radius = 200.0 * radMult;

			Jar_Thrower = (IsValidEntity(owner) ? EntIndexToEntRef(owner) : -1);
			PNPC_Explosion(pos, radius, 0.0, -1.0, _, _, entity, launcher, 0, _, _, _, false, PNPC_GenericNonBuildingFilter, PLUGIN_NAME, PNPC_OnJarateHit, PLUGIN_NAME);
		}
		else if (StrEqual(classname, "tf_projectile_jar_milk"))
		{
			GetEntPropVector(entity, Prop_Send, "m_vecOrigin", pos);

			SpawnParticle(pos, PARTICLE_JAR_EXPLODE_MILK, 2.0);
			EmitSoundToAll(SND_JAR_EXPLODE, entity);

			float radius = 200.0 * radMult;

			Jar_Thrower = (IsValidEntity(owner) ? EntIndexToEntRef(owner) : -1);
			PNPC_Explosion(pos, radius, 0.0, -1.0, _, _, entity, launcher, 0, _, _, _, false, PNPC_GenericNonBuildingFilter, PLUGIN_NAME, PNPC_OnMilkHit, PLUGIN_NAME);
		}
		else if (StrEqual(classname, "tf_projectile_jar_gas"))
		{
			GetEntPropVector(entity, Prop_Send, "m_vecOrigin", pos);

			SpawnParticle(pos, isRed ? PARTICLE_JAR_EXPLODE_GAS_RED : PARTICLE_JAR_EXPLODE_GAS_BLUE, 2.0);
			EmitSoundToAll(SND_GAS_EXPLODE, entity);

			float radius = 400.0 * radMult;

			DataPack pack = new DataPack();
			RequestFrame(PNPC_GasCloudLogic, pack);
			WritePackCell(pack, IsValidEntity(owner) ? EntIndexToEntRef(owner) : -1)
			WritePackFloat(pack, radius);
			WritePackFloatArray(pack, pos, sizeof(pos));
			WritePackFloat(pack, GetGameTime() + 5.0);
		}

		RemoveEntity(entity);
	}

	return allow;
}

int Gas_Owner = -1;

public void PNPC_GasCloudLogic(DataPack pack)
{
	ResetPack(pack);

	int owner = EntRefToEntIndex(ReadPackCell(pack));
	float radius = ReadPackFloat(pack);
	float pos[3];
	ReadPackFloatArray(pack, pos, sizeof(pos));
	float endTime = ReadPackFloat(pack);

	if (GetGameTime() >= endTime)
	{
		delete pack;
		return;
	}

	Gas_Owner = (IsValidEntity(owner) ? EntIndexToEntRef(owner) : -1);
	PNPC_Explosion(pos, radius, 0.0, -1.0, _, _, _, _, _, _, _, _, _, PNPC_GasCloudFilter, PLUGIN_NAME, PNPC_OnGasHit, PLUGIN_NAME);

	RequestFrame(PNPC_GasCloudLogic, pack);
}

public bool PNPC_GasCloudFilter(int victim, int &attacker, int &inflictor, int &weapon, float &damage)
{
	if (IsValidClient(victim))
		return !TF2_IsPlayerInCondition(victim, TFCond_Gas);
	else if (PNPC_IsNPC(victim))
		return !view_as<PNPC>(victim).b_Gassed;

	return false;
}

public void PNPC_OnGasHit(int victim, int &attacker, int &inflictor, int &weapon, float &damage)
{
	attacker = EntRefToEntIndex(Gas_Owner);
	if (!IsValidEntity(attacker))
		attacker = 0;
	else if (HasEntProp(victim, Prop_Send, "m_iTeamNum") && HasEntProp(attacker, Prop_Send, "m_iTeamNum"))
	{
		//Don't gas allies...
		if (GetEntProp(victim, Prop_Send, "m_iTeamNum") == GetEntProp(attacker, Prop_Send, "m_iTeamNum"))
			return;
	}

	if (PNPC_IsNPC(victim))
	{
		view_as<PNPC>(victim).ApplyGas(10.0, attacker);
	}
	else if (IsValidMulti(victim))
	{
		TF2_AddCondition(victim, TFCond_Gas, 10.0, attacker);
	}
}

public bool PNPC_GenericNonBuildingFilter(int victim, int &attacker, int &inflictor, int &weapon, float &damage)
{
	return !IsABuilding(victim);
}

public void PNPC_OnMilkHit(int victim, int &attacker, int &inflictor, int &weapon, float &damage)
{
	attacker = EntRefToEntIndex(Jar_Thrower);
	if (!IsValidEntity(attacker))
		attacker = 0;
	else if (HasEntProp(victim, Prop_Send, "m_iTeamNum") && HasEntProp(attacker, Prop_Send, "m_iTeamNum"))
	{
		if (GetEntProp(victim, Prop_Send, "m_iTeamNum") == GetEntProp(attacker, Prop_Send, "m_iTeamNum"))
		{
			PNPC_ExtinguishViaJar(victim);
			return;
		}
	}

	if (PNPC_IsNPC(victim))
	{
		view_as<PNPC>(victim).ApplyMilk(10.0, attacker);
	}
	else if (IsValidMulti(victim))
	{
		TF2_AddCondition(victim, TFCond_Milked, 10.0, attacker);
	}
}

public void PNPC_OnJarateHit(int victim, int &attacker, int &inflictor, int &weapon, float &damage)
{
	attacker = EntRefToEntIndex(Jar_Thrower);
	if (!IsValidEntity(attacker))
		attacker = 0;
	else if (HasEntProp(victim, Prop_Send, "m_iTeamNum") && HasEntProp(attacker, Prop_Send, "m_iTeamNum"))
	{
		if (GetEntProp(victim, Prop_Send, "m_iTeamNum") == GetEntProp(attacker, Prop_Send, "m_iTeamNum"))
		{
			PNPC_ExtinguishViaJar(victim);
			return;
		}
	}

	if (PNPC_IsNPC(victim))
	{
		view_as<PNPC>(victim).ApplyJarate(10.0, attacker);
	}
	else if (IsValidMulti(victim))
	{
		TF2_AddCondition(victim, TFCond_Jarated, 10.0, attacker);
	}
}

public void PNPC_ExtinguishViaJar(int victim)
{
	bool success = false;

	if (PNPC_IsNPC(victim) && view_as<PNPC>(victim).b_Burning)
	{
		view_as<PNPC>(victim).Extinguish();
		success = true;
	}
	else if (IsValidMulti(victim))
	{
		if (TF2_IsPlayerInCondition(victim, TFCond_OnFire) || TF2_IsPlayerInCondition(victim, TFCond_BurningPyro))
		{
			TF2_RemoveCondition(victim, TFCond_OnFire);
			TF2_RemoveCondition(victim, TFCond_BurningPyro);
			success = true;
		}
	}

	if (success)
	{
		EmitSoundToAll(SND_EXTINGUISH, victim);
		float pos[3];
		PNPC_WorldSpaceCenter(victim, pos);
		SpawnParticle(pos, PARTICLE_EXTINGUISH, 2.0);
	}
}

public Action PNPC_TraceAttack(int victim, int& attacker, int& inflictor, float& damage, int& damagetype, int& ammotype, int hitbox, int hitgroup)
{
	if (!IsValidEntity(inflictor) || !IsValidClient(attacker))
		return Plugin_Continue;

	int weapon = GetEntPropEnt(attacker, Prop_Send, "m_hActiveWeapon");

	bool AllowHeadshot = true;
	if (IsValidEntity(weapon))
	{
		//Attribute 42: No Headshots
		AllowHeadshot = GetAttributeValue(weapon, 42, 0.0) == 0.0;

		//Attribute 306: Only Headshot at Full Charge
		if (AllowHeadshot && GetAttributeValue(weapon, 306, 0.0) != 0.0 && HasEntProp(weapon, Prop_Send, "m_flChargedDamage"))
		{
			AllowHeadshot = (GetEntPropFloat(weapon, Prop_Send, "m_flChargedDamage") / 150.0) >= 1.0;
		}
	}

	bool CanHeadshot = false;
	if (AllowHeadshot && !CanHeadshot && IsValidEntity(weapon))
	{
		//Attribute 51: Allow Headshots
		CanHeadshot = GetAttributeValue(weapon, 51, 0.0) != 0.0

		//Check if the weapon is a sniper rifle or bow with any charge.
		if (!CanHeadshot && HasEntProp(weapon, Prop_Send, "m_flChargedDamage"))
		{
			char weaponName[255];
			GetEntityClassname(weapon, weaponName, sizeof(weaponName));
			if (StrContains(weaponName, "sniperrifle") != -1)
			{
				CanHeadshot = GetEntPropFloat(weapon, Prop_Send, "m_flChargedDamage") > 0.0;
			}
		}
	}

	if (hitgroup == HITGROUP_HEAD && CanHeadshot)
	{
		float mult = 3.0;
		bool MiniCrit = false;

		if (IsValidEntity(weapon))
		{
			//Attribute 869: Crits Become Mini-Crits
			if (GetAttributeValue(weapon, 869, 0.0) != 0.0)
			{
				MiniCrit = true;
			}

			//Attribute 390: Increased Headshot Damage
			mult *= GetAttributeValue(weapon, 869, 1.0);
		}

		Action result = Plugin_Continue;
		Call_StartForward(g_OnPNPCHeadshot);

		Call_PushCell(view_as<PNPC>(victim));
		Call_PushCell(weapon);
		Call_PushCell(inflictor);
		Call_PushCell(attacker);
		Call_PushFloatRef(mult);
		Call_PushCellRef(MiniCrit);

		Call_Finish(result);

		if (result != Plugin_Handled && result != Plugin_Stop)
		{
			if (MiniCrit)
				mult *= 0.45;
			damage *= mult;

			if (MiniCrit)
				PlayMiniCritSound(attacker);
			else
				PlayCritSound(attacker);

			PNPC_SpawnCritParticle(view_as<PNPC>(victim), MiniCrit);
		}
	}

	return Plugin_Changed;
}

void PNPC_SpawnCritParticle(PNPC victim, bool MiniCrit, float pos[3] = NULL_VECTOR)
{
	if (Vector_Is_Null(pos))
	{
		GetEntPropVector(victim.Index, Prop_Send, "m_vecOrigin", pos);
		pos[2] += 80.0 * victim.f_Scale;
	}

	SpawnParticle(pos, MiniCrit ? "minicrit_text" : "crit_text", 3.0);
}

public void PNPC_Think(int iNPC)
{
	PNPC npc = view_as<PNPC>(iNPC);

	npc.GetBaseNPC().flRunSpeed = npc.f_Speed;
	npc.GetBaseNPC().flWalkSpeed = npc.f_Speed;
}

public void PNPC_ThinkPost(int iNPC)
{
	CBaseCombatCharacter(iNPC).SetNextThink(GetGameTime());
	SetEntPropFloat(iNPC, Prop_Data, "m_flSimulationTime",GetGameTime());
}

public bool PNPC_ShouldCollide(CBaseNPC_Locomotion loco, int other)
{ 
	int bot = loco.GetBot().GetNextBotCombatCharacter();
	return PNPC_CollisionCheck(bot, other);
}

//TODO: Expand on this if necessary.
public bool PNPC_CollisionCheck(int bot, int other)
{
	return !IsAlly(bot, other);
}

public bool PNPC_IsTraversable(CBaseNPC_Locomotion loco, int other, TraverseWhenType when)
{
	if (other < 1)
		return false;

	//if (b_IsInUpdateGroundConstraint && b_IsProjectile[other])
	//	return false;

	//int bot = loco.GetBot().GetNextBotCombatCharacter();

	if (Brush_Is_Solid(other))
		return false;

	return true;
}

public void PNPC_OnKilled(int victim, int attacker, int inflictor, float damage, int damagetype, int weapon, const float damageForce[3], const float damagePos[3])
{
	Action result = Plugin_Continue;

	Call_StartForward(g_OnPNPCKilled);

	Call_PushCell(view_as<PNPC>(victim));
	Call_PushFloat(damage);
	Call_PushCell(weapon);
	Call_PushCell(inflictor);
	Call_PushCell(attacker);
	Call_PushCellRef(damagetype);

	Call_Finish(result);

	if (result == Plugin_Continue || result == Plugin_Changed)
	{
		PNPC npc = view_as<PNPC>(victim);

		npc.PunchForce(damageForce, true);

		bool shouldGib = npc.b_GibsForced;

		if (!shouldGib && (damagetype & DMG_NEVERGIB == 0))
		{
			shouldGib = (damagetype & DMG_BLAST != 0) || (damagetype & DMG_BLAST_SURFACE != 0) || (damagetype & DMG_ALWAYSGIB != 0);

			if (!shouldGib && IsValidEntity(weapon))
			{
				if (GetAttributeValue(weapon, 309, 0.0) != 0.0 && (damagetype & DMG_CRIT != 0 || damagetype & DMG_ACID == DMG_ACID))
					shouldGib = true;
			}
		}
		
		npc.Extinguish();
		npc.RemoveMilk();
		npc.RemoveJarate();
		I_AM_DEAD[victim] = true;

		if (shouldGib)
		{
			npc.Gib();
		}
		else
		{
			npc.Ragdoll();
		}
	}
}

public void PNPC_PostDamage(int victim, int attacker, int inflictor, float damage, int damagetype, int weapon, const float damageForce[3], const float damagePosition[3])
{
	PNPC npc = view_as<PNPC>(victim);

	Event event = CreateEvent("npc_hurt");
	if(event != null) 
	{
		event.SetInt("entindex", victim);
		event.SetInt("health", view_as<PNPC>(victim).i_Health);
		event.SetInt("damageamount", RoundToFloor(damage));
		event.SetBool("crit", (damagetype & DMG_ACID) == DMG_ACID);

		if(IsValidClient(attacker))
		{
			event.SetInt("attacker_player", GetClientUserId(attacker));
			event.SetInt("weaponid", 0);
		}

		event.Fire();
	}

	PNPC_AttemptIgnite(victim, attacker, inflictor, weapon, damage);
	PNPC_AttemptBleed(victim, attacker, inflictor, weapon);

	if (IsValidEntity(attacker) && attacker > 0 && !IsABuilding(attacker) && npc.b_Milked)
	{
		PNPC_HealEntity(attacker, RoundToFloor(damage * 0.6), 1.0, npc.i_Milker);
	}

	if (!StrEqual(PNPC_BleedParticle[victim], "") && damage > 0.0)
	{
		float dPos[3];
		dPos = damagePosition;

		if (Vector_Is_Null(dPos))
		{
			dPos = GetWorldSpaceCenter(victim);
			for (int i = 0; i < 3; i++)
				dPos[i] += GetRandomFloat(-20.0 * npc.f_Scale, 20.0 * npc.f_Scale);
		}

		SpawnParticle(dPos, PNPC_BleedParticle[victim], 0.66);	//TODO: Make this a TE entity. Also do the same to crit text.
	}

	if (!StrEqual(PNPC_FlinchSequence[victim], "") && GetGameTime() >= f_NextFlinch[victim])
	{
		npc.AddGesture(PNPC_FlinchSequence[victim]);
		f_NextFlinch[victim] = GetGameTime() + 0.2;
	}

	if (view_as<PNPC>(victim).i_Health < 1)
	{
		PNPC_OnKilled(victim, attacker, inflictor, damage, damagetype, weapon, damageForce, damagePosition);
	}
}

public void PNPC_AttemptIgnite(int victim, int attacker, int inflictor, int weapon, float damage)
{
	PNPC npc = view_as<PNPC>(victim);
	bool burn = false;
	float burnTime = 0.0;
	float minBurnTime = 0.0;
	float maxBurnTime = 0.0;
	float burnDMG = 0.0;
	bool haunted = false;

	char classname[255];
	if (IsValidEntity(weapon))
	{
		//Attributes 73, 74, 828, and 829 all affect afterburn duration.
		float timeMult = (GetAttributeValue(weapon, 73, 1.0) * GetAttributeValue(weapon, 74, 1.0) * GetAttributeValue(weapon, 828, 1.0) * GetAttributeValue(weapon, 829, 1.0));
		//Attributes 71 and 72 both affect afterburn damage.
		float dmgMult = (GetAttributeValue(weapon, 71, 1.0) * GetAttributeValue(weapon, 72, 1.0));

		GetEntityClassname(weapon, classname, sizeof(classname));
		if (StrEqual(classname, "tf_weapon_flamethrower"))
		{
			minBurnTime = 4.0 * timeMult;
			maxBurnTime = 10.0 * timeMult;
			burnTime = 0.4 * timeMult;
			burn = true;
		}
		else if (StrEqual(classname, "tf_weapon_rocketlauncher_fireball"))
		{
			minBurnTime = 2.5 * timeMult;
			maxBurnTime = 2.5 * timeMult;
			burnTime = 2.5 * timeMult;
			burn = true;
		}
		else if (StrContains(classname, "flaregun") != -1)
		{
			burnTime = 7.5 * timeMult;
			minBurnTime = burnTime;
			maxBurnTime = burnTime;
			burn = true;
		}
		else if (GetAttributeValue(weapon, 208, 0.0) != 0.0)
		{
			burnTime = GetAttributeValue(weapon, 208, 0.0) * timeMult;
			minBurnTime = burnTime;
			maxBurnTime = burnTime;
			burn = true;
		}

		burnDMG = 4.0 * dmgMult;
		haunted = GetAttributeValue(weapon, 1008, 0.0) != 0.0;
	}
	else if (IsValidEntity(inflictor))
	{
		GetEntityClassname(inflictor, classname, sizeof(classname));
		if (StrContains(classname, "tf_projectile_flare") != -1)
		{
			burnTime = 7.5;
			burn = true;
			burnDMG = 4.0;
		}
	}

	if (npc.b_Gassed && damage > 0.0)
	{
		if (minBurnTime < 10.0)
			minBurnTime = 10.0;

		if (maxBurnTime > 10.0)
			maxBurnTime = 10.0;

		if (burnTime < 10.0)
			burnTime = 10.0;

		if (burnDMG < 4.0)
			burnDMG = 4.0;

		haunted = false;
		attacker = npc.i_GasApplicant;

		burn = true;
		npc.RemoveGas(true);
	}

	if (burn)
	{
		npc.Ignite(burnTime, minBurnTime, maxBurnTime, burnDMG, haunted, attacker);
	}
}

public void PNPC_AttemptBleed(int victim, int attacker, int inflictor, int weapon)
{
	PNPC npc = view_as<PNPC>(victim);

	bool bleed = false;
	float bleedTime = 0.0;
	float bleedDMG = 4.0;

	if (IsValidEntity(weapon))
	{
		bleedTime = GetAttributeValue(weapon, 149, 0.0);

		if (bleedTime > 0.0)
			bleed = true;
	}

	if (IsValidEntity(inflictor) && !bleed)
	{
		char classname[255];
		GetEntityClassname(inflictor, classname, sizeof(classname));

		if (StrEqual(classname, "tf_projectile_ball_ornament") || StrEqual(classname, "tf_projectile_cleaver"))
		{
			bleedTime = 5.0;
			bleed = true;
		}
	}

	if (IsValidEntity(weapon))
		bleedDMG *= GetAttributeValue(weapon, 138, 1.0);

	if (bleed)
	{
		npc.Bleed(bleedTime, bleedDMG, attacker);
	}
}

public Action PNPC_OnDamage(int victim, int &attacker, int &inflictor, float &damage, int &damagetype, int &weapon, float damageForce[3], float damagePosition[3], int damagecustom)
{
	if (IsAlly(victim, attacker))
	{
		damage = 0.0;
		return Plugin_Changed;
	}

	PNPC npc = view_as<PNPC>(victim);

	if (npc.b_Burning)
	{
		//Attributes 20 and 735: Crit VS Burning Targets
		if (GetAttributeValue(weapon, 20, 0.0) != 0.0 || GetAttributeValue(weapon, 735, 0.0) != 0.0)
			damagetype |= DMG_ACID;
		else if (GetAttributeValue(weapon, 638, 0.0) != 0.0)	//Attribute 638: Mini-Crit Burning Targets From Front, Full-Crit From Back
		{
			if (IsBehindAndFacingTarget(attacker, victim))
				damagetype |= DMG_ACID;
			else
				b_MiniCrit[victim] = true;
		}

		//Attribute 795: Damage Bonus VS Burning Targets
		damage *= GetAttributeValue(weapon, 795, 1.0);

		//Attribute 2063: Dragon's Fury Properties
		if (GetAttributeValue(weapon, 2063, 0.0) != 0.0)
		{
			damage *= 3.0;
			
			if (IsValidEntity(weapon))
			{
				float next = GetEntPropFloat(weapon, Prop_Send, "m_flNextPrimaryAttack");
				if (next > GetGameTime())
				{
					float diff = next - GetGameTime();
					diff /= 2.0;
					SetEntPropFloat(weapon, Prop_Send, "m_flNextPrimaryAttack", GetGameTime() + diff);
				}
			}
		}

		//Attribute 2067: Mini-Crit and Extinguish Burning Targets, Speed Boost on Kill
		if (GetAttributeValue(weapon, 2067, 0.0) != 0.0)
		{
			b_MiniCrit[victim] = true;
			if (damage * 1.35 > float(npc.i_Health) && IsValidClient(attacker))
				TF2_AddCondition(attacker, TFCond_SpeedBuffAlly, 4.0);

			npc.Extinguish();
		}
	}
	else
	{
		//Attribute 21: Damage Penalty VS Non-Burning Targets
		damage *= GetAttributeValue(weapon, 21, 1.0);

		//Attribute 22: No Crits VS Non-Burning Targets
		if (GetAttributeValue(weapon, 22, 0.0) != 0.0)
			damagetype &= ~DMG_ACID;

		//Attribute 408: Crit VS Non-Burning Targets
		if (GetAttributeValue(weapon, 408, 0.0) != 0.0)
			damagetype |= DMG_ACID;
	}

	bool crit = (damagetype & DMG_ACID) == DMG_ACID;
	if (crit && GetAttributeValue(weapon, 869, 0.0) == 0.0)
	{
		if (damage > 0.0)
		{
			PNPC_SpawnCritParticle(view_as<PNPC>(victim), false, damagePosition);
			if (IsValidClient(attacker))
				PlayCritSound(attacker);
		}

		damage *= 3.0;
	}
	else if (b_MiniCrit[victim] || (crit && GetAttributeValue(weapon, 869, 0.0) != 0.0) || npc.b_Jarated)
	{
		if (damage > 0.0)
		{
			PNPC_SpawnCritParticle(view_as<PNPC>(victim), true, damagePosition);
			if (IsValidClient(attacker))
				PlayMiniCritSound(attacker);
		}

		damage *= 1.35;
	}

	b_MiniCrit[victim] = false;

	Action result;

	Call_StartForward(g_OnPNPCDamaged);

	Call_PushCell(view_as<PNPC>(victim));
	Call_PushFloatRef(damage);
	Call_PushCell(weapon);
	Call_PushCell(inflictor);
	Call_PushCell(attacker);
	Call_PushCellRef(damagetype);
	Call_PushCellRef(damagecustom);

	Call_Finish(result);

	if (result == Plugin_Handled || result == Plugin_Stop)
	{
		damage = 0.0;
		result = Plugin_Changed;
	}

	return Plugin_Changed;
}

public void PNPC_InternalLogic(int ref)
{
	int ent = EntRefToEntIndex(ref);
	if (!IsValidEntity(ent))
		return;

	PNPC npc = view_as<PNPC>(ent);

	if (!npc.b_Exists || I_AM_DEAD[ent])
		return;

	float gt = GetGameTime();
	if (PNPC_Logic[ent] != INVALID_FUNCTION && npc.g_LogicPlugin != null && gt >= npc.f_NextThinkTime)
	{
		Call_StartFunction(npc.g_LogicPlugin, PNPC_Logic[ent]);
		Call_PushCell(npc.Index);
		Call_Finish();

		npc.f_NextThinkTime = gt + npc.f_ThinkRate;
	}
	
	if (gt >= npc.f_EndTime && npc.f_EndTime > 0.0)
	{
		RemoveEntity(ent);
		return;
	}

	PNPC_BurnLogic(npc, gt);
	PNPC_MilkLogic(npc, gt);
	PNPC_JarateLogic(npc, gt);
	PNPC_GasLogic(npc, gt);
	PNPC_SetMovePose(npc);
	PNPC_CheckTriggerHurt(npc);

	if (IsValidEntity(npc.i_PathTarget))
	{
		npc.SetGoalEntity(npc.i_PathTarget);
	}

	npc.GetPathFollower().Update(npc.GetBot());

	RequestFrame(PNPC_InternalLogic, ref);
}

public void PNPC_CheckTriggerHurt(PNPC npc)
{
	float pos[3];
	GetEntPropVector(npc.Index, Prop_Send, "m_vecOrigin", pos);
	if (IsPointHazard(pos))
	{
		npc.i_Health = 0;
		SetEntProp(npc.Index, Prop_Data, "m_takedamage", 1, 1);
		SDKHooks_TakeDamage(npc.Index, 0, 0, 9999999.0, _, _, _, _, false);
	}
}

public void PNPC_BurnLogic(PNPC npc, float gametime)
{
	if (npc.b_Burning)
	{
		if (gametime >= f_NextBurn[npc.Index])
		{
			SDKHooks_TakeDamage(npc.Index, npc.i_AfterburnAttacker, npc.i_AfterburnAttacker, npc.f_AfterburnDMG, DMG_BURN, _, _, _, false);
			if (gametime + 0.5 > npc.f_AfterburnEndTime)
			{
				npc.Extinguish();
			}
			else
			{
				f_NextBurn[npc.Index] = gametime + 0.5;
				if (npc.b_AfterburnIsHaunted)
				{
					AttachParticle_TE(npc.Index, VFX_AFTERBURN_HAUNTED);
				}
			}
		}
	}
}

public void PNPC_MilkLogic(PNPC npc, float gt)
{
	if (!npc.b_Milked)
	{
		if (gt - 0.1 <= npc.f_MilkEndTime)	//Milk ended naturally within the last 0.1s, remove the particle effect.
			npc.RemoveMilk(true);
	}
}

public void PNPC_JarateLogic(PNPC npc, float gt)
{
	if (!npc.b_Jarated)
	{
		if (gt - 0.1 <= npc.f_JarateEndTime)	//Jarate ended naturally within the last 0.1s, remove the particle effect.
			npc.RemoveJarate(true);
	}
}

public void PNPC_GasLogic(PNPC npc, float gt)
{
	if (!npc.b_Gassed)
	{
		if (gt - 0.1 <= npc.f_GasEndTime)	//Gas ended naturally within the last 0.1s, remove the particle effect.
			npc.RemoveGas(true);
	}
}

public void PNPC_SetMovePose(PNPC npc)
{
	float groundSpeed = npc.GetGroundSpeed();

	if (groundSpeed < 0.01)
	{
		if (npc.i_PoseMoveX >= 0)
			npc.SetPoseParameter(npc.i_PoseMoveX, 0.0);
		if (npc.i_PoseMoveY >= 0)
			npc.SetPoseParameter(npc.i_PoseMoveY, 0.0);
	}
	else
	{
		float front[3], right[3], up[3];
		npc.GetVectors(front, right, up);

		float motion[3];
		npc.GetGroundMotionVector(motion);

		float mult = (1.66 * npc.f_Speed)/npc.f_MaxSpeed;
		if (mult < 0.0)
			mult = 0.0;
		if (mult > 1.0)
			mult = 1.0;

		if (npc.i_PoseMoveX >= 0)
			npc.SetPoseParameter(npc.i_PoseMoveX, GetVectorDotProduct(motion, front) * mult);
		if (npc.i_PoseMoveY >= 0)
			npc.SetPoseParameter(npc.i_PoseMoveY, GetVectorDotProduct(motion, right) * mult);
	}
}

public int Native_PNPCGetIndex(Handle plugin, int numParams) { return GetNativeCell(1); }

public int Native_PNPCSetLogic(Handle plugin, int numParams) 
{ 
	PNPC_Logic[GetNativeCell(1)] = GetNativeFunction(2); 
	return 0; 
}

public any Native_PNPCGetLogicPlugin(Handle plugin, int numParams) { return PNPC_LogicPlugin[GetNativeCell(1)]; }
public int Native_PNPCSetLogicPlugin(Handle plugin, int numParams) 
{ 
	PNPC_LogicPlugin[GetNativeCell(1)] = GetNativeCell(2); 
	return 0; 
}

public any Native_PNPCGetTeam(Handle plugin, int numParams) { return view_as<TFTeam>(GetEntProp(GetNativeCell(1), Prop_Send, "m_iTeamNum")); }
public int Native_PNPCSetTeam(Handle plugin, int numParams) 
{
	int ent = GetNativeCell(1);
	int team = GetNativeCell(2);

	if (team <= view_as<int>(TFTeam_Blue))
		SetEntProp(ent, Prop_Send, "m_iTeamNum", team);
	else
		SetEntProp(ent, Prop_Send, "m_iTeamNum", 4);

	return 0; 
}

public any Native_PNPCGetSkin(Handle plugin, int numParams) { return GetEntProp(GetNativeCell(1), Prop_Send, "m_nSkin"); }
public int Native_PNPCSetSkin(Handle plugin, int numParams) 
{
	int ent = GetNativeCell(1);
	int skin = GetNativeCell(2);
	PNPC npc = view_as<PNPC>(ent);

	if (skin < 0)
	{
		if (npc.i_Team == TFTeam_Red || npc.i_Team == TFTeam_Blue)
			SetEntProp(ent, Prop_Send, "m_nSkin", view_as<int>(npc.i_Team) - 2);
		else
			SetEntProp(ent, Prop_Send, "m_nSkin", 0);
	}
	else
	{
		SetEntProp(ent, Prop_Send, "m_nSkin", skin);
	}

	return 0; 
}

public any Native_PNPCGetScale(Handle plugin, int numParams) { return GetEntPropFloat(GetNativeCell(1), Prop_Send, "m_flModelScale"); }
public int Native_PNPCSetScale(Handle plugin, int numParams) 
{
	int ent = GetNativeCell(1);
	float scale = GetNativeCell(2);
	SetEntPropFloat(ent, Prop_Send, "m_flModelScale", scale);

	return 0; 
}

public any Native_PNPCGetSpeed(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	return npc.GetBaseNPC().flRunSpeed;
}

public int Native_PNPCSetSpeed(Handle plugin, int numParams) 
{
	int ent = GetNativeCell(1);
	float speed = GetNativeCell(2);
	PNPC npc = view_as<PNPC>(ent);
	npc.GetBaseNPC().flRunSpeed = speed;
	npc.GetBaseNPC().flWalkSpeed = speed;

	return 0; 
}

public any Native_PNPCGetMaxSpeed(Handle plugin, int numParams) { return PNPC_Speed[GetNativeCell(1)]; }
public int Native_PNPCSetMaxSpeed(Handle plugin, int numParams) 
{
	PNPC_Speed[GetNativeCell(1)] = GetNativeCell(2);

	return 0; 
}

public any Native_PNPCGetThinkRate(Handle plugin, int numParams) { return PNPC_ThinkRate[GetNativeCell(1)]; }
public int Native_PNPCSetThinkRate(Handle plugin, int numParams) 
{
	int ent = GetNativeCell(1);
	float thinker = GetNativeCell(2);
	PNPC_ThinkRate[ent] = thinker;

	return 0; 
}

public any Native_PNPCGetNextThinkTime(Handle plugin, int numParams) { return PNPC_NextThinkTime[GetNativeCell(1)]; }
public int Native_PNPCSetNextThinkTime(Handle plugin, int numParams) 
{
	int ent = GetNativeCell(1);
	float nextone = GetNativeCell(2);
	PNPC_NextThinkTime[ent] = nextone;

	return 0; 
}

public any Native_PNPCGetEndTime(Handle plugin, int numParams) { return PNPC_EndTime[GetNativeCell(1)]; }
public int Native_PNPCSetEndTime(Handle plugin, int numParams) 
{
	int ent = GetNativeCell(1);
	float theend = GetNativeCell(2);
	PNPC_EndTime[ent] = theend;

	return 0; 
}

public int Native_PNPCGetModel(Handle plugin, int numParams) { SetNativeString(2, PNPC_Model[GetNativeCell(1)], GetNativeCell(3)); return 0; }
public int Native_PNPCSetModel(Handle plugin, int numParams) 
{
	int ent = GetNativeCell(1);
	char newModel[255];
	GetNativeString(2, newModel, sizeof(newModel));
	if (CheckFile(newModel))
	{
		DispatchKeyValue(ent, "model", newModel);
		view_as<CBaseCombatCharacter>(ent).SetModel(newModel);
		
		strcopy(PNPC_Model[ent], 255, newModel);
	}

	return 0; 
}

public int Native_PNPCGetBleedEffect(Handle plugin, int numParams) { SetNativeString(2, PNPC_BleedParticle[GetNativeCell(1)], GetNativeCell(3)); return 0; }
public int Native_PNPCSetBleedEffect(Handle plugin, int numParams) 
{
	int ent = GetNativeCell(1);
	char newBleed[255];
	GetNativeString(2, newBleed, sizeof(newBleed));

	strcopy(PNPC_BleedParticle[ent], 255, newBleed);

	return 0; 
}

public int Native_PNPCGetFlinchSequence(Handle plugin, int numParams) { SetNativeString(2, PNPC_FlinchSequence[GetNativeCell(1)], GetNativeCell(3)); return 0; }
public int Native_PNPCSetFlinchSequence(Handle plugin, int numParams) 
{
	int ent = GetNativeCell(1);
	char newFlinch[255];
	GetNativeString(2, newFlinch, sizeof(newFlinch));

	strcopy(PNPC_FlinchSequence[ent], 255, newFlinch);

	return 0; 
}

public int Native_PNPCSetDamageVFX(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	char newBleed[255], newFlinch[255];
	GetNativeString(2, newBleed, sizeof(newBleed));
	GetNativeString(3, newFlinch, sizeof(newFlinch));

	npc.SetBleedParticle(newBleed);
	npc.SetFlinchSequence(newFlinch);

	return 0;
}

public int Native_PNPCGetHealth(Handle plugin, int numParams) { return GetEntProp(GetNativeCell(1), Prop_Data, "m_iHealth"); }
public int Native_PNPCSetHealth(Handle plugin, int numParams) 
{
	int ent = GetNativeCell(1);
	int hp = GetNativeCell(2);
	SetEntProp(ent, Prop_Data, "m_iHealth", hp);

	return 0; 
}

public int Native_PNPCGetMaxHealth(Handle plugin, int numParams) { return GetEntProp(GetNativeCell(1), Prop_Data, "m_iMaxHealth"); }
public int Native_PNPCSetMaxHealth(Handle plugin, int numParams) 
{
	int ent = GetNativeCell(1);
	int hp = GetNativeCell(2);
	SetEntProp(ent, Prop_Data, "m_iMaxHealth", hp);

	return 0; 
}

public any Native_PNPCGetLocomotion(Handle plugin, int numParams)
{
	CBaseNPC npc = TheNPCs.FindNPCByEntIndex(GetNativeCell(1));
	return npc.GetLocomotion();
}

public any Native_PNPCGetYawRate(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	return npc.GetBaseNPC().flMaxYawRate;
}

public int Native_PNPCSetYawRate(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	npc.GetBaseNPC().flMaxYawRate = GetNativeCell(2);
	return 0;
}

public any Native_PNPCGetStepSize(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	return npc.GetBaseNPC().flStepSize;
}

public int Native_PNPCSetStepSize(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	npc.GetBaseNPC().flStepSize = GetNativeCell(2);
	return 0;
}

public any Native_PNPCGetGravity(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	return npc.GetBaseNPC().flGravity;
}

public int Native_PNPCSetGravity(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	npc.GetBaseNPC().flGravity = GetNativeCell(2);
	return 0;
}

public any Native_PNPCGetAcceleration(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	return npc.GetBaseNPC().flAcceleration;
}

public int Native_PNPCSetAcceleration(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	npc.GetBaseNPC().flAcceleration = GetNativeCell(2);
	return 0;
}

public any Native_PNPCGetJumpHeight(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	return npc.GetBaseNPC().flJumpHeight;
}

public int Native_PNPCSetJumpHeight(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	npc.GetBaseNPC().flJumpHeight = GetNativeCell(2);
	return 0;
}

public any Native_PNPCGetFrictionSideways(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	return npc.GetBaseNPC().flFrictionSideways;
}

public int Native_PNPCSetFrictionSideways(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	npc.GetBaseNPC().flFrictionSideways = GetNativeCell(2);
	return 0;
}

public any Native_PNPCGetFrictionForwards(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	return npc.GetBaseNPC().flFrictionForward;
}

public int Native_PNPCSetFrictionForwards(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	npc.GetBaseNPC().flFrictionForward = GetNativeCell(2);
	return 0;
}

public any Native_PNPCGetDeathDropHeight(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	return npc.GetBaseNPC().flDeathDropHeight;
}

public int Native_PNPCSetDeathDropHeight(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	npc.GetBaseNPC().flDeathDropHeight = GetNativeCell(2);
	return 0;
}

public any Native_PNPCGetBaseNPC(Handle plugin, int numParams)
{
	return TheNPCs.FindNPCByEntIndex(GetNativeCell(1));
}

public any Native_PNPCGetExists(Handle plugin, int numParams) { return IExist[GetNativeCell(1)]; }
public int Native_PNPCSetExists(Handle plugin, int numParams) 
{
	IExist[GetNativeCell(1)] = GetNativeCell(2);

	return 0; 
}

public any Native_PNPCGetForcedGib(Handle plugin, int numParams) { return ForcedToGib[GetNativeCell(1)]; }
public int Native_PNPCSetForcedGib(Handle plugin, int numParams) 
{
	ForcedToGib[GetNativeCell(1)] = GetNativeCell(2);

	return 0; 
}

public any Native_PNPCSetSequence(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	char sequence[255];
	GetNativeString(2, sequence, sizeof(sequence));

	int anim = npc.LookupSequence(sequence);
	if (anim > -1)
	{
		SetEntProp(npc.Index, Prop_Send, "m_nSequence", anim);
		return true;
	}

	return false;
}

public int Native_PNPCLookupActivity(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	char activity[255];
	GetNativeString(2, activity, sizeof(activity));

	Address modelPtr = npc.GetModelPtr();
	if (modelPtr == Address_Null)
		return -1;

	return SDKCall(g_hLookupActivity, modelPtr, activity);
}

public any Native_PNPCSetActivity(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	char activityStr[255];
	GetNativeString(2, activityStr, sizeof(activityStr));

	int activity = npc.LookupActivity(activityStr);
	if (activity > -1)
	{
		int sequence = npc.SelectWeightedSequence(view_as<Activity>(activity));
		if (sequence <= 0)
			return false;

		SetEntProp(npc.Index, Prop_Send, "m_nSequence", sequence);
		npc.SetCycle(0.0);
		npc.SetPlaybackRate(1.0);

		return true;
	}

	return false;
}

public int Native_PNPCSetCycle(Handle plugin, int numParams)
{
	SetEntPropFloat(GetNativeCell(1), Prop_Send, "m_flCycle", GetNativeCell(2));
	return 0;
}

public int Native_PNPCSetPlaybackRate(Handle plugin, int numParams)
{
	SetEntPropFloat(GetNativeCell(1), Prop_Send, "m_flPlaybackRate", GetNativeCell(2));
	return 0;
}

public int Native_PNPCAddGesture(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	char gesture[255];
	GetNativeString(2, gesture, sizeof(gesture));
	bool cancel = GetNativeCell(3);
	float duration = GetNativeCell(4);
	bool autoKill = GetNativeCell(5);
	float rate = GetNativeCell(6);

	int activity = npc.LookupActivity(gesture);
	if (activity <= 0)
		return 0;

	if (cancel)
		view_as<CBaseCombatCharacter>(npc).RestartGesture(view_as<Activity>(activity), true, autoKill);
	else
		view_as<CBaseCombatCharacter>(npc).AddGesture(view_as<Activity>(activity), duration, autoKill);

	int layer = npc.FindGestureLayer(view_as<Activity>(activity));
	if (layer > -1)
		npc.SetLayerPlaybackRate(layer, rate);

	return 0;
}

public int Native_PNPCRemoveGesture(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	char gesture[255];
	GetNativeString(2, gesture, sizeof(gesture));

	int activity = npc.LookupActivity(gesture);
	if (activity <= 0)
		return 0;

	int layer = npc.FindGestureLayer(view_as<Activity>(activity));
	if (layer > -1)
		npc.FastRemoveLayer(layer);

	return 0;
}

public any Native_PNPCGetPathFollower(Handle plugin, int numParams)
{
	return view_as<PathFollower>(view_as<PNPC>(GetNativeCell(1)).GetProp(Prop_Data, "pnpc_pPath"));
}

public int Native_PNPCStartPathing(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	npc.GetPathFollower().SetMinLookAheadDistance(100.0);
	npc.GetLocomotion().Run();

	return 0;
}

public int Native_PNPCStopPathing(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	npc.GetPathFollower().Invalidate();
	npc.GetLocomotion().Stop();

	return 0;
}

public int Native_PNPCSetGoalVector(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	float pos[3];
	GetNativeArray(2, pos, sizeof(pos));
	npc.GetPathFollower().ComputeToPos(npc.GetBot(), pos);
	npc.StartPathing();

	return 0;
}

public int Native_PNPCSetGoalEntity(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	int target = GetNativeCell(2);
	npc.i_PathTarget = target;

	return 0;
}

public int Native_PNPCGetPathTarget(Handle plugin, int numParams) { return EntRefToEntIndex(i_PathTarget[GetNativeCell(1)]); }

public int Native_PNPCSetPathTarget(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	int target = GetNativeCell(2);

	if (IsValidEntity(target))
	{
		if (I_AM_DEAD[target] || (IsValidClient(target) && !IsPlayerAlive(target)))
		{
			npc.StopPathing();
		}
		else
		{
			float pos[3];
			GetEntPropVector(target, Prop_Data, "m_vecOrigin", pos);
			npc.SetGoalVector(pos);
			npc.StartPathing();
		}

		i_PathTarget[npc.Index] = EntIndexToEntRef(target);
	}
	else
	{
		i_PathTarget[npc.Index] = target;
		npc.StopPathing();
	}

	return 0;
}

public any Native_PNPCGetBot(Handle plugin, int numParams)
{
	return view_as<PNPC>(GetNativeCell(1)).MyNextBotPointer();
}

public any Native_PNPCGetGroundSpeed(Handle plugin, int numParams)
{
	return view_as<PNPC>(GetNativeCell(1)).GetLocomotion().GetGroundSpeed();
}

public int Native_PNPCGetPoseMoveX(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	return npc.LookupPoseParameter("move_x");
}

public int Native_PNPCGetPoseMoveY(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	return npc.LookupPoseParameter("move_y");
}

public int Native_PNPCGetGroundMotionVector(Handle plugin, int numParams)
{
	float vec[3];
	CBaseNPC_Locomotion loco = view_as<PNPC>(GetNativeCell(1)).GetLocomotion();
	loco.GetGroundMotionVector(vec);
	SetNativeArray(2, vec, 3);

	return 0;
}

public int Native_PNPCRagdoll(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));

	float ragdollVel[3], override[3];
	GetNativeArray(2, override, sizeof(override));
	if (!Vector_Is_Null(override))
	{
		npc.PunchForce(override, true);
	}

	npc.PunchForce(ragdollVel, false);
	ScaleVector(ragdollVel, 2.0);

	if(ragdollVel[0] == 0.0 || ragdollVel[0] > 10000000.0 || ragdollVel[1] > 10000000.0 || ragdollVel[2] > 10000000.0 || ragdollVel[0] < -10000000.0 || ragdollVel[1] < -10000000.0 || ragdollVel[2] < -10000000.0) //knockback is way too huge. set to 0.
	{
		ragdollVel[0] = 1.0;
		ragdollVel[1] = 1.0;
		ragdollVel[2] = 1.0;
	}

	SDKCall_Ragdoll(npc.Index, ragdollVel);

	return 0;
}

public int Native_PNPCGib(Handle plugin, int numParams)
{
	int ent = GetNativeCell(1);
	PNPC npc = view_as<PNPC>(ent);

	if (g_Gibs[ent] != null)
	{
		for (int i = 0; i < GetArraySize(g_Gibs[ent]); i++)
		{
			char model[255], attachment[255];
			GetArrayString(g_Gibs[ent], i, model, sizeof(model));
			GetArrayString(g_GibAttachments[ent], i, attachment, sizeof(attachment));

			float pos[3], ang[3], vel[3];

			int point;
			if (!StrEqual(attachment, "") && (point = npc.LookupAttachment(attachment)) != 0)
			{
				npc.GetAttachment(point, pos, ang);
			}
			else
			{
				PNPC_WorldSpaceCenter(ent, pos);
				GetEntPropVector(ent, Prop_Data, "m_angRotation", ang);
			}

			npc.PunchForce(vel, false);
			PNPC_SpawnGib(model, npc.i_Skin, pos, ang, vel);
		}
	}

	RemoveEntity(ent);

	return 0;
}

public int Native_PNPCAttachModel(Handle plugin, int numParams)
{
	int ent = GetNativeCell(1);
	PNPC npc = view_as<PNPC>(ent);

	char model[255], attachment[255], sequence[255];
	GetNativeString(2, model, sizeof(model));
	if (!CheckFile(model))
		return -1;

	GetNativeString(3, attachment, sizeof(attachment));
	GetNativeString(4, sequence, sizeof(sequence));
	int skin = GetNativeCell(5);
	float scale = GetNativeCell(6);
	bool bonemerge = GetNativeCell(7);
	bool weapon = GetNativeCell(8);

	int item = CreateEntityByName("prop_dynamic_override");
	if(!IsValidEntity(item))	//Infinitely loop this if it fails to spawn, because apparently TF2 has a very small reason to fail to spawn props.
	{
		return npc.AttachModel(model, attachment, sequence, skin, scale, bonemerge, weapon);
	}

	DispatchKeyValue(item, "model", model);

	if(scale == 1.0)
	{
		DispatchKeyValueFloat(item, "modelscale", GetEntPropFloat(ent, Prop_Send, "m_flModelScale"));
	}
	else
	{
		DispatchKeyValueFloat(item, "modelscale", scale);
	}

	DispatchSpawn(item);
	if (bonemerge)
		SetEntProp(item, Prop_Send, "m_fEffects", EF_BONEMERGE|EF_PARENT_ANIMATES);

	SetEntityMoveType(item, MOVETYPE_NONE);
	SetEntProp(item, Prop_Data, "m_nNextThinkTick", -1.0);
	
	if(!StrEqual(sequence, ""))
	{
		SetVariantString(sequence);
		AcceptEntityInput(item, "SetAnimation");
	}

	SetVariantString("!activator");
	AcceptEntityInput(item, "SetParent", ent);

	if(attachment[0])
	{
		SetVariantString(attachment);
		AcceptEntityInput(item, "SetParentAttachmentMaintainOffset"); 
	}	

	if (skin < 0)
	{
		if (npc.i_Team == TFTeam_Red || npc.i_Team == TFTeam_Blue)
			SetEntProp(item, Prop_Send, "m_nSkin", view_as<int>(npc.i_Team) - 2);
		else
			SetEntProp(item, Prop_Send, "m_nSkin", 0);
	}
	else
	{
		SetEntProp(item, Prop_Send, "m_nSkin", skin);
	}

	if (weapon)
	{
		if (npc.g_AttachedWeapons == null)
			npc.g_AttachedWeapons = new ArrayList(255);

		PushArrayCell(npc.g_AttachedWeapons, EntIndexToEntRef(item));
	}
	else
	{
		if (npc.g_AttachedCosmetics == null)
			npc.g_AttachedCosmetics = new ArrayList(255);

		PushArrayCell(npc.g_AttachedCosmetics, EntIndexToEntRef(item));
	}
		
	PreventAllCollisions(item);

	return item;
}

public void PNPC_SpawnGib(char model[255], int skin, float pos[3], float ang[3], float vel[3])
{
	char skinChar[16];
	IntToString(skin, skinChar, sizeof(skinChar));
	int gib = SpawnPhysicsProp(model, 0, skinChar, 99999.0, true, 1.0, pos, ang, vel, 10.0);
				
	if (IsValidEntity(gib))
	{
		SetEntityCollisionGroup(gib, 1);
		SetEntityRenderMode(gib, RENDER_TRANSALPHA);
		SetEntityCollisionGroup(gib, 1);
		SetEntProp(gib, Prop_Send, "m_iTeamNum", 0);

		CreateTimer(5.0, PNPC_BeginGibFadeout, EntIndexToEntRef(gib), TIMER_FLAG_NO_MAPCHANGE);
	}
}

public Action PNPC_BeginGibFadeout(Handle timer, int ref)
{
	int gib = EntRefToEntIndex(ref);
	if (IsValidEntity(gib))
	{
		MakeEntityFadeOut(gib, 2);
	}

	return Plugin_Continue;
}

public int Native_PNPCAddGib(Handle plugin, int numParams)
{
	int ent = GetNativeCell(1);

	char model[255], attachment[255];
	GetNativeString(2, model, sizeof(model));
	if (!CheckFile(model))
		return 0;

	GetNativeString(3, attachment, sizeof(attachment));

	if (g_Gibs[ent] == null)
		g_Gibs[ent] = new ArrayList(255);
	if (g_GibAttachments[ent] == null)
		g_GibAttachments[ent] = new ArrayList(255);

	g_Gibs[ent].PushString(model);
	g_GibAttachments[ent].PushString(attachment);

	return 0;
}
public int Native_PNPCPunchForce(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	bool override = GetNativeCell(3);

	if (override)
	{
		float pos[3];
		GetNativeArray(2, pos, sizeof(pos));

		for (int i = 0; i < 3; i++)
			f_PunchForce[npc.Index][i] = pos[i];
	}
	else
	{
		SetNativeArray(2, f_PunchForce[npc.Index], 3);
	}

	return 0;
}

public void SDKCall_Ragdoll(int entity, float vel[3])
{
	view_as<PNPC>(entity).RemoveAttachments();
	SDKCall(SDK_Ragdoll, entity, vel);
}

public any Native_PNPCGetAttachedCosmetics(Handle plugin, int numParams) { return g_AttachedModels[GetNativeCell(1)]; }
public int Native_PNPCSetAttachedCosmetics(Handle plugin, int numParams)
{
	g_AttachedModels[GetNativeCell(1)] = GetNativeCell(2);

	return 0;
}

public any Native_PNPCGetAttachedWeapons(Handle plugin, int numParams) { return g_AttachedWeaponModels[GetNativeCell(1)]; }
public int Native_PNPCSetAttachedWeapons(Handle plugin, int numParams)
{
	g_AttachedWeaponModels[GetNativeCell(1)] = GetNativeCell(2);

	return 0;
}

public int Native_PNPCRemoveAttachments(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));

	if (GetNativeCell(2) && npc.g_AttachedCosmetics != null)
	{
		for (int i = 0; i < GetArraySize(npc.g_AttachedCosmetics); i++)
		{
			int ent = EntRefToEntIndex(GetArrayCell(npc.g_AttachedCosmetics, i));
			if (IsValidEntity(ent))
				RemoveEntity(ent);
		}

		delete npc.g_AttachedCosmetics;
	}

	if (GetNativeCell(3) && npc.g_AttachedWeapons != null)
	{
		for (int i = 0; i < GetArraySize(npc.g_AttachedWeapons); i++)
		{
			int ent = EntRefToEntIndex(GetArrayCell(npc.g_AttachedWeapons, i));
			if (IsValidEntity(ent))
				RemoveEntity(ent);
		}

		delete npc.g_AttachedWeapons;
	}

	return 0;
}

public any Native_PNPCGetAfterburnEndTime(Handle plugin, int numParams) { return f_AfterburnEndTime[GetNativeCell(1)]; }
public int Native_PNPCSetAfterburnEndTime(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	float endTime = GetNativeCell(2);

	if (endTime > GetGameTime())
	{
		if (!npc.b_Burning)
		{
			f_NextBurn[npc.Index] = GetGameTime() + 0.5;

			if (npc.b_AfterburnIsHaunted)
				AttachParticle_TE(npc.Index, VFX_AFTERBURN_HAUNTED);
			else
				AttachParticle_TE(npc.Index, npc.i_Team == TFTeam_Red ? VFX_AFTERBURN_RED : VFX_AFTERBURN_BLUE);
		}

		f_AfterburnEndTime[npc.Index] = endTime;
	}
	else
	{
		if (npc.b_Burning)
		{
			f_NextBurn[npc.Index] = 0.0;
			
			if (npc.b_AfterburnIsHaunted)
				RemoveParticle_TE(npc.Index, VFX_AFTERBURN_HAUNTED);
			else
				RemoveParticle_TE(npc.Index, npc.i_Team == TFTeam_Red ? VFX_AFTERBURN_RED : VFX_AFTERBURN_BLUE);
		}

		f_AfterburnEndTime[npc.Index] = 0.0;
	}

	return 0;
}

public any Native_PNPCGetBurning(Handle plugin, int numParams) { return f_AfterburnEndTime[GetNativeCell(1)] >= GetGameTime(); }

public any Native_PNPCGetAfterburnDMG(Handle plugin, int numParams) { return f_AfterburnDMG[GetNativeCell(1)]; }
public int Native_PNPCSetAfterburnDMG(Handle plugin, int numParams) { f_AfterburnDMG[GetNativeCell(1)] = GetNativeCell(2); return 0; }

public int Native_PNPCGetAfterburnAttacker(Handle plugin, int numParams) { return GetClientOfUserId(i_AfterburnAttacker[GetNativeCell(1)]); }
public int Native_PNPCSetAfterburnAttacker(Handle plugin, int numParams)
{ 
	int client = GetNativeCell(2);
	if (!IsValidClient(client))
		i_AfterburnAttacker[GetNativeCell(1)] = -1;
	else
		i_AfterburnAttacker[GetNativeCell(1)] = GetClientUserId(client);

	return 0;
}

public any Native_PNPCGetAfterburnHaunted(Handle plugin, int numParams) { return b_AfterburnHaunted[GetNativeCell(1)]; }
public int Native_PNPCSetAfterburnHaunted(Handle plugin, int numParams)
{ 
	PNPC npc = view_as<PNPC>(GetNativeCell(1));

	if (npc.b_AfterburnIsHaunted)
		RemoveParticle_TE(npc.Index, VFX_AFTERBURN_HAUNTED);
	else
		RemoveParticle_TE(npc.Index, npc.i_Team == TFTeam_Red ? VFX_AFTERBURN_RED : VFX_AFTERBURN_BLUE);

	b_AfterburnHaunted[npc.Index] = GetNativeCell(2);

	if (npc.b_Burning)
	{
		if (npc.b_AfterburnIsHaunted)
			AttachParticle_TE(npc.Index, VFX_AFTERBURN_HAUNTED);
		else
			AttachParticle_TE(npc.Index, npc.i_Team == TFTeam_Red ? VFX_AFTERBURN_RED : VFX_AFTERBURN_BLUE);
	}

	return 0;
}

public any Native_PNPCIgnite(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));

	float burnTime = GetNativeCell(2);
	float minBurnTime = GetNativeCell(3);
	float maxBurnTime = GetNativeCell(4);
	float burnDMG = GetNativeCell(5);
	bool haunted = GetNativeCell(6);
	int attacker = GetNativeCell(7);

	float gt = GetGameTime();

	Action result = Plugin_Continue;

	Call_StartForward(g_OnPNPCIgnited);
	Call_PushCell(npc);
	Call_PushFloatRef(burnTime);
	Call_PushFloatRef(minBurnTime);
	Call_PushFloatRef(maxBurnTime);
	Call_PushCellRef(attacker);
	Call_PushCellRef(haunted);
	Call_PushFloatRef(burnDMG);
	Call_Finish(result);
		
	if (result != Plugin_Handled && result != Plugin_Stop)
	{
		bool AddDirectly = false;
		if (npc.b_Burning)
		{
			float current = npc.f_AfterburnEndTime - gt;

			if (current + burnTime >= maxBurnTime && maxBurnTime > 0.0)
			{
				current += burnTime;
				if (current > maxBurnTime)
				{
					burnTime = maxBurnTime;
				}
			}
			else if (current + burnTime < minBurnTime)
			{
				burnTime = (minBurnTime - current);
			}
			else
			{
				AddDirectly = true;
			}
		}
		else if (burnTime < minBurnTime)
		{
			burnTime = minBurnTime;
		}

		if (!AddDirectly)
			npc.f_AfterburnEndTime = gt + burnTime;
		else
			npc.f_AfterburnEndTime += burnTime;

		npc.i_AfterburnAttacker = attacker;
		npc.b_AfterburnIsHaunted = haunted;
		npc.f_AfterburnDMG = burnDMG;
	}

	return true;
}

public any Native_PNPCExtinguish(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	bool forced = GetNativeCell(2);

	bool result = true;

	Call_StartForward(g_OnPNPCExtinguished);
	Call_PushCell(npc);
	Call_Finish(result);

	if (result || forced)
	{
		npc.f_AfterburnEndTime = 0.0;
		npc.b_AfterburnIsHaunted = false;
		npc.i_AfterburnAttacker = 0;
		npc.f_AfterburnDMG = 0.0;
	}
	else
	{
		float gt = GetGameTime();

		npc.f_AfterburnEndTime = gt + 1.0;
		f_NextBurn[npc.Index] = gt + 0.5;
	}

	return result;
}

public any Native_PNPCBleed(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));

	float bleedTime = GetNativeCell(2);
	float bleedDMG = GetNativeCell(3);
	int attacker = GetNativeCell(4);

	Call_StartForward(g_OnPNPCBleed);

	Call_PushCell(npc);
	Call_PushFloatRef(bleedTime);
	Call_PushFloatRef(bleedDMG);
	Call_PushCellRef(attacker);

	Action result;
	Call_Finish(result);

	if (result != Plugin_Stop && result != Plugin_Handled)
	{
		DataPack pack = new DataPack();
		CreateDataTimer(0.5, PNPC_BleedTimer, pack, TIMER_REPEAT|TIMER_FLAG_NO_MAPCHANGE);
		WritePackCell(pack, EntIndexToEntRef(npc.Index));
		WritePackFloat(pack, GetGameTime() + bleedTime + 0.1);
		WritePackFloat(pack, bleedDMG);
		WritePackCell(pack, EntIndexToEntRef(attacker));

		i_BleedStacks[npc.Index]++;

		return true;
	}

	return false;
}

public Action PNPC_BleedTimer(Handle bleed, DataPack pack)
{
	ResetPack(pack);
	int npc = EntRefToEntIndex(ReadPackCell(pack));
	if (!IsValidEntity(npc))
		return Plugin_Stop;

	if (I_AM_DEAD[npc])
		return Plugin_Stop;

	float endTime = ReadPackFloat(pack);
	if (GetGameTime() >= endTime)
	{
		i_BleedStacks[npc]--;
		return Plugin_Stop;
	}

	float dmg = ReadPackFloat(pack);
	int attacker = EntRefToEntIndex(ReadPackCell(pack));

	SDKHooks_TakeDamage(npc, 0, IsValidEntity(attacker) ? attacker : 0, dmg, _, _, _, _, false);
	return Plugin_Continue;
}

public any Native_PNPCGetBleeding(Handle plugin, int numParams) { return i_BleedStacks[GetNativeCell(1)] > 0; }

public int Native_PNPCModifySpeed(Handle plugin, int numParams) 
{ 
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	float mod = GetNativeCell(2);
	int mode = GetNativeCell(3);
	float duration = GetNativeCell(4);

	float diff;
	if (mode <= 0)
	{
		float current = npc.f_MaxSpeed;
		current *= mod;
		diff = current - npc.f_MaxSpeed;
	}
	else
	{
		if (mode == 1)
		{
			float current = npc.f_Speed;
			current *= mod;
			diff = current - npc.f_Speed;
		}
		else
		{
			diff = mod;
		}
	}

	npc.f_Speed += diff;
	if (npc.f_Speed < 0.0)
	{
		diff += npc.f_Speed;
		npc.f_Speed = 0.0;
	}

	DataPack pack = new DataPack();
	CreateDataTimer(duration, PNPC_RemoveTemporarySpeedChange, pack, TIMER_FLAG_NO_MAPCHANGE);
	WritePackCell(pack, EntIndexToEntRef(npc.Index));
	WritePackFloat(pack, diff);

	return 0;
}

public Action PNPC_RemoveTemporarySpeedChange(Handle timer, DataPack pack)
{
	ResetPack(pack);

	int ent = EntRefToEntIndex(ReadPackCell(pack));
	float diff = ReadPackFloat(pack);

	if (!IsValidEntity(ent))
		return Plugin_Continue;

	view_as<PNPC>(ent).f_Speed -= diff;

	return Plugin_Continue;
}

public int Native_PNPCSetBoundingBox(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	float mins[3], maxs[3];
	GetNativeArray(2, mins, sizeof(mins));
	GetNativeArray(3, maxs, sizeof(maxs));

	float scale = 1.1;	//We always scale 10% bigger because otherwise certain projectiles (balls, cleavers, jars) harmlessly bounce off at certain angles.
	if (GetNativeCell(4))
	{
		scale *= npc.f_Scale;
	}

	ScaleVector(mins, scale);
	ScaleVector(maxs, scale);

	npc.GetBaseNPC().SetBodyMaxs(maxs);
	npc.GetBaseNPC().SetBodyMins(mins);

	SetEntPropVector(npc.Index, Prop_Data, "m_vecMaxs", maxs);
	SetEntPropVector(npc.Index, Prop_Data, "m_vecMins", mins);

	return 0;
}

Handle PNPC_HitByBlast = null;

public int Native_PNPCExplosion(Handle plugin, int numParams)
{
	float pos[3];
	GetNativeArray(1, pos, sizeof(pos));
	float radius = GetNativeCell(2);
	float damage = GetNativeCell(3);
	float falloffStartRange = GetNativeCell(4);
	float falloffEndRange = GetNativeCell(5);
	float falloffMax = GetNativeCell(6);
	int inflictor = GetNativeCell(7);
	int weapon = GetNativeCell(8);
	int attacker = GetNativeCell(9);
	int damageType = GetNativeCell(10);
	bool skipLOS = GetNativeCell(11);
	bool ignoreInvuln = GetNativeCell(12);
	bool hitAttacker = GetNativeCell(13);

	char filterPlugin[255], hitPlugin[255];
	Function filterFunction = GetNativeFunction(14);
	GetNativeString(15, filterPlugin, sizeof(filterPlugin));
	Function hitFunction = GetNativeFunction(16);
	GetNativeString(17, hitPlugin, sizeof(hitPlugin));

	//Always assume invalid attacker entities are the console, otherwise we crash the server.
	if (attacker < 0)
		attacker = 0;

	delete PNPC_HitByBlast;
	PNPC_HitByBlast = CreateArray(255);
	
	TR_EnumerateEntitiesSphere(pos, radius, PARTITION_NON_STATIC_EDICTS, PNPC_BlastTrace, attacker);

	for (int i = 0; i < GetArraySize(PNPC_HitByBlast); i++)
	{
		int victim = EntRefToEntIndex(GetArrayCell(PNPC_HitByBlast, i));
		if (IsValidEntity(victim))
		{
			if (IsValidClient(victim))
			{
				if (!IsPlayerAlive(victim) || (IsInvuln(victim) && !ignoreInvuln) || (victim == attacker && !hitAttacker))
					continue;
			}

			if (!GetEntProp(victim, Prop_Data, "m_takedamage") && !ignoreInvuln)
				continue;
			
			float vicLoc[3];
			PNPC_WorldSpaceCenter(victim, vicLoc);
			
			bool passed = true;

			if (filterFunction != INVALID_FUNCTION && !StrEqual(filterPlugin, ""))
			{
				Call_StartFunction(GetPluginHandle(filterPlugin), filterFunction);
				Call_PushCell(victim);
				Call_PushCellRef(attacker);
				Call_PushCellRef(inflictor);
				Call_PushCellRef(weapon);
				Call_PushFloatRef(damage);
				Call_Finish(passed);
			}

			if (!skipLOS && passed)
			{
				Handle trace = TR_TraceRayFilterEx(pos, vicLoc, MASK_PLAYERSOLID_BRUSHONLY, RayType_EndPoint, PNPC_AOETrace, victim);
				passed = !TR_DidHit(trace);
				delete trace;
			}
					
			if (passed)
			{
				float dist = GetVectorDistance(pos, vicLoc);

				float realDMG = damage;
				if (dist > falloffStartRange && falloffStartRange >= 0.0)
				{
					realDMG *= 1.0 - (((dist - falloffStartRange) / (falloffEndRange - falloffStartRange)) * falloffMax);
				}
				
				//If the weapon is valid and the victim is a building or prop_physics, deal damage multiplied by building damage attributes:
				if (IsValidEntity(weapon))
				{
					char classname[255];
					GetEntityClassname(victim, classname, sizeof(classname));

					if (GetEntSendPropOffs(weapon, "m_AttributeList") > 0 && (StrEqual(classname, "obj_sentrygun") || StrEqual(classname, "obj_dispenser")
					|| StrEqual(classname, "obj_teleporter") || StrContains(classname, "prop_physics") != -1))
					{
						realDMG *= GetAttributeValue(weapon, 137, 1.0) * GetAttributeValue(weapon, 775, 1.0);
					}
				}

				if (hitFunction != INVALID_FUNCTION && !StrEqual(hitPlugin, ""))
				{
					Call_StartFunction(GetPluginHandle(hitPlugin), hitFunction);
					Call_PushCell(victim);
					Call_PushCellRef(attacker);
					Call_PushCellRef(inflictor);
					Call_PushCellRef(weapon);
					Call_PushFloatRef(realDMG);
					Call_Finish();
				}

				SDKHooks_TakeDamage(victim, inflictor, attacker, realDMG, damageType, weapon, _, pos, false);
			}
		}
	}
	
	delete PNPC_HitByBlast;

	return 0;
}

public bool PNPC_BlastTrace(int entity, int attacker)
{
	//If the victim does not have a team affiliation: never hit.
	if (!HasEntProp(entity, Prop_Send, "m_iTeamNum"))
		return true;
	
	//If the attacker is not a valid entity or is the console: always hit.
	if (!IsValidEntity(attacker) || attacker <= 0)
	{
		PushArrayCell(PNPC_HitByBlast, EntIndexToEntRef(entity));
		return true;
	}

	//If the attacker does not have a team affiliation: always hit.
	if (!HasEntProp(attacker, Prop_Send, "m_iTeamNum"))
	{
		PushArrayCell(PNPC_HitByBlast, EntIndexToEntRef(entity));
		return true;
	}

	//If the victim is not on the attacker's team, or the victim IS the attacker: always hit.
	if (GetEntProp(entity, Prop_Send, "m_iTeamNum") != GetEntProp(attacker, Prop_Send, "m_iTeamNum") || (entity == attacker))
	{
		PushArrayCell(PNPC_HitByBlast, EntIndexToEntRef(entity));
		return true;
	}
	
	return true;
}

public bool PNPC_AOETrace(entity, contentsmask, target)
{
	if (!PNPC_LOSCheck(entity, contentsmask))
		return false;
		
	return entity != target;
}

public bool PNPC_LOSCheck(entity, contentsMask)
{
	if (entity <= MaxClients || PNPC_IsNPC(entity))
		return false;
	
	char classname[255];
	GetEntityClassname(entity, classname, sizeof(classname));
	
	if (StrContains(classname, "tf_projectile") != -1 || StrContains(classname, "info_") != -1 || StrContains(classname, "trigger_") != -1 || StrContains(classname, "prop_physics") != -1)
		return false;
		
	if (StrContains(classname, "func_") != -1)
	{
		if (!StrEqual("func_brush", classname)
			&& !StrEqual("func_door", classname) && !StrEqual("func_detail", classname) && !StrEqual("func_wall", classname) && !StrEqual("func_rotating", classname)
			&& !StrEqual("func_reflective_glass", classname) && !StrEqual("func_physbox", classname) && !StrEqual("func_movelinear", classname) && !StrEqual("func_door_rotating", classname)
			&& !StrEqual("func_breakable", classname))
		{
			return false;
		}
	}
		
	return true;
}

public any Native_PNPCIsThisAnNPC(Handle plugin, int numParams)
{
	int ent = GetNativeCell(1);

	if (!IsValidEntity(ent))
		return false;

	char classname[255];
	GetEntityClassname(ent, classname, sizeof(classname));

	if (StrContains(classname, "base_boss") != -1)
		return true;

	return view_as<PNPC>(ent).b_Exists;
}

public any Native_PNPCGetMilked(Handle plugin, int numParams) { return f_MilkEndTime[GetNativeCell(1)] > GetGameTime(); }

public any Native_PNPCGetMilkEndTime(Handle plugin, int numParams) { return f_MilkEndTime[GetNativeCell(1)]; }

public int Native_PNPCSetMilkEndTime(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	float endTime = GetNativeCell(2);

	if (endTime > GetGameTime())
	{
		if (!npc.b_Milked)
		{
			AttachParticle_TE(npc.Index, VFX_MILK);
		}

		f_MilkEndTime[npc.Index] = endTime;
	}
	else
	{
		RemoveParticle_TE(npc.Index, VFX_MILK);
		f_MilkEndTime[npc.Index] = 0.0;
	}

	return 0;
}

public int Native_PNPCGetMilker(Handle plugin, int numParams) { return EntRefToEntIndex(i_Milker[GetNativeCell(1)]); }

public int Native_PNPCSetMilker(Handle plugin, int numParams)
{
	int victim = GetNativeCell(1);
	int milker = GetNativeCell(2);

	if (IsValidEntity(milker))
		i_Milker[victim] = EntIndexToEntRef(milker);
	else
		i_Milker[victim] = milker;

	return 0;
}

public any Native_PNPCApplyMilk(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	float duration = GetNativeCell(2);
	int attacker = GetNativeCell(3);
	float gt = GetGameTime();

	bool success = true;
	Action result;

	Call_StartForward(g_OnPNPCMilked);

	Call_PushCell(npc);
	Call_PushFloatRef(duration);
	Call_PushCellRef(attacker);

	Call_Finish(result);
	success = result != Plugin_Stop && result != Plugin_Handled;

	if (success)
	{
		if (gt > npc.f_MilkEndTime)
			npc.f_MilkEndTime = gt + duration;
		else
			npc.f_MilkEndTime += duration;
		
		npc.i_Milker = attacker;
	}

	return success;
}

public any Native_PNPCRemoveMilk(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	bool forced = GetNativeCell(2);

	bool success = true;

	Call_StartForward(g_OnPNPCMilkRemoved);

	Call_PushCell(npc);
	Call_PushCell(npc.i_Milker);

	Call_Finish(success);

	if (!success)
		success = forced;

	if (success)
	{
		npc.f_MilkEndTime = 0.0;
		npc.i_Milker = -1;
	}

	return success;
}

public any Native_PNPCHealEntity(Handle plugin, int numParams)
{
	int target = GetNativeCell(1);
	int amount = GetNativeCell(2);
	float maxHeal = GetNativeCell(3);
	int healer = GetNativeCell(4);

	int maxHP = TF2Util_GetEntityMaxHealth(target);
	int totalMax = RoundFloat(float(maxHP) * maxHeal);
	int current = GetEntProp(target, Prop_Send, "m_iHealth");
	
	bool success = true;

	Call_StartForward(g_OnHeal);

	Call_PushCell(target);
	Call_PushCellRef(amount);
	Call_PushFloatRef(maxHeal);
	Call_PushCellRef(healer);

	Call_Finish(success);

	if (current < totalMax && success)
	{
		int newHP = current + amount;
		if (newHP > totalMax)
		{
			int diff = newHP - totalMax;
			newHP -= diff;
		}
		
		SetEntProp(target, Prop_Send, "m_iHealth", newHP);
	}

	return success;
}

public any Native_PNPCGetJarated(Handle plugin, int numParams) { return f_JarateEndTime[GetNativeCell(1)] > GetGameTime(); }

public any Native_PNPCGetJarateEndTime(Handle plugin, int numParams) { return f_JarateEndTime[GetNativeCell(1)]; }

public int Native_PNPCSetJarateEndTime(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	float endTime = GetNativeCell(2);

	if (endTime > GetGameTime())
	{
		if (!npc.b_Jarated)
		{
			AttachParticle_TE(npc.Index, VFX_JARATE);
		}

		f_JarateEndTime[npc.Index] = endTime;
	}
	else
	{
		RemoveParticle_TE(npc.Index, VFX_JARATE);
		f_JarateEndTime[npc.Index] = 0.0;
	}

	return 0;
}

public int Native_PNPCGetJarateApplicant(Handle plugin, int numParams) { return EntRefToEntIndex(i_Jarater[GetNativeCell(1)]); }

public int Native_PNPCSetJarateApplicant(Handle plugin, int numParams)
{
	int victim = GetNativeCell(1);
	int jarater = GetNativeCell(2);

	if (IsValidEntity(jarater))
		i_Jarater[victim] = EntIndexToEntRef(jarater);
	else
		i_Jarater[victim] = jarater;

	return 0;
}

public any Native_PNPCApplyJarate(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	float duration = GetNativeCell(2);
	int attacker = GetNativeCell(3);
	float gt = GetGameTime();

	bool success = true;
	Action result;

	Call_StartForward(g_OnPNPCJarated);

	Call_PushCell(npc);
	Call_PushFloatRef(duration);
	Call_PushCellRef(attacker);

	Call_Finish(result);
	success = result != Plugin_Stop && result != Plugin_Handled;

	if (success)
	{
		if (gt > npc.f_JarateEndTime)
			npc.f_JarateEndTime = gt + duration;
		else
			npc.f_JarateEndTime += duration;
		
		npc.i_JarateApplicant = attacker;
	}

	return success;
}

public any Native_PNPCRemoveJarate(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	bool forced = GetNativeCell(2);

	bool success = true;

	Call_StartForward(g_OnPNPCJarateRemoved);

	Call_PushCell(npc);
	Call_PushCell(npc.i_JarateApplicant);

	Call_Finish(success);

	if (!success)
		success = forced;

	if (success)
	{
		npc.f_JarateEndTime = 0.0;
		npc.i_JarateApplicant = -1;
	}

	return success;
}

public any Native_PNPCGetGassed(Handle plugin, int numParams) { return f_GasEndTime[GetNativeCell(1)] > GetGameTime(); }

public any Native_PNPCGetGasEndTime(Handle plugin, int numParams) { return f_GasEndTime[GetNativeCell(1)]; }

public int Native_PNPCSetGasEndTime(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	float endTime = GetNativeCell(2);

	if (endTime > GetGameTime())
	{
		if (!npc.b_Gassed)
		{
			AttachParticle_TE(npc.Index, npc.i_Team == TFTeam_Red ? VFX_GAS_RED : VFX_GAS_BLUE);
		}

		f_GasEndTime[npc.Index] = endTime;
	}
	else
	{
		RemoveParticle_TE(npc.Index, VFX_GAS_RED);
		RemoveParticle_TE(npc.Index, VFX_GAS_BLUE);
		f_GasEndTime[npc.Index] = 0.0;
	}

	return 0;
}

public int Native_PNPCGetGasApplicant(Handle plugin, int numParams) { return EntRefToEntIndex(i_Gasser[GetNativeCell(1)]); }

public int Native_PNPCSetGasApplicant(Handle plugin, int numParams)
{
	int victim = GetNativeCell(1);
	int gasser = GetNativeCell(2);

	if (IsValidEntity(gasser))
		i_Gasser[victim] = EntIndexToEntRef(gasser);
	else
		i_Gasser[victim] = gasser;

	return 0;
}

public any Native_PNPCApplyGas(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	float duration = GetNativeCell(2);
	int attacker = GetNativeCell(3);
	float gt = GetGameTime();

	bool success = true;
	Action result;

	Call_StartForward(g_OnPNPCGassed);

	Call_PushCell(npc);
	Call_PushFloatRef(duration);
	Call_PushCellRef(attacker);

	Call_Finish(result);
	success = result != Plugin_Stop && result != Plugin_Handled;

	if (success)
	{
		if (gt > npc.f_GasEndTime)
			npc.f_GasEndTime = gt + duration;
		else
			npc.f_GasEndTime += duration;
		
		npc.i_GasApplicant = attacker;
	}

	return success;
}

public any Native_PNPCRemoveGas(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	bool forced = GetNativeCell(2);

	bool success = true;

	Call_StartForward(g_OnPNPCGasRemoved);

	Call_PushCell(npc);
	Call_PushCell(npc.i_GasApplicant);

	Call_Finish(success);

	if (!success)
		success = forced;

	if (success)
	{
		npc.f_GasEndTime = 0.0;
		npc.i_GasApplicant = -1;
	}

	return success;
}

public Action PNPC_PassFilter(int ent1, int ent2, bool &result)
{
	if (!PNPC_IsNPC(ent1) && !PNPC_IsNPC(ent2))
		return Plugin_Continue;

	if (b_IsProjectile[ent1] || b_IsProjectile[ent2])
	{
		if (b_IsInUpdateGroundConstraint)
		{
			result = false;
			return Plugin_Changed;
		}
		else
		{
			result = GetEntProp(ent1, Prop_Send, "m_iTeamNum") != GetEntProp(ent2, Prop_Send, "m_iTeamNum");
			return Plugin_Changed;
		}
	}

	return Plugin_Continue;
}

public Native_PNPC_IsValidTarget(Handle plugin, int numParams)
{
	int entity = GetNativeCell(1);
	TFTeam team = GetNativeCell(2);
	char pluginName[255];
	GetNativeString(3, pluginName, sizeof(pluginName));
	Function filter = GetNativeFunction(4);
	
	if (!IsValidEntity(entity))
		return false;
		
	if (team != TFTeam_Unassigned)
	{
		if (!HasEntProp(entity, Prop_Send, "m_iTeamNum"))
			return false;
			
		TFTeam entTeam = view_as<TFTeam>(GetEntProp(entity, Prop_Send, "m_iTeamNum"));
		if (team != entTeam)
			return false;
	}
	
	if (!StrEqual(pluginName, "") && filter != INVALID_FUNCTION)
	{
		Handle FunctionPlugin = GetPluginHandle(pluginName);
	
		bool result;
			
		if (FunctionPlugin == INVALID_HANDLE)
		{
			result = true;
		}
		else
		{
			Call_StartFunction(FunctionPlugin, filter);
				
			Call_PushCell(entity);
				
			Call_Finish(result);
		}
		
		delete FunctionPlugin;
		
		return result;
	}
	
	return true;
}

public Native_PNPC_WorldSpaceCenter(Handle plugin, int numParams)
{
	int entity = GetNativeCell(1);
	float output[3];
	GetNativeArray(2, output, sizeof(output));
	
	if (!IsValidEntity(entity))
		return;
		
	SDKCall(g_hSDKWorldSpaceCenter, entity, output);
	SetNativeArray(2, output, sizeof(output));
}

public Native_PNPC_GetClosestTarget(Handle plugin, int numParams)
{
	float pos[3];
	GetNativeArray(1, pos, sizeof(pos));
	
	bool IncludeEntities = GetNativeCell(2);
	
	float closestDist = GetNativeCellRef(3);
	float maxDist = GetNativeCell(4);
	TFTeam team = GetNativeCell(5);
	char pluginName[255];
	GetNativeString(6, pluginName, sizeof(pluginName));
	Function filter = GetNativeFunction(7);
	
	int closestEnt = -1;
	
	for (int i = 1; i <= (IncludeEntities ? 2048 : MaxClients); i++)
	{
		if (!PNPC_IsValidTarget(i, team, pluginName, filter))
			continue;
		
		float otherPos[3];
		PNPC_WorldSpaceCenter(i, otherPos);
		
		float dist = GetVectorDistance(pos, otherPos);
		
		if (maxDist > 0.0 && dist > maxDist)
			continue;
			
		if (dist < closestDist || closestEnt == -1)
		{
			closestDist = dist;
			closestEnt = i;
		}
	}
	
	return closestEnt;
}

public any Native_PNPC_PlayRandomSound(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	char cue[255], config[255];
	GetNativeString(2, cue, sizeof(cue));
	Format(cue, sizeof(cue), "npc.sounds.%s", cue);
	npc.GetConfigName(config, sizeof(config));

	Format(config, sizeof(config), "configs/npcs/%s.cfg", config);

	//Check 1: Does our NPC even have a ConfigMap?
	ConfigMap conf = new ConfigMap(config);
	if (conf == null)
		return false;

	//Check 2: Our NPC has a ConfigMap, but does their sounds section actually have an entry for our cue?
	ConfigMap cueSection = conf.GetSection(cue);
	if (cueSection == null)
	{
		DeleteCfg(conf);
		return false;
	}

	StringMapSnapshot snap = cueSection.Snapshot();
	int chosen = GetRandomInt(0, snap.Length - 1);

	char key[255], realKey[255];
	snap.GetKey(chosen, key, sizeof(key));
	delete snap;

	strcopy(realKey, sizeof(realKey), key);

	if (StrContains(key, ".") != -1)
	{
		ReplaceString(key, sizeof(key), ".", "\\.");
	}

	char soundToPlay[255];

	KeyValType KVT = cueSection.GetKeyValType(key);
	//Check 3: We do indeed have an entry for our cue, use it to get the sound we are attempting to play.
	switch(cueSection.GetKeyValType(key))
	{
		case KeyValType_Value:
		{
			cueSection.Get(key, soundToPlay, sizeof(soundToPlay));
		}
		case KeyValType_Section:
		{
			strcopy(soundToPlay, sizeof(soundToPlay), realKey);
		}
		default:	//This should literally never be possible, but we can never be too safe...
		{
			DeleteCfg(conf);
			return false;
		}
	}

	//Check 4: Make sure our sound actually exists before we attempt to play it.
	if (!CheckFile(soundToPlay))
	{
		DeleteCfg(conf);
		return false;
	}

	PrecacheSound(soundToPlay);

	int level = 100;
	float volume = 1.0;
	int channel = SNDCHAN_VOICE;
	bool global = false;
	int maxPitch = 100;
	int minPitch = 100;
	bool success = true;

	if (KVT == KeyValType_Section)
	{
		Format(cue, sizeof(cue), "%s.%s", cue, key);
		ConfigMap soundSection = conf.GetSection(cue);

		if (soundSection != null)
		{
			success = GetRandomFloat(0.0, 1.0) <= GetFloatFromConfigMap(soundSection, "chance", 1.0);
			if (success)
			{
				level = GetIntFromConfigMap(soundSection, "level", 100);
				volume = GetFloatFromConfigMap(soundSection, "volume", 1.0);
				channel = GetIntFromConfigMap(soundSection, "channel", 7);
				global = GetBoolFromConfigMap(soundSection, "global", false);
				minPitch = GetIntFromConfigMap(soundSection, "pitch_min", 100);
				maxPitch = GetIntFromConfigMap(soundSection, "pitch_max", 100);
			}
		}
		else
		{
			DeleteCfg(conf);
			return false;
		}
	}

	if (success)
	{
		if (global)
			EmitSoundToAll(soundToPlay, _, channel, level, _, volume, GetRandomInt(minPitch, maxPitch));
		else
			EmitSoundToAll(soundToPlay, npc.Index, channel, level, _, volume, GetRandomInt(minPitch, maxPitch));
	}

	DeleteCfg(conf);

	return success;
}

public any Native_PNPC_GetConfigMap(Handle plugin, int numParams)
{
	char filePath[255];
	Format(filePath, sizeof(filePath), "configs/npcs/%s.cfg", PNPC_ConfigName[GetNativeCell(1)]);
	return new ConfigMap(filePath);
}

public int Native_PNPCSetGibsFromConfig(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));

	ConfigMap conf = npc.GetConfigMap();
	if (conf == null)
		return 0;

	int autofill = GetIntFromConfigMap(conf, "npc.visuals.autofill_gibs", 0);
	if (autofill > 0 && autofill < 10)
	{
		npc.ClearGibs();

		switch(autofill)
		{
			case 1:
			{
				for (int i = 0; i < sizeof(Gibs_Scout_Models); i++)
					npc.AddGib(Gibs_Scout_Models[i], Gibs_Scout_Attachments[i]);
			}
			case 2:
			{
				for (int i = 0; i < sizeof(Gibs_Soldier_Models); i++)
					npc.AddGib(Gibs_Soldier_Models[i], Gibs_Soldier_Attachments[i]);
			}
			case 3:
			{
				for (int i = 0; i < sizeof(Gibs_Pyro_Models); i++)
					npc.AddGib(Gibs_Pyro_Models[i], Gibs_Pyro_Attachments[i]);
			}
			case 4:
			{
				for (int i = 0; i < sizeof(Gibs_Demo_Models); i++)
					npc.AddGib(Gibs_Demo_Models[i], Gibs_Demo_Attachments[i]);
			}
			case 5:
			{
				for (int i = 0; i < sizeof(Gibs_Heavy_Models); i++)
					npc.AddGib(Gibs_Heavy_Models[i], Gibs_Heavy_Attachments[i]);
			}
			case 6:
			{
				for (int i = 0; i < sizeof(Gibs_Engineer_Models); i++)
					npc.AddGib(Gibs_Engineer_Models[i], Gibs_Engineer_Attachments[i]);
			}
			case 7:
			{
				for (int i = 0; i < sizeof(Gibs_Medic_Models); i++)
					npc.AddGib(Gibs_Medic_Models[i], Gibs_Medic_Attachments[i]);
			}
			case 8:
			{
				for (int i = 0; i < sizeof(Gibs_Scout_Models); i++)
					npc.AddGib(Gibs_Sniper_Models[i], Gibs_Sniper_Attachments[i]);
			}
			case 9:
			{
				for (int i = 0; i < sizeof(Gibs_Scout_Models); i++)
					npc.AddGib(Gibs_Spy_Models[i], Gibs_Spy_Attachments[i]);
			}
		}
	}
	else
	{
		ConfigMap gibs = conf.GetSection("npc.visuals.gibs");
		if (gibs != null)
		{
			npc.ClearGibs();

			int slot = 1;
			char slotChar[16];
			ConfigMap instance = gibs.GetSection("1");

			while (instance != null)
			{
				char model[255], attachment[255];
				instance.Get("model", model, sizeof(model));
				instance.Get("attachment", attachment, sizeof(attachment));

				npc.AddGib(model, attachment);

				slot++;
				IntToString(slot, slotChar, sizeof(slotChar));
				instance = gibs.GetSection(slotChar);
			}
		}
	}

	DeleteCfg(conf);

	return 0;
}

public int Native_PNPCClearGibs(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));
	delete g_Gibs[npc.Index];
	delete g_GibAttachments[npc.Index];
	return 0;
}

public int Native_PNPCSetParticlesFromConfig(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));

	ConfigMap conf = npc.GetConfigMap();
	if (conf == null)
		return 0;

	ConfigMap particles = conf.GetSection("npc.visuals.particles");
	if (particles != null)
	{
		int slot = 1;
		char slotChar[16];
		ConfigMap instance = particles.GetSection("1");

		while (instance != null)
		{
			//TODO: Expand on this to allow "aura" effects, like what unusual taunts use.
			//These also need to be hidden via SetTransmit while the PNPC is invisible.

			char particle[255], attachment[255], placeholder[255];
			instance.Get("name_red", particle, sizeof(particle));
			instance.Get("attachment", attachment, sizeof(attachment));

			if (npc.i_Team == TFTeam_Blue)
			{
				instance.Get("name_blue", placeholder, sizeof(placeholder));
				if (!StrEqual(placeholder, ""))
					strcopy(particle, sizeof(particle), placeholder);
			}
			else if (npc.i_Team != TFTeam_Red)
			{
				instance.Get("name_unassigned", placeholder, sizeof(placeholder));
				if (!StrEqual(placeholder, ""))
					strcopy(particle, sizeof(particle), placeholder);
			}

			float xOff = GetFloatFromConfigMap(instance, "x_offset", 0.0);
			float yOff = GetFloatFromConfigMap(instance, "y_offset", 0.0);
			float zOff = GetFloatFromConfigMap(instance, "z_offset", 0.0);

			AttachParticleToEntity(npc.Index, particle, attachment, _, xOff, yOff, zOff);

			slot++;
			IntToString(slot, slotChar, sizeof(slotChar));
			instance = particles.GetSection(slotChar);
		}
	}

	DeleteCfg(conf);

	return 0;
}

public int Native_PNPCSetAttachmentsFromConfig(Handle plugin, int numParams)
{
	PNPC npc = view_as<PNPC>(GetNativeCell(1));

	ConfigMap conf = npc.GetConfigMap();
	if (conf == null)
		return 0;

	ConfigMap attachments = conf.GetSection("npc.visuals.models");
	if (attachments != null)
	{
		npc.RemoveAttachments();
		int slot = 1;
		char slotChar[16];
		ConfigMap instance = attachments.GetSection("1");

		while (instance != null)
		{
			char model[255], attachment[255], sequence[255];
			instance.Get("model", model, sizeof(model));
			instance.Get("attachment", attachment, sizeof(attachment));
			instance.Get("sequence", sequence, sizeof(sequence));
			int skin = GetIntFromConfigMap(instance, "skin", -1);
			float scale = GetFloatFromConfigMap(instance, "scale", 1.0);
			bool bonemerge = GetBoolFromConfigMap(instance, "bonemerge", true);
			bool weapon = GetBoolFromConfigMap(instance, "weapon", false);

			npc.AttachModel(model, attachment, sequence, skin, scale, bonemerge, weapon);

			slot++;
			IntToString(slot, slotChar, sizeof(slotChar));
			instance = attachments.GetSection(slotChar);
		}
	}

	DeleteCfg(conf);

	return 0;
}