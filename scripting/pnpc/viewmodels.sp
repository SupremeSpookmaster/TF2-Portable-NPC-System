#define VIEWMODEL_NAME	"custom_viewmodel"

bool b_BeingAnimated[2049] = { false, ... };

char s_VMModel[2049][255];

//TODO: Don't forget AddGesture!

public void ViewModels_MakeNatives()
{
	CreateNative("PNPC_ViewModel.PNPC_ViewModel", Native_VMConstructor);
	CreateNative("PNPC_ViewModel.SetModel", Native_VMSetModel);
	CreateNative("PNPC_ViewModel.GetModel", Native_VMGetModel);
	CreateNative("PNPC_ViewModel.SetSequence", Native_VMSetSequence);
	CreateNative("PNPC_ViewModel.SetActivity", Native_VMSetActivity);
	CreateNative("PNPC_ViewModel.LookupActivity", Native_VMLookupActivity);
	CreateNative("PNPC_ViewModel.Index.get", Native_VMGetIndex);
	CreateNative("PNPC_ViewModel.i_Owner.get", Native_VMGetOwner);
	CreateNative("PNPC_ViewModel.i_Owner.set", Native_VMSetOwner);
	CreateNative("PNPC_ViewModel.f_PlaybackRate.get", Native_VMGetPlaybackRate);
	CreateNative("PNPC_ViewModel.f_PlaybackRate.set", Native_VMSetPlaybackRate);
	CreateNative("PNPC_ViewModel.f_Cycle.get", Native_VMGetCycle);
	CreateNative("PNPC_ViewModel.f_Cycle.set", Native_VMSetCycle);
}

public void ViewModels_PluginStart()
{
	CEntityFactory VM_Factory = new CEntityFactory(VIEWMODEL_NAME, VM_OnCreate, VM_OnDestroy);
	VM_Factory.DeriveFromNPC();
	VM_Factory.Install();
}

void VM_OnCreate(int vm)
{

}

void VM_OnDestroy(int vm)
{
	b_BeingAnimated[vm] = false;
}

public any Native_VMConstructor(Handle plugin, int numParams)
{

}

public int Native_VMGetIndex(Handle plugin, int numParams) { return GetNativeCell(1); }

public int Native_VMGetOwner(Handle plugin, int numParams) { return GetEntPropEnt(GetNativeCell(1), Prop_Send, "m_hOwnerEntity"); }
public int Native_VMSetOwner(Handle plugin, int numParams) { SetEntPropEnt(GetNativeCell(1), Prop_Send, "m_hOwnerEntity", GetNativeCell(2)); return 0; }

public any Native_VMGetPlaybackRate(Handle plugin, int numParams) { return GetEntPropFloat(GetNativeCell(1), Prop_Send, "m_flPlaybackRate"); }
public int Native_VMSetPlaybackRate(Handle plugin, int numParams) { SetEntPropFloat(GetNativeCell(1), Prop_Send, "m_flPlaybackRate", GetNativeCell(2)); return 0; }

public int Native_VMSetModel(Handle plugin, int numParams)
{
	int entity = GetNativeCell(1);
	char model[255];
	GetNativeString(2, model, sizeof(model));
	if (!CheckFile(model))
		return 0;

	strcopy(s_VMModel[entity], 255, model);
	SetEntityModel(entity, s_VMModel[entity]);
	PreventAllCollisions(entity);

	return 0;
}

public int Native_VMGetModel(Handle plugin, int numParams) { SetNativeString(2, s_VMModel[GetNativeCell(1)], GetNativeCell(3)); return 0; }

public int Native_VMSetSequence(Handle plugin, int numParams)
{
	PNPC_ViewModel vm = view_as<PNPC_ViewModel>(GetNativeCell(1));
	char sequence[255];
	GetNativeString(2, sequence, sizeof(sequence));

	int anim = vm.LookupSequence(sequence);
	if (anim > -1)
	{
		SetEntProp(vm.Index, Prop_Send, "m_nSequence", anim);
		return true;
	}

	return false;
}

public any Native_VMSetActivity(Handle plugin, int numParams)
{
	PNPC_ViewModel vm = view_as<PNPC_ViewModel>(GetNativeCell(1));
	char activityStr[255];
	GetNativeString(2, activityStr, sizeof(activityStr));

	int activity = vm.LookupActivity(activityStr);
	if (activity > -1)
	{
		int sequence = vm.SelectWeightedSequence(view_as<Activity>(activity));
		if (sequence <= 0)
			return false;

		SetEntProp(vm.Index, Prop_Send, "m_nSequence", sequence);
		vm.f_Cycle = 0.0;

		return true;
	}

	return false;
}

public int Native_VMLookupActivity(Handle plugin, int numParams)
{
	PNPC_ViewModel vm = view_as<PNPC_ViewModel>(GetNativeCell(1));
	char activity[255];
	GetNativeString(2, activity, sizeof(activity));

	Address modelPtr = vm.GetModelPtr();
	if (modelPtr == Address_Null)
		return -1;

	return SDKCall(g_hLookupActivity, modelPtr, activity);
}

public int Native_VMSetCycle(Handle plugin, int numParams)
{
	SetEntPropFloat(GetNativeCell(1), Prop_Send, "m_flCycle", GetNativeCell(2));
	return 0;
}

public any Native_VMGetCycle(Handle plugin, int numParams)
{
	return GetEntPropFloat(GetNativeCell(1), Prop_Send, "m_flCycle");
}