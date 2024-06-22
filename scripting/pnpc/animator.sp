#define ANIMATOR_NAME	"custom_animator"

bool b_BeingAnimated[2049] = { false, ... };

char s_AnimatorModel[2049][255];

//TODO: Don't forget AddGesture!

public void Animator_MakeNatives()
{
	CreateNative("PNPC_Animator.PNPC_Animator", Native_AnimatorConstructor);
	CreateNative("PNPC_Animator.SetModel", Native_AnimatorSetModel);
	CreateNative("PNPC_Animator.GetModel", Native_AnimatorGetModel);
	CreateNative("PNPC_Animator.SetSequence", Native_AnimatorSetSequence);
	CreateNative("PNPC_Animator.SetActivity", Native_AnimatorSetActivity);
	CreateNative("PNPC_Animator.LookupActivity", Native_AnimatorLookupActivity);
	CreateNative("PNPC_Animator.Index.get", Native_AnimatorGetIndex);
	CreateNative("PNPC_Animator.i_Owner.get", Native_AnimatorGetOwner);
	CreateNative("PNPC_Animator.i_Owner.set", Native_AnimatorSetOwner);
	CreateNative("PNPC_Animator.f_PlaybackRate.get", Native_AnimatorGetPlaybackRate);
	CreateNative("PNPC_Animator.f_PlaybackRate.set", Native_AnimatorSetPlaybackRate);
	CreateNative("PNPC_Animator.f_Cycle.get", Native_AnimatorGetCycle);
	CreateNative("PNPC_Animator.f_Cycle.set", Native_AnimatorSetCycle);
	CreateNative("PNPC_Animator.AddGesture", Native_AnimatorAddGesture);
	CreateNative("PNPC_Animator.RemoveGesture", Native_AnimatorRemoveGesture);
	CreateNative("PNPC_Animator.f_Scale.get", Native_AnimatorGetScale);
	CreateNative("PNPC_Animator.f_Scale.set", Native_AnimatorSetScale);
	CreateNative("PNPC_Animator.i_Skin.get", Native_AnimatorGetSkin);
	CreateNative("PNPC_Animator.i_Skin.set", Native_AnimatorSetSkin);
}

public void Animator_PluginStart()
{
	CEntityFactory Animator_Factory = new CEntityFactory(ANIMATOR_NAME, Animator_OnCreate, Animator_OnDestroy);
	Animator_Factory.DeriveFromNPC();
	Animator_Factory.Install();
}

void Animator_OnCreate(int anim)
{

}

void Animator_OnDestroy(int anim)
{
	b_BeingAnimated[anim] = false;
}

public any Native_AnimatorConstructor(Handle plugin, int numParams)
{
	int animator = CreateEntityByName(ANIMATOR_NAME);
	if (IsValidEntity(animator))
	{
		char model[255], activity[255];
		GetNativeString(1, model, sizeof(model));
		GetNativeString(2, activity, sizeof(activity));
		float pos[3], ang[3];
		GetNativeArray(3, pos, sizeof(pos));
		GetNativeArray(4, ang, sizeof(ang));
		int skin = GetNativeCell(5);
		float rate = GetNativeCell(6);
		float scale = GetNativeCell(7);

		PNPC_Animator anim = view_as<PNPC_Animator>(animator);

		anim.SetModel(model);
		if (!StrEqual(activity, ""))
			anim.SetActivity(activity);
		anim.f_PlaybackRate = rate;
		anim.i_Skin = skin;
		anim.f_Scale = scale;

		PreventAllCollisions(animator);
		SetEntProp(animator, Prop_Data, "m_takedamage", 0);

		TeleportEntity(animator, pos, ang);

		return anim;
	}

	return -1;
}

public any Native_AnimatorGetSkin(Handle plugin, int numParams) { return GetEntProp(GetNativeCell(1), Prop_Send, "m_nSkin"); }
public int Native_AnimatorSetSkin(Handle plugin, int numParams) 
{
	int ent = GetNativeCell(1);
	int skin = GetNativeCell(2);

	SetEntProp(ent, Prop_Send, "m_nSkin", skin);

	return 0; 
}

public any Native_AnimatorGetScale(Handle plugin, int numParams) { return GetEntPropFloat(GetNativeCell(1), Prop_Send, "m_flModelScale"); }
public int Native_AnimatorSetScale(Handle plugin, int numParams) 
{
	int ent = GetNativeCell(1);
	float scale = GetNativeCell(2);
	SetEntPropFloat(ent, Prop_Send, "m_flModelScale", scale);

	return 0; 
}

public int Native_AnimatorGetIndex(Handle plugin, int numParams) { return GetNativeCell(1); }

public int Native_AnimatorGetOwner(Handle plugin, int numParams) { return GetEntPropEnt(GetNativeCell(1), Prop_Send, "m_hOwnerEntity"); }
public int Native_AnimatorSetOwner(Handle plugin, int numParams) { SetEntPropEnt(GetNativeCell(1), Prop_Send, "m_hOwnerEntity", GetNativeCell(2)); return 0; }

public any Native_AnimatorGetPlaybackRate(Handle plugin, int numParams) { return GetEntPropFloat(GetNativeCell(1), Prop_Send, "m_flPlaybackRate"); }
public int Native_AnimatorSetPlaybackRate(Handle plugin, int numParams) { SetEntPropFloat(GetNativeCell(1), Prop_Send, "m_flPlaybackRate", GetNativeCell(2)); return 0; }

public int Native_AnimatorSetModel(Handle plugin, int numParams)
{
	int entity = GetNativeCell(1);
	char model[255];
	GetNativeString(2, model, sizeof(model));
	if (!CheckFile(model))
		return 0;

	strcopy(s_AnimatorModel[entity], 255, model);
	SetEntityModel(entity, s_AnimatorModel[entity]);
	PreventAllCollisions(entity);

	return 0;
}

public int Native_AnimatorGetModel(Handle plugin, int numParams) { SetNativeString(2, s_AnimatorModel[GetNativeCell(1)], GetNativeCell(3)); return 0; }

public int Native_AnimatorSetSequence(Handle plugin, int numParams)
{
	PNPC_Animator anim = view_as<PNPC_Animator>(GetNativeCell(1));
	char sequence[255];
	GetNativeString(2, sequence, sizeof(sequence));

	int seqNum = anim.LookupSequence(sequence);
	if (seqNum > -1)
	{
		SetEntProp(anim.Index, Prop_Send, "m_nSequence", seqNum);
		return true;
	}

	return false;
}

public any Native_AnimatorSetActivity(Handle plugin, int numParams)
{
	PNPC_Animator anim = view_as<PNPC_Animator>(GetNativeCell(1));
	char activityStr[255];
	GetNativeString(2, activityStr, sizeof(activityStr));

	int activity = anim.LookupActivity(activityStr);
	if (activity > -1)
	{
		int sequence = anim.SelectWeightedSequence(view_as<Activity>(activity));
		if (sequence <= 0)
			return false;

		SetEntProp(anim.Index, Prop_Send, "m_nSequence", sequence);
		anim.f_Cycle = 0.0;

		return true;
	}

	return false;
}

public int Native_AnimatorLookupActivity(Handle plugin, int numParams)
{
	PNPC_Animator anim = view_as<PNPC_Animator>(GetNativeCell(1));
	char activity[255];
	GetNativeString(2, activity, sizeof(activity));

	Address modelPtr = anim.GetModelPtr();
	if (modelPtr == Address_Null)
		return -1;

	return SDKCall(g_hLookupActivity, modelPtr, activity);
}

public int Native_AnimatorSetCycle(Handle plugin, int numParams)
{
	SetEntPropFloat(GetNativeCell(1), Prop_Send, "m_flCycle", GetNativeCell(2));
	return 0;
}

public any Native_AnimatorGetCycle(Handle plugin, int numParams)
{
	return GetEntPropFloat(GetNativeCell(1), Prop_Send, "m_flCycle");
}

public int Native_AnimatorAddGesture(Handle plugin, int numParams)
{
	PNPC_Animator animator = view_as<PNPC_Animator>(GetNativeCell(1));
	char gesture[255];
	GetNativeString(2, gesture, sizeof(gesture));
	bool cancel = GetNativeCell(3);
	float duration = GetNativeCell(4);
	bool autoKill = GetNativeCell(5);
	float rate = GetNativeCell(6);

	int activity = animator.LookupActivity(gesture);
	if (activity <= 0)
		return 0;

	if (cancel)
		view_as<CBaseCombatCharacter>(animator).RestartGesture(view_as<Activity>(activity), true, autoKill);
	else
		view_as<CBaseCombatCharacter>(animator).AddGesture(view_as<Activity>(activity), duration, autoKill);

	int layer = animator.FindGestureLayer(view_as<Activity>(activity));
	if (layer > -1)
		animator.SetLayerPlaybackRate(layer, rate);

	return 0;
}

public int Native_AnimatorRemoveGesture(Handle plugin, int numParams)
{
	PNPC_Animator animator = view_as<PNPC_Animator>(GetNativeCell(1));
	char gesture[255];
	GetNativeString(2, gesture, sizeof(gesture));

	int activity = animator.LookupActivity(gesture);
	if (activity <= 0)
		return 0;

	int layer = animator.FindGestureLayer(view_as<Activity>(activity));
	if (layer > -1)
		animator.FastRemoveLayer(layer);

	return 0;
}