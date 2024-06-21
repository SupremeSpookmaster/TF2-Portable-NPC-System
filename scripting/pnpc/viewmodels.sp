#define VIEWMODEL_NAME	"custom_viewmodel"

bool b_BeingAnimated[2049] = { false, ... };

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