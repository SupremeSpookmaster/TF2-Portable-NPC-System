#pragma semicolon 1
#pragma newdecls required

Handle g_hGetVectors;
Handle g_hLookupActivity;
Handle g_hLookupSequence;
Handle g_hSDKWorldSpaceCenter;
Handle g_hStudio_FindAttachment;
Handle g_hGetAttachment;
Handle g_hResetSequenceInfo;
Handle g_hUpdateCollisionBox;

public void NPCs_MakeHooks()
{
	GameData gamedata = LoadGameConfigFile("zombie_riot");
	
	StartPrepSDKCall(SDKCall_Static);
	PrepSDKCall_SetFromConf(gamedata, SDKConf_Signature, "Studio_FindAttachment");
	PrepSDKCall_AddParameter(SDKType_PlainOldData, SDKPass_Plain);	//pStudioHdr
	PrepSDKCall_AddParameter(SDKType_String, SDKPass_Pointer);		//pAttachmentName
	PrepSDKCall_SetReturnInfo(SDKType_PlainOldData, SDKPass_Plain);	//return index
	if((g_hStudio_FindAttachment = EndPrepSDKCall()) == INVALID_HANDLE) SetFailState("Failed to create Call for Studio_FindAttachment");
	
	StartPrepSDKCall(SDKCall_Entity);
	PrepSDKCall_SetFromConf(gamedata, SDKConf_Virtual, "CBaseAnimating::RefreshCollisionBounds");
	if ((g_hUpdateCollisionBox = EndPrepSDKCall()) == INVALID_HANDLE) SetFailState("Failed to create SDKCall for CBaseAnimating::RefreshCollisionBounds offset!"); 
	
	delete gamedata;
}

methodmap CClotBody < CBaseCombatCharacter
{
	public CClotBody(float vecPos[3], float vecAng[3],
						const char[] model,
						float modelScale = 1.0,
						int HP = 100,
						TFTeam Team)
	{

		int npc = CreateEntityByName("zr_base_npc");
		CBaseNPC baseNPC = view_as<CClotBody>(npc).GetBaseNPC();

		DispatchKeyValueVector(npc, "origin",	 vecPos);
		DispatchKeyValueVector(npc, "angles",	 vecAng);
		DispatchKeyValue(npc, "model",	 model);
		view_as<CBaseCombatCharacter>(npc).SetModel(model);
		
		char modelscale[255], health[255];
		Format(modelscale, sizeof(modelscale), "%f", modelScale);
		Format(health, sizeof(health), "%i", HP);
		DispatchKeyValue(npc,	   "modelscale", modelscale);
		DispatchKeyValue(npc,	   "health",	 health);

		SetEntProp(npc, Prop_Send, "m_iTeamNum", Team);

		DispatchSpawn(npc); //Do this at the end :)

		CClotBody npcstats = view_as<CClotBody>(npc);

		//FIX: This fixes lookup activity not working.
		npcstats.StartActivity(0);
		npcstats.SetSequence(0);
		npcstats.SetPlaybackRate(1.0);
		npcstats.SetCycle(0.0);
		npcstats.ResetSequenceInfo();
		//FIX: This fixes lookup activity not working.

		baseNPC.flStepSize = 17.0;
		baseNPC.flGravity = 800.0; //SEE Npc Base Think Function to change it.
		baseNPC.flAcceleration = 6000.0;
		baseNPC.flJumpHeight = 250.0;
		//baseNPC.flRunSpeed = 300.0; //SEE Update Logic.
		baseNPC.flFrictionSideways = 5.0;
		baseNPC.flMaxYawRate = 45.0;
		baseNPC.flDeathDropHeight = 999999.0;

		CBaseNPC_Locomotion locomotion = baseNPC.GetLocomotion();

		SetEntProp(npc, Prop_Data, "m_bSequenceLoops", true);

		SetEntityFlags(npc, FL_NPC);
		
		SetEntProp(npc, Prop_Data, "m_nSolidType", 2); 

		//Don't bleed.
		SetEntProp(npc, Prop_Data, "m_bloodColor", -1); //Don't bleed
		
		static float m_vecMaxs[3];
		static float m_vecMins[3];
		m_vecMaxs = view_as<float>( { 24.0, 24.0, 82.0 } );
		m_vecMins = view_as<float>( { -24.0, -24.0, 0.0 } );		
		
		//Fix collisions
		
		static float m_vecMaxs_Body[3];
		static float m_vecMins_Body[3];

		m_vecMaxs_Body[0] = m_vecMaxs[0] * 2.0;
		m_vecMaxs_Body[1] = m_vecMaxs[1] * 2.0;
		m_vecMaxs_Body[2] = m_vecMaxs[2] * 1.15;
		//we dont want to fake super tall.

		m_vecMins_Body[0] = m_vecMins[0] * 2.0;
		m_vecMins_Body[1] = m_vecMins[1] * 2.0;
		m_vecMins_Body[2] = m_vecMins[2] * 1.15;

		baseNPC.SetBodyMaxs(m_vecMaxs);
		baseNPC.SetBodyMins(m_vecMins);
		SetEntPropVector(npc, Prop_Data, "m_vecMaxs", m_vecMaxs);
		SetEntPropVector(npc, Prop_Data, "m_vecMins", m_vecMins);
		
		//Fixed wierd clientside issue or something
		static float m_vecMaxsNothing[3];
		static float m_vecMinsNothing[3];
		m_vecMaxsNothing = view_as<float>( { 1.0, 1.0, 2.0 } );
		m_vecMinsNothing = view_as<float>( { -1.0, -1.0, 0.0 } );		
		SetEntPropVector(npc, Prop_Send, "m_vecMaxsPreScaled", m_vecMaxsNothing);
		SetEntPropVector(npc, Prop_Data, "m_vecMaxsPreScaled", m_vecMaxsNothing);
		SetEntPropVector(npc, Prop_Send, "m_vecMinsPreScaled", m_vecMinsNothing);
		SetEntPropVector(npc, Prop_Data, "m_vecMinsPreScaled", m_vecMinsNothing);
		
		//TODO: Make these think hooks
		//SDKHook(npc, SDKHook_Think, NpcBaseThink);
		//SDKHook(npc, SDKHook_ThinkPost, NpcBaseThinkPost);
	
		return view_as<CClotBody>(npc);
	}	//THIS IS THE END OF THE NPC_CREATION METHOD
		property int index 
	{ 
		public get() { return view_as<int>(this); } 
	}
	
	//Preserved for future reference:
	/*property int m_iOverlordComboAttack
	{
		public get()							{ return i_OverlordComboAttack[this.index]; }
		public set(int TempValueForProperty) 	{ i_OverlordComboAttack[this.index] = TempValueForProperty; }
	}*/
	
	public int GetTeam()  { return GetEntProp(this.index, Prop_Send, "m_iTeamNum"); }
	
	public PathFollower GetPathFollower()
	{
		return view_as<PathFollower>(this.GetProp(Prop_Data, "zr_pPath"));
	}
	public INextBot GetBot()
	{
		return this.MyNextBotPointer();
	}
	public CBaseNPC GetBaseNPC()
	{
		return TheNPCs.FindNPCByEntIndex(this.index);
	}
	public ILocomotion GetLocomotion()
	{
		return this.MyNextBotPointer().GetLocomotionInterface();
	}
	public ILocomotion GetLocomotionInterface()
	{
		return this.MyNextBotPointer().GetLocomotionInterface();
	}
	public bool IsOnGround()
	{
		return this.GetLocomotionInterface().IsOnGround();
	}
	public void AddGesture(const char[] anim, bool cancel_animation = true, float duration = 1.0, bool autokill = true)
	{
		int activity = this.LookupActivity(anim);
		if(activity < 0)
			return;
		
		if(cancel_animation)
		{
			view_as<CBaseCombatCharacter>(this).RestartGesture(view_as<Activity>(activity), true, autokill);
		}
		else
		{
			view_as<CBaseCombatCharacter>(this).AddGesture(view_as<Activity>(activity), duration, autokill);
		}
		
		int layer = this.FindGestureLayer(view_as<Activity>(activity));
		if(layer != -1)
			this.SetLayerPlaybackRate(layer, 1.0);
	}
	public void RemoveGesture(const char[] anim)
	{
		int activity = this.LookupActivity(anim);
		if(activity < 0)
			return;
		
		int layer = this.FindGestureLayer(view_as<Activity>(activity));
		if(layer != -1)
			this.FastRemoveLayer(layer);
	}
	public void AddActivityViaSequence(const char[] anim)
	{
		int iSequence = this.LookupSequence(anim);
		if(iSequence < 0)
			return;
		
		this.ResetSequence(iSequence);
		this.ResetSequenceInfo();
		this.SetPlaybackRate(1.0);
		this.SetCycle(0.0);
		this.ResetSequenceInfo();
		this.m_iState = iSequence;
	}
	public void AddGestureViaSequence(const char[] anim, bool cancel_animation = true)
	{
		int iSequence = this.LookupSequence(anim);
		if(iSequence < 0)
			return;
		
		this.AddGestureSequence(iSequence);
	}
	public int FindAttachment(const char[] pAttachmentName)
	{
		Address pStudioHdr = this.GetModelPtr();
		if(pStudioHdr == Address_Null)
			return -1;
			
		return SDKCall(g_hStudio_FindAttachment, pStudioHdr, pAttachmentName) + 1;
	}
	public void SetActivity(const char[] animation, bool Is_sequence = false)
	{
		if(Is_sequence)
		{
			int sequence = this.LookupSequence(animation);
			if(sequence > 0 && sequence != this.m_iState)
			{
				this.m_iState = sequence;
				this.m_iActivity = 0;
				
				this.SetSequence(sequence);
				this.SetPlaybackRate(1.0);
				this.SetCycle(0.0);
				this.ResetSequenceInfo();
			}
		}
		else
		{
			int activity = this.LookupActivity(animation);
			if(activity > 0 && activity != this.m_iState)
			{
				this.m_iState = activity;
				this.StartActivity(activity);
			}
		}
	}
	public void StartPathing()
	{
		this.m_bPathing = true;

		this.GetPathFollower().SetMinLookAheadDistance(100.0);
	}
	public void StopPathing()
	{
		this.GetPathFollower().Invalidate();
		this.GetLocomotion().Stop();

		this.m_bPathing = false;
	}
	public void SetGoalEntity(int target, bool ignoretime = false)
	{
		if(ignoretime)
		{
			if(this.m_bPathing)
			{
				this.GetPathFollower().ComputeToTarget(this.GetBot(), target);
				float DistanceCheck[3];
				GetEntPropVector(target, Prop_Data, "m_vecAbsOrigin", DistanceCheck);
			}
		}
	}
	public void SetGoalVector(const float vec[3], bool ignoretime = false)
	{	
		if(ignoretime)
		{
			if(this.m_bPathing)
			{
				this.GetPathFollower().ComputeToPos(this.GetBot(), vec);
			}
		}
	}
	public void FaceTowards(const float vecGoal[3], float turnrate = 250.0)
	{
		//Sad!
		float flPrevValue = this.GetBaseNPC().flMaxYawRate;
		
		this.GetBaseNPC().flMaxYawRate = turnrate;
		this.GetLocomotionInterface().FaceTowards(vecGoal);
		this.GetBaseNPC().flMaxYawRate = flPrevValue;
	}
	/*

		public void FaceTowards(const float vecGoal[3], float turnrate = 250.0)
	{
		//Sad!
		float flPrevValue = flTurnRate.FloatValue;
		
		flTurnRate.FloatValue = turnrate;
		SDKCall(g_hFaceTowards, this.GetLocomotionInterface(), vecGoal);
		flTurnRate.FloatValue = flPrevValue;
	}
	*/		
	public float GetMaxJumpHeight()	{ return this.GetLocomotionInterface().GetMaxJumpHeight(); }
	public float GetGroundSpeed()	{ return this.GetLocomotionInterface().GetGroundSpeed(); }
	public int SelectWeightedSequence(any activity) { return view_as<CBaseAnimating>(view_as<int>(this)).SelectWeightedSequence(activity); }
	
	public bool GetAttachment(const char[] szName, float absOrigin[3], float absAngles[3]) { return view_as<CBaseAnimating>(view_as<int>(this)).GetAttachment(view_as<CBaseAnimating>(view_as<int>(this)).LookupAttachment(szName), absOrigin, absAngles); }
	public void Approach(const float vecGoal[3])										   { this.GetLocomotionInterface().Approach(vecGoal, 0.1);						}
	public void Jump()																	 { this.GetLocomotionInterface().Jump();										  }
	public void GetVelocity(float vecOut[3])											   { this.GetLocomotionInterface().GetVelocity(vecOut);						   }	
	public void SetVelocity(const float vec[3])	
	{
		CBaseNPC baseNPC = view_as<CClotBody>(this.index).GetBaseNPC();
		CBaseNPC_Locomotion locomotion = baseNPC.GetLocomotion();
		locomotion.SetVelocity(vec);							  
	}	
	
	public void SetOrigin(const float vec[3])											
	{
		SetEntPropVector(this.index, Prop_Data, "m_vecAbsOrigin",vec);
	}	
	
	public void SetSequence(int iSequence)	{ SetEntProp(this.index, Prop_Send, "m_nSequence", iSequence); }
	public float GetPlaybackRate() { return GetEntPropFloat(this.index, Prop_Send, "m_flPlaybackRate"); }
	public void SetPlaybackRate(float flRate) { SetEntPropFloat(this.index, Prop_Send, "m_flPlaybackRate", flRate); }
	public void SetCycle(float flCycle)	   { SetEntPropFloat(this.index, Prop_Send, "m_flCycle", flCycle); }
	
	public void GetVectors(float pForward[3], float pRight[3], float pUp[3]) { view_as<CBaseEntity>(this).GetVectors(pForward, pRight, pUp); }
	
	public void GetGroundMotionVector(float vecMotion[3])					{ this.GetLocomotionInterface().GetGroundMotionVector(vecMotion); }
	public float GetLeadRadius()	{ return 90000.0/*this.GetPathFollower().GetLeadRadius()*/; }
	public void UpdateCollisionBox() { SDKCall(g_hUpdateCollisionBox,  this.index); }
	public void ResetSequenceInfo()  { SDKCall(g_hResetSequenceInfo,  this.index); }
	public void StudioFrameAdvance() { view_as<CBaseAnimating>(view_as<int>(this)).StudioFrameAdvance(); }
	public void DispatchAnimEvents() { view_as<CBaseAnimating>(view_as<int>(this)).DispatchAnimEvents(view_as<CBaseAnimating>(view_as<int>(this))); }
	
	public bool DoSwingTrace(Handle &trace,
	int target,
	 float vecSwingMaxs[3] = { 64.0, 64.0, 128.0 },
	  float vecSwingMins[3] = { -64.0, -64.0, -128.0 },
	   float vecSwingStartOffset = 55.0,
	    int Npc_type = 0,
		 int Ignore_Buildings = 0,
		  int countAoe = 0)
	{
		switch(Npc_type)
		{
			case 1: //giants
			{
				vecSwingMaxs = { 100.0, 100.0, 150.0 };
				vecSwingMins = { -100.0, -100.0, -150.0 };
			}
			case 2: //Ally Invinceable 
			{
				vecSwingMaxs = { 250.0, 250.0, 250.0 };
				vecSwingMins = { -250.0, -250.0, -250.0 };
			}
		}
		
		float eyePitch[3];
		GetEntPropVector(this.index, Prop_Data, "m_angRotation", eyePitch);
		
		float vecForward[3], vecRight[3], vecTarget[3];
		
		float WorldSpaceTarget[3];

		WorldSpaceTarget = WorldSpaceCenter(target);
		vecTarget = WorldSpaceTarget;
		if(target <= MaxClients)
			vecTarget[2] += 10.0; //abit extra as they will most likely always shoot upwards more then downwards

		MakeVectorFromPoints(WorldSpaceCenter(this.index), vecTarget, vecForward);
		GetVectorAngles(vecForward, vecForward);
		vecForward[1] = eyePitch[1];
		GetAngleVectors(vecForward, vecForward, vecRight, vecTarget);
		
		float vecSwingStart[3]; vecSwingStart = GetAbsOrigin(this.index);
		
		vecSwingStart[2] += vecSwingStartOffset; //default is 55 for a few reasons.
		
		float vecSwingEnd[3];
		vecSwingEnd[0] = vecSwingStart[0] + vecForward[0] * vecSwingMaxs[0];
		vecSwingEnd[1] = vecSwingStart[1] + vecForward[1] * vecSwingMaxs[1];
		vecSwingEnd[2] = vecSwingStart[2] + vecForward[2] * vecSwingMaxs[2];
		
		bool ingore_buildings = view_as<bool>(Ignore_Buildings);
		
		// See if we hit anything.
		if(countAoe > 0)
		{
			Zero(i_EntitiesHitAoeSwing_NpcSwing);
			
			for(int repeat; repeat < 3; repeat ++)
			{
				vecSwingMins[repeat] *= 0.75;
				vecSwingMins[repeat] *= 0.75;
				vecSwingMaxs[repeat] *= 0.75;
				vecSwingMaxs[repeat] *= 0.75;
			}

			trace = TR_TraceHullFilterEx( vecSwingStart, vecSwingEnd,vecSwingMins, vecSwingMaxs, 1073741824, ingore_buildings ? BulletAndMeleeTrace_MultiNpcPlayerAndBaseBossOnly : BulletAndMeleeTrace_MultiNpcTrace, this.index);
		}	
		else
		{
			trace = TR_TraceRayFilterEx( vecSwingStart, vecSwingEnd, ( MASK_SOLID | CONTENTS_SOLID ), RayType_EndPoint, ingore_buildings ? BulletAndMeleeTracePlayerAndBaseBossOnly : BulletAndMeleeTrace, this.index );
		}
		return (TR_GetFraction(trace) < 1.0);
	}
	public bool DoAimbotTrace(Handle &trace, int target, float vecSwingMaxs[3] = { 64.0, 64.0, 128.0 }, float vecSwingMins[3] = { -64.0, -64.0, -128.0 }, float vecSwingStartOffset = 44.0)
	{
		float vecSwingStart[3]; vecSwingStart = GetAbsOrigin(this.index);
		
		vecSwingStart[2] += vecSwingStartOffset;
		
		float vecSwingEnd[3]; vecSwingEnd = GetAbsOrigin(target);
		
		// See if we hit anything.
		trace = TR_TraceRayFilterEx( vecSwingStart, vecSwingEnd, ( MASK_SOLID | CONTENTS_SOLID ), RayType_EndPoint, BulletAndMeleeTrace, this.index );
		return (TR_GetFraction(trace) < 1.0);
	}
	public void GetPositionInfront(float DistanceOffsetInfront, float vecSwingEnd[3], float ang[3])
	{	
		GetEntPropVector(this.index, Prop_Data, "m_angRotation", ang);
		
		float vecSwingStart[3];
		float vecSwingForward[3];

		vecSwingStart = GetAbsOrigin(this.index);
		
		GetAngleVectors(ang, vecSwingForward, NULL_VECTOR, NULL_VECTOR);
		
		vecSwingEnd[0] = vecSwingStart[0] + vecSwingForward[0] * DistanceOffsetInfront;
		vecSwingEnd[1] = vecSwingStart[1] + vecSwingForward[1] * DistanceOffsetInfront;
		vecSwingEnd[2] = vecSwingStart[2] + vecSwingForward[2] * DistanceOffsetInfront;
	}
	public int SpawnShield(float duration, char[] model, float position_offset, bool parent = true)
	{

		float eyePitch[3];
		float absorigin[3];
		
		this.GetPositionInfront(position_offset, absorigin, eyePitch);
		int entity = CreateEntityByName("prop_dynamic_override");
		if(IsValidEntity(entity))
		{
			DispatchKeyValue(entity, "targetname", "rpg_fortress");
			DispatchKeyValue(entity, "model", model);
			DispatchKeyValue(entity, "solid", "6");
			SetEntPropFloat(entity, Prop_Send, "m_fadeMinDist", 1600.0);
			SetEntPropFloat(entity, Prop_Send, "m_fadeMaxDist", 2400.0);	
			SetEntityCollisionGroup(entity, 24); //our savior
			SetEntPropEnt(entity, Prop_Send, "m_hOwnerEntity", this.index);			
			DispatchSpawn(entity);
			TeleportEntity(entity, absorigin, eyePitch, NULL_VECTOR, true);
			SetEntProp(entity, Prop_Send, "m_fEffects", EF_PARENT_ANIMATES);
			SetEntityMoveType(entity, MOVETYPE_NONE);
			SetEntProp(entity, Prop_Data, "m_nNextThinkTick", -1.0);
			
			b_ThisEntityIgnored[entity] = true;
			b_ForceCollisionWithProjectile[entity] = true;
			i_WandOwner[entity] = this.index;

			SetEntPropFloat(entity, Prop_Send, "m_fadeMinDist", 1600.0);
			SetEntPropFloat(entity, Prop_Send, "m_fadeMaxDist", 1800.0);

			if(parent)
			{
				SetVariantString("!activator");
				AcceptEntityInput(entity, "SetParent", this.index);
			}
		}
		if(duration > 0.0)
			CreateTimer(duration, Timer_RemoveEntity, EntIndexToEntRef(entity), TIMER_FLAG_NO_MAPCHANGE);
			
		return entity;
	}
	public int FireRocket(float vecTarget[3], float rocket_damage, float rocket_speed, const char[] rocket_model = "", float model_scale = 1.0, int flags = 0, float offset = 0.0, int inflictor = INVALID_ENT_REFERENCE) //No defaults, otherwise i cant even judge.
	{
		float vecForward[3], vecSwingStart[3], vecAngles[3];
		this.GetVectors(vecForward, vecSwingStart, vecAngles);

		vecSwingStart = GetAbsOrigin(this.index);
		vecSwingStart[2] += 54.0;

		vecSwingStart[2] += offset;

		MakeVectorFromPoints(vecSwingStart, vecTarget, vecAngles);
		GetVectorAngles(vecAngles, vecAngles);


		
		vecForward[0] = Cosine(DegToRad(vecAngles[0]))*Cosine(DegToRad(vecAngles[1]))*rocket_speed;
		vecForward[1] = Cosine(DegToRad(vecAngles[0]))*Sine(DegToRad(vecAngles[1]))*rocket_speed;
		vecForward[2] = Sine(DegToRad(vecAngles[0]))*-rocket_speed;

		int entity = CreateEntityByName("tf_projectile_rocket");
		if(IsValidEntity(entity))
		{
			h_ArrowInflictorRef[entity] = inflictor < 1 ? INVALID_ENT_REFERENCE : EntIndexToEntRef(inflictor);
			i_ExplosiveProjectileHexArray[entity] = flags;
			SetEntPropEnt(entity, Prop_Send, "m_hOwnerEntity", this.index);
			SetEntDataFloat(entity, FindSendPropInfo("CTFProjectile_Rocket", "m_iDeflected")+4, rocket_damage, true);	// Damage
			SetEntProp(entity, Prop_Send, "m_iTeamNum", view_as<int>(GetEntProp(this.index, Prop_Send, "m_iTeamNum")));
			SetEntPropVector(entity, Prop_Send, "m_vInitialVelocity", vecForward);

			TeleportEntity(entity, vecSwingStart, vecAngles, NULL_VECTOR, true);
			DispatchSpawn(entity);
			if(rocket_model[0])
			{
				int g_ProjectileModelRocket = PrecacheModel(rocket_model);
				for(int i; i<4; i++)
				{
					SetEntProp(entity, Prop_Send, "m_nModelIndexOverrides", g_ProjectileModelRocket, _, i);
				}
			}
			if(model_scale != 1.0)
			{
				SetEntPropFloat(entity, Prop_Send, "m_flModelScale", model_scale); // ZZZZ i sleep
			}
			TeleportEntity(entity, NULL_VECTOR, NULL_VECTOR, vecForward, true);
			SetEntityCollisionGroup(entity, 24); //our savior
			Set_Projectile_Collision(entity); //If red, set to 27
			See_Projectile_Team(entity);
		}
		return entity;
	}
	public int FireParticleRocket(float vecTarget[3], float rocket_damage, float rocket_speed, float damage_radius , const char[] rocket_particle = "", bool do_aoe_dmg=false , bool FromBlueNpc=true, bool Override_Spawn_Loc = false, float Override_VEC[3] = {0.0,0.0,0.0}, int flags = 0, int inflictor = INVALID_ENT_REFERENCE, float bonusdmg = 1.0)
	{
		float vecForward[3], vecSwingStart[3], vecAngles[3];
		this.GetVectors(vecForward, vecSwingStart, vecAngles);
		
		if(Override_Spawn_Loc)
		{
			vecSwingStart[0]=Override_VEC[0];
			vecSwingStart[1]=Override_VEC[1];
			vecSwingStart[2]=Override_VEC[2];
		}
		else
		{
			vecSwingStart = GetAbsOrigin(this.index);
			vecSwingStart[2] += 54.0;
		}
		
		MakeVectorFromPoints(vecSwingStart, vecTarget, vecAngles);
		GetVectorAngles(vecAngles, vecAngles);

		vecForward[0] = Cosine(DegToRad(vecAngles[0]))*Cosine(DegToRad(vecAngles[1]))*rocket_speed;
		vecForward[1] = Cosine(DegToRad(vecAngles[0]))*Sine(DegToRad(vecAngles[1]))*rocket_speed;
		vecForward[2] = Sine(DegToRad(vecAngles[0]))*-rocket_speed;

		int entity = CreateEntityByName("tf_projectile_rocket");
		if(IsValidEntity(entity))
		{
			h_BonusDmgToSpecialArrow[entity] = bonusdmg;
			h_ArrowInflictorRef[entity] = inflictor < 1 ? INVALID_ENT_REFERENCE : EntIndexToEntRef(inflictor);
			b_should_explode[entity] = do_aoe_dmg;
			i_ExplosiveProjectileHexArray[entity] = flags;
			fl_rocket_particle_dmg[entity] = rocket_damage;
			fl_rocket_particle_radius[entity] = damage_radius;
			b_rocket_particle_from_blue_npc[entity] = FromBlueNpc;
			SetEntPropVector(entity, Prop_Send, "m_vInitialVelocity", vecForward);
			
			SetEntPropEnt(entity, Prop_Send, "m_hOwnerEntity", this.index);
			SetEntDataFloat(entity, FindSendPropInfo("CTFProjectile_Rocket", "m_iDeflected")+4, 0.0, true);	// Damage
			SetEntProp(entity, Prop_Send, "m_iTeamNum", view_as<int>(GetEntProp(this.index, Prop_Send, "m_iTeamNum")));
			
			TeleportEntity(entity, vecSwingStart, vecAngles, NULL_VECTOR, true);
			DispatchSpawn(entity);
			for(int i; i<4; i++) //This will make it so it doesnt override its collision box.
			{
				SetEntProp(entity, Prop_Send, "m_nModelIndexOverrides", g_rocket_particle, _, i);
			}
			SetEntityModel(entity, PARTICLE_ROCKET_MODEL);
	
			//Make it entirely invis. Shouldnt even render these 8 polygons.
			SetEntProp(entity, Prop_Send, "m_fEffects", GetEntProp(entity, Prop_Send, "m_fEffects") | EF_NODRAW);
			SetEntityRenderMode(entity, RENDER_TRANSCOLOR); //Make it entirely invis.
			SetEntityRenderColor(entity, 255, 255, 255, 0);
			
			int particle = 0;
	
			if(rocket_particle[0]) //If it has something, put it in. usually it has one. but if it doesn't base model it remains.
			{
				particle = ParticleEffectAt(vecSwingStart, rocket_particle, 0.0); //Inf duartion
				i_rocket_particle[entity]= EntIndexToEntRef(particle);
				TeleportEntity(particle, NULL_VECTOR, vecAngles, NULL_VECTOR);
				SetParent(entity, particle);	
				SetEntityRenderMode(entity, RENDER_TRANSCOLOR); //Make it entirely invis.
				SetEntityRenderColor(entity, 255, 255, 255, 0);
			}
			
			TeleportEntity(entity, NULL_VECTOR, NULL_VECTOR, vecForward, true);
			SetEntityCollisionGroup(entity, 24); //our savior
			Set_Projectile_Collision(entity); //If red, set to 27
			See_Projectile_Team(entity);
			
			g_DHookRocketExplode.HookEntity(Hook_Pre, entity, Rocket_Particle_DHook_RocketExplodePre); //*yawn*
		//	SDKHook(entity, SDKHook_ShouldCollide, Never_ShouldCollide);
			SDKHook(entity, SDKHook_StartTouch, Rocket_Particle_StartTouch);
			return entity;
		}
		return -1;
	}
	public void FireGrenade(float vecTarget[3], float grenadespeed = 800.0, float damage, char[] model)
	{
		int entity = CreateEntityByName("tf_projectile_pipe");
		if(IsValidEntity(entity))
		{
			float vecForward[3], vecSwingStart[3], vecAngles[3];
			this.GetVectors(vecForward, vecSwingStart, vecAngles);
	
			vecSwingStart = GetAbsOrigin(this.index);
			vecSwingStart[2] += 90.0;
	
			MakeVectorFromPoints(vecSwingStart, vecTarget, vecAngles);
			GetVectorAngles(vecAngles, vecAngles);
	
			vecSwingStart[0] += vecForward[0] * 64;
			vecSwingStart[1] += vecForward[1] * 64;
			vecSwingStart[2] += vecForward[2] * 64;
	
			vecForward[0] = Cosine(DegToRad(vecAngles[0]))*Cosine(DegToRad(vecAngles[1]))*grenadespeed;
			vecForward[1] = Cosine(DegToRad(vecAngles[0]))*Sine(DegToRad(vecAngles[1]))*grenadespeed;
			vecForward[2] = Sine(DegToRad(vecAngles[0]))*-grenadespeed;
			
			SetEntPropEnt(entity, Prop_Send, "m_hOwnerEntity", this.index);
			SetEntPropEnt(entity, Prop_Send, "m_hThrower", this.index);
			
			SetEntPropFloat(entity, Prop_Send, "m_flDamage", 0.0); 
			f_CustomGrenadeDamage[entity] = damage;	
			SetEntProp(entity, Prop_Send, "m_iTeamNum", TFTeam_Blue);
			TeleportEntity(entity, vecSwingStart, vecAngles, NULL_VECTOR, true);
			DispatchSpawn(entity);
			SetEntityModel(entity, model);
			TeleportEntity(entity, NULL_VECTOR, NULL_VECTOR, vecForward, true);
			
			SetEntProp(entity, Prop_Send, "m_bTouched", true);
			SetEntityCollisionGroup(entity, 1);
		}
	}
	public int FireArrow(float vecTarget[3], float rocket_damage, float rocket_speed, const char[] rocket_model = "", float model_scale = 1.0, float offset = 0.0, int inflictor = INVALID_ENT_REFERENCE, int entitytofirefrom = -1) //No defaults, otherwise i cant even judge.
	{
		//ITS NOT actually an arrow, because of an ANNOOOOOOOOOOOYING sound.
		float vecForward[3], vecSwingStart[3], vecAngles[3];
		this.GetVectors(vecForward, vecSwingStart, vecAngles);

		if(entitytofirefrom == -1)
		{
			entitytofirefrom = this.index;
		}
		vecSwingStart = GetAbsOrigin(entitytofirefrom);
		vecSwingStart[2] += 54.0;

		vecSwingStart[2] += offset;

		MakeVectorFromPoints(vecSwingStart, vecTarget, vecAngles);
		GetVectorAngles(vecAngles, vecAngles);

		
		vecForward[0] = Cosine(DegToRad(vecAngles[0]))*Cosine(DegToRad(vecAngles[1]))*rocket_speed;
		vecForward[1] = Cosine(DegToRad(vecAngles[0]))*Sine(DegToRad(vecAngles[1]))*rocket_speed;
		vecForward[2] = Sine(DegToRad(vecAngles[0]))*-rocket_speed;

		int entity = CreateEntityByName("tf_projectile_rocket");
		if(IsValidEntity(entity))
		{
			b_EntityIsArrow[entity] = true;
			f_ArrowDamage[entity] = rocket_damage;
			h_ArrowInflictorRef[entity] = inflictor < 1 ? INVALID_ENT_REFERENCE : EntIndexToEntRef(inflictor);
			SetEntPropEnt(entity, Prop_Send, "m_hOwnerEntity", this.index);
			SetEntDataFloat(entity, FindSendPropInfo("CTFProjectile_Rocket", "m_iDeflected")+4, 0.0, true);	// Damage
			SetEntProp(entity, Prop_Send, "m_iTeamNum", GetEntProp(this.index, Prop_Send, "m_iTeamNum"));
			SetEntPropVector(entity, Prop_Send, "m_vInitialVelocity", vecForward);
			TeleportEntity(entity, vecSwingStart, vecAngles, NULL_VECTOR);
			DispatchSpawn(entity);
			if(rocket_model[0])
			{
				int g_ProjectileModelRocket = PrecacheModel(rocket_model);
				for(int i; i<4; i++)
				{
					SetEntProp(entity, Prop_Send, "m_nModelIndexOverrides", g_ProjectileModelRocket, _, i);
				}
			}
			else
			{
				for(int i; i<4; i++)
				{
					SetEntProp(entity, Prop_Send, "m_nModelIndexOverrides", g_modelArrow, _, i);
					
				//	int trail = Trail_Attach(entity, "effects/arrowtrail_blue.vmt", 255, 1.5, 12.0, 0.0, 4);
					int trail;
					if(b_IsAlliedNpc[this.index])
					{
						trail = Trail_Attach(entity, ARROW_TRAIL_RED, 255, 0.3, 3.0, 3.0, 5);
					}
					else
					{
						trail = Trail_Attach(entity, ARROW_TRAIL, 255, 0.3, 3.0, 3.0, 5);
					}
					
					f_ArrowTrailParticle[entity] = EntIndexToEntRef(trail);
					
					//Just use a timer tbh.
					
					CreateTimer(5.0, Timer_RemoveEntity, EntIndexToEntRef(trail), TIMER_FLAG_NO_MAPCHANGE);
				}
			}
			if(model_scale != 1.0)
			{
				SetEntPropFloat(entity, Prop_Send, "m_flModelScale", model_scale); // ZZZZ i sleep
			}
			TeleportEntity(entity, NULL_VECTOR, NULL_VECTOR, vecForward);
			SetEntityCollisionGroup(entity, 24); //our savior
			Set_Projectile_Collision(entity); //If red, set to 27
			See_Projectile_Team(entity);
			g_DHookRocketExplode.HookEntity(Hook_Pre, entity, Arrow_DHook_RocketExplodePre); //im lazy so ill reuse stuff that already works *yawn*
	//		SDKHook(entity, SDKHook_ShouldCollide, Never_ShouldCollide);
			SDKHook(entity, SDKHook_StartTouch, ArrowStartTouch);
		}
		return entity;
	}
	property int m_iActivity
	{
		public get()							{ return i_Activity[this.index]; }
		public set(int TempValueForProperty) 	{ i_Activity[this.index] = TempValueForProperty; }
	}
	
	property int m_iPoseMoveX 
	{
		public get()							{ return i_PoseMoveX[this.index]; }
		public set(int TempValueForProperty) 	{ i_PoseMoveX[this.index] = TempValueForProperty; }
	}
	
	property int m_iPoseMoveY
	{
		public get()							{ return i_PoseMoveY[this.index]; }
		public set(int TempValueForProperty) 	{ i_PoseMoveY[this.index] = TempValueForProperty; }
	}
	//Begin an animation activity, return false if we cant do that right now.
	public bool StartActivity(int iActivity, int flags = 0, bool Reset_Sequence_Info = true)
	{
		int nSequence = this.SelectWeightedSequence(iActivity);
		if (nSequence == 0) 
			return false;
		
		this.m_iActivity = iActivity;
		
		this.SetSequence(nSequence);
		this.SetPlaybackRate(1.0);
		this.SetCycle(0.0);
	
//		Crashes now for buildings, ignore.
		if(Reset_Sequence_Info)
		{
			this.ResetSequenceInfo();
		}
		
		return true;
	}
		
	public int LookupActivity(const char[] activity)
	{
		Address pStudioHdr = this.GetModelPtr();
		if(pStudioHdr == Address_Null)
			return -1;
		
		int value = SDKCall(g_hLookupActivity, pStudioHdr, activity);
		return value;
	}
	public int LookupSequence(const char[] sequence)
	{
		Address pStudioHdr = this.GetModelPtr();
		if(pStudioHdr == Address_Null)
			return -1;
			
		return SDKCall(g_hLookupSequence, pStudioHdr, sequence);
	}
	public void Update()
	{
		if (this.m_iPoseMoveX < 0) {
			this.m_iPoseMoveX = this.LookupPoseParameter("move_x");
		}
		if (this.m_iPoseMoveY < 0) {
			this.m_iPoseMoveY = this.LookupPoseParameter("move_y");
		}
		
		float flNextBotGroundSpeed = this.GetGroundSpeed();
		
		if (flNextBotGroundSpeed < 0.01) {
			if (this.m_iPoseMoveX >= 0) {
				this.SetPoseParameter(this.m_iPoseMoveX, 0.0);
			}
			if (this.m_iPoseMoveY >= 0) {
				this.SetPoseParameter(this.m_iPoseMoveY, 0.0);
			}
		} else {
			float vecFwd[3], vecRight[3], vecUp[3];
			this.GetVectors(vecFwd, vecRight, vecUp);
			
			float vecMotion[3]; this.GetGroundMotionVector(vecMotion);
			
			if (this.m_iPoseMoveX >= 0) {
				this.SetPoseParameter(this.m_iPoseMoveX, GetVectorDotProduct(vecMotion, vecFwd));
			}
			if (this.m_iPoseMoveY >= 0) {
				this.SetPoseParameter(this.m_iPoseMoveY, GetVectorDotProduct(vecMotion, vecRight));
			}
			
		}		
		
		this.GetBaseNPC().flRunSpeed = this.GetRunSpeed();
		this.GetBaseNPC().flWalkSpeed = this.GetRunSpeed();

		if(f_TimeFrozenStill[this.index] && f_TimeFrozenStill[this.index] < GetGameTime(this.index))
		{
			// Was frozen before, reset layers
			int layerCount = this.GetNumAnimOverlays();
			for(int i; i < layerCount; i++)
			{
				view_as<CClotBody>(this.index).SetLayerPlaybackRate(i, 1.0);
			}
			view_as<CClotBody>(this.index).SetPlaybackRate(f_LayerSpeedFrozeRestore[this.index]);

			if(IsValidEntity(view_as<CClotBody>(this.index).m_iFreezeWearable))
				RemoveEntity(view_as<CClotBody>(this.index).m_iFreezeWearable);

			f_TimeFrozenStill[this.index] = 0.0;
		}

		if(this.m_bisWalking) //This exists to make sure that if there is any idle animation played, it wont alter the playback rate and keep it at a flat 1, or anything altered that the user desires.
		{
			float m_flGroundSpeed = GetEntPropFloat(this.index, Prop_Data, "m_flGroundSpeed");
			if(m_flGroundSpeed != 0.0)
			{
				float PlaybackSpeed = clamp((flNextBotGroundSpeed / m_flGroundSpeed), -4.0, 12.0);
				PlaybackSpeed *= this.m_bisGiantWalkCycle;
				if(PlaybackSpeed > 2.0)
					PlaybackSpeed = 2.0;
					
				this.SetPlaybackRate(PlaybackSpeed);
			}
		}
		
		//Run and StuckMonitor
		if(this.m_flNextRunTime < GetGameTime())
		{
			this.m_flNextRunTime = GetGameTime() + 0.15; //Only update every 0.1 seconds, we really dont need more, 
			this.GetLocomotionInterface().Run();
		}
		if(this.m_bAllowBackWalking)
		{
			this.GetBaseNPC().flMaxYawRate = 0.0;
		}
		else
		{
			this.GetBaseNPC().flMaxYawRate = (NPC_DEFAULT_YAWRATE * this.GetDebuffPercentage() * f_NpcTurnPenalty[this.index]);
		}

		if(f_AvoidObstacleNavTime[this.index] < GetGameTime()) //add abit of delay for optimisation
		{
			CNavArea areaNavget;
			CNavArea areaNavget2;
			Segment segment;
			Segment segment2;
			segment = this.GetPathFollower().FirstSegment();
			if(segment != NULL_PATH_SEGMENT)
			{
				segment2 = this.GetPathFollower().NextSegment(segment);
				segment2 = this.GetPathFollower().NextSegment(segment2);
			}

			if(segment != NULL_PATH_SEGMENT && segment2 != NULL_PATH_SEGMENT)
			{
				areaNavget = segment.area;
				areaNavget2 = segment2.area;
			}

			b_AvoidObstacleType[this.index] = false;
			
			if(areaNavget != NULL_AREA && areaNavget2 != NULL_AREA)
			{
				int NavAttribs = areaNavget.GetAttributes();
				int NavAttribs2 = areaNavget2.GetAttributes();
				if(NavAttribs & NAV_MESH_WALK || NavAttribs2 & NAV_MESH_WALK)
				{
					b_AvoidObstacleType[this.index] = true;
				}
				if(NavAttribs & NAV_MESH_JUMP && NavAttribs2 & NAV_MESH_JUMP)
				{
					//They are in some position where we need to jump, lets jump.
					if(this.m_flJumpStartTimeInternal < GetGameTime())
					{
						this.m_flJumpStartTimeInternal = GetGameTime() + 2.0;
						float VecPos[3];
						areaNavget2.GetCenter(VecPos);
						PluginBot_Jump(this.index,VecPos);
					}
				}
			}
			f_AvoidObstacleNavTime[this.index] = GetGameTime() + 0.1;
		}

		//increace the size of the avoid box by 2x

		if(!b_AvoidObstacleType[this.index])
		{
			float ModelSize = GetEntPropFloat(this.index, Prop_Send, "m_flModelScale");
			//avoid obstacle code scales with modelsize, we dont want that.
			float f3_AvoidModifMax[3];
			float f3_AvoidModifMin[3];

			for(int axis; axis < 3; axis++)
			{
				f3_AvoidModifMax[axis] = f3_AvoidOverrideMax[this.index][axis];
				f3_AvoidModifMin[axis] = f3_AvoidOverrideMin[this.index][axis];
				f3_AvoidModifMax[axis] /= ModelSize;
				f3_AvoidModifMin[axis] /= ModelSize;
				if(this.m_bIsGiant) //giants need abit more space.
				{
					f3_AvoidModifMax[axis] *= 1.35;
					f3_AvoidModifMin[axis] *= 1.35;
				}
			}
			this.GetBaseNPC().SetBodyMaxs(f3_AvoidModifMax);
			this.GetBaseNPC().SetBodyMins(f3_AvoidModifMin);	
		}
		else
		{
			this.GetBaseNPC().SetBodyMaxs({1.0,1.0,1.0});
			this.GetBaseNPC().SetBodyMins({0.0,0.0,0.0});
		}
		
		if(this.m_bPathing)
			this.GetPathFollower().Update(this.GetBot());	

		this.GetBaseNPC().SetBodyMaxs(f3_AvoidOverrideMaxNorm[this.index]);
		this.GetBaseNPC().SetBodyMins(f3_AvoidOverrideMinNorm[this.index]);	
	}
	
	//return currently animating activity
	public int GetActivity()
	{
		return this.m_iActivity;
	}
	
	//return true if currently animating activity matches the given one
	public bool IsActivity(int iActivity)
	{
		return (iActivity == this.m_iActivity);
	}

	//return the bot's collision mask
	public int GetSolidMask()
	{
		//What to collide with
		return (MASK_NPCSOLID);
	}
	public int GetSolidMaskAlly()
	{
		//What to collide with
		return (MASK_NPCSOLID|MASK_PLAYERSOLID);
	}
	
	public void RestartMainSequence()
	{
		SetEntPropFloat(this.index, Prop_Data, "m_flAnimTime", GetGameTime());
		
		this.SetCycle(0.0);
	}
	
	public bool IsSequenceFinished()
	{
		return !!GetEntProp(this.index, Prop_Data, "m_bSequenceFinished");
	}
}

/*enum //hitgroup_t
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

void NPC_Precache()
{
	g_particleCritText = PrecacheParticleSystem("crit_text");
	g_particleMiniCritText = PrecacheParticleSystem("minicrit_text");
}

public Action NPC_TraceAttack(int victim, int& attacker, int& inflictor, float& damage, int& damagetype, int& ammotype, int hitbox, int hitgroup)
{
//	PrintToChatAll("ow NPC_TraceAttack");
	if(attacker < 1 || attacker > MaxClients || victim == attacker)
		return Plugin_Continue;
		
	if(inflictor < 1 || inflictor > MaxClients)
		return Plugin_Continue;

	
	if(GetEntProp(attacker, Prop_Send, "m_iTeamNum") == GetEntProp(victim, Prop_Send, "m_iTeamNum"))
	{
		damage = 0.0;
		return Plugin_Handled;
	}
	
	
	if((damagetype & (DMG_BLAST))) //make sure any hitscan boom type isnt actually boom
	{
		f_IsThisExplosiveHitscan[attacker] = GetGameTime();
		damagetype |= DMG_BULLET; //add bullet logic
		damagetype &= ~DMG_BLAST; //remove blast logic	
	}
	else
	{
		f_IsThisExplosiveHitscan[attacker] = 0.0;
	}
	
//	if((damagetype & (DMG_BULLET)) || (damagetype & (DMG_BUCKSHOT))) // Needed, other crap for some reason can trigger headshots, so just make sure only bullets can do this.
	int weapon = GetEntPropEnt(attacker, Prop_Send, "m_hActiveWeapon");
	if(IsValidEntity(weapon))
	{
		f_TraceAttackWasTriggeredSameFrame[victim] = GetGameTime();
		i_HasBeenHeadShotted[victim] = false;
		if(damagetype & DMG_BULLET)
		{
			if(i_WeaponDamageFalloff[weapon] != 1.0) //dont do calculations if its the default value, meaning no extra or less dmg from more or less range!
			{
				float AttackerPos[3];
				float VictimPos[3];
				
				AttackerPos = WorldSpaceCenter(attacker);
				VictimPos = WorldSpaceCenter(victim);

				float distance = GetVectorDistance(AttackerPos, VictimPos, true);
				
				distance -= 1600.0;// Give 60 units of range cus its not going from their hurt pos

				if(distance < 0.1)
				{
					distance = 0.1;
				}

				damage *= Pow(i_WeaponDamageFalloff[weapon], (distance/1000000.0)); //this is 1000, we use squared for optimisations sake
			}
		}
		if(!i_WeaponCannotHeadshot[weapon])
		{
			bool Blitzed_By_Riot = false;
			if(f_TargetWasBlitzedByRiotShield[victim][weapon] > GetGameTime())
			{
				Blitzed_By_Riot = true;
			}

			if((hitgroup == HITGROUP_HEAD && !b_CannotBeHeadshot[victim]) || Blitzed_By_Riot)
			{
				
#if defined ZR
				if(b_ThisNpcIsSawrunner[victim])
				{
					damage *= 2.0;
				}
#endif

				if(i_HeadshotAffinity[attacker] == 1)
				{
					damage *= 2.0;
				}
				else
				{
					damage *= 1.65;
				}

				if(Blitzed_By_Riot) //Extra damage.
				{
					damage *= 1.35;
				}
				else
				{
					i_HasBeenHeadShotted[victim] = true; //shouldnt count as an actual headshot!
				}

#if defined ZR
				if(i_CurrentEquippedPerk[attacker] == 5) //I guesswe can make it stack.
				{
					damage *= 1.25;
				}
#endif
				
				int pitch = GetRandomInt(90, 110);
				int random_case = GetRandomInt(1, 2);
				float volume = 0.7;
				
				if(played_headshotsound_already[attacker] >= GetGameTime())
				{
					random_case = played_headshotsound_already_Case[attacker];
					pitch = played_headshotsound_already_Pitch[attacker];
					volume = 0.15;
				}
				else
				{
					DisplayCritAboveNpc(victim, attacker, Blitzed_By_Riot);
					played_headshotsound_already_Case[attacker] = random_case;
					played_headshotsound_already_Pitch[attacker] = pitch;
				}
				
#if defined ZR
				if(i_ArsenalBombImplanter[weapon] > 0)
				{
					int BombsToInject = i_ArsenalBombImplanter[weapon];
					if(f_ChargeTerroriserSniper[weapon] > 149.0)
					{
						i_HowManyBombsOnThisEntity[victim][attacker] += BombsToInject * 2;
					}
					else
					{
						i_HowManyBombsOnThisEntity[victim][attacker] += BombsToInject;
					}
					if(i_CurrentEquippedPerk[attacker] == 5) //I guesswe can make it stack.
					{
						i_HowManyBombsOnThisEntity[victim][attacker] += BombsToInject;
					}
					if(i_HeadshotAffinity[attacker] == 1)
					{
						i_HowManyBombsOnThisEntity[victim][attacker] += BombsToInject;
					}
					Apply_Particle_Teroriser_Indicator(victim);
					damage = 0.0;
				}
#endif
				
				played_headshotsound_already[attacker] = GetGameTime();
				if(!Blitzed_By_Riot) //dont play headshot sound if blized.
				{
					switch(random_case)
					{
						case 1:
						{
							for(int client=1; client<=MaxClients; client++)
							{
								if(IsClientInGame(client) && client != attacker)
								{
									EmitCustomToClient(client, "zombiesurvival/headshot1.wav", victim, _, 80, _, volume, pitch);
								}
							}
							EmitCustomToClient(attacker, "zombiesurvival/headshot1.wav", _, _, 90, _, volume, pitch);
						}
						case 2:
						{
							for(int client=1; client<=MaxClients; client++)
							{
								if(IsClientInGame(client) && client != attacker)
								{
									EmitCustomToClient(client, "zombiesurvival/headshot2.wav", victim, _, 80, _, volume, pitch);
								}
							}
							EmitCustomToClient(attacker, "zombiesurvival/headshot2.wav", _, _, 90, _, volume, pitch);
						}
					}
				}
				return Plugin_Changed;
			}
			else
			{
				if(i_ArsenalBombImplanter[weapon] > 0)
				{
					int BombsToInject = i_ArsenalBombImplanter[weapon];
					if(i_HeadshotAffinity[attacker] == 1)
					{
						i_HowManyBombsOnThisEntity[victim][attacker] -= BombsToInject;
					}
				}
				if(i_HeadshotAffinity[attacker] == 1)
				{
					damage *= 0.65;
					return Plugin_Changed;
				}
				return Plugin_Changed;
			}
		}
	}
	return Plugin_Changed;
}

public void Map_BaseBoss_Damage_Post(int victim, int attacker, int inflictor, float damage, int damagetype) 
{
	if(attacker < 1 || attacker > MaxClients)
		return;
	
	int Health = GetEntProp(victim, Prop_Data, "m_iHealth");
}

public Action NPC_OnTakeDamage(int victim, int &attacker, int &inflictor, float &damage, int &damagetype, int &weapon, float damageForce[3], float damagePosition[3], int damagecustom)
{
	bool WeaponWasValid = false;
	if(IsValidEntity(weapon))
		WeaponWasValid = true;

	float GameTime = GetGameTime();
	b_DoNotDisplayHurtHud[victim] = false;

	// if your damage is higher then a million, we give up and let it through, theres multiple reasons why, mainly slaying.
	if(b_NpcIsInvulnerable[victim] && damage < 9999999.9)
	{
		damage = 0.0;
		Damageaftercalc = 0.0;
		return Plugin_Handled;
	}
	CClotBody npcBase = view_as<CClotBody>(victim);
	
	bool GuranteedGib = false;
	if((i_HexCustomDamageTypes[victim] & ZR_SLAY_DAMAGE))
	{
		return Plugin_Changed;
	}

	if(Rogue_Mode() && !b_IsAlliedNpc[victim])
	{
		int scale = Rogue_GetRoundScale();
		if(scale < 2)
		{
			damage *= 1.6667;
		}
	}

	if(attacker < 0 || victim == attacker)
	{
		Damageaftercalc = 0.0;
		return Plugin_Handled;
		//nothing happens.
	}
	else if(damage < 9999999.9)
	{
		if(!(i_HexCustomDamageTypes[victim] & ZR_DAMAGE_NOAPPLYBUFFS_OR_DEBUFFS))
		{
			if(NullfyDamageAndNegate(victim, attacker, inflictor, damage, damagetype, weapon,damagecustom))
			{
				Damageaftercalc = 0.0;
				return Plugin_Handled;	
			}
			

			if(OnTakeDamageAbsolutes(victim, attacker, inflictor, damage, damagetype, weapon, GameTime))
			{
				Damageaftercalc = 0.0;
				return Plugin_Handled;	
			}

#if defined RPG
			if(OnTakeDamageRpgPartyLogic(victim, attacker, inflictor, damage, damagetype, weapon, damageForce, damagePosition,damagecustom, GameTime))
			{
				Damageaftercalc = 0.0;
				return Plugin_Handled;	
			}

			OnTakeDamageRpgDungeonLogic(victim, attacker, inflictor, damage, damagetype, weapon, damageForce, damagePosition,damagecustom, GameTime);
#endif		
			if(!(damagetype & DMG_NOCLOSEDISTANCEMOD))
			{
				damagetype |= DMG_NOCLOSEDISTANCEMOD; 
			}
			if(damagetype & DMG_USEDISTANCEMOD)
			{
				damagetype &= ~DMG_USEDISTANCEMOD;
			}
			//Decide Damage falloff ourselves.

			//This exists for rpg so that attacking the target will trigger it for hte next 5 seconds.
			//ZR does not need this.
#if defined RPG
			OnTakeDamageRpgAgressionOnHit(victim, attacker, inflictor, damage, damagetype, weapon, damageForce, damagePosition,damagecustom, GameTime);
#endif		
			OnTakeDamageNpcBaseArmorLogic(victim, attacker, inflictor, damage, damagetype, weapon);

#if defined ZR
			VausMagicaShieldLogicNpcOnTakeDamage(victim, damage);

			OnTakeDamageWidowsWine(victim, attacker, inflictor, damage, damagetype, weapon, GameTime);

			if(Rogue_InItallianWrath(weapon))
			{
				damage *= 2.0;
			}
			OnTakeDamage_RogueItemGeneric(attacker, damage, damagetype, inflictor);
#endif
			OnTakeDamageDamageBuffs(victim, attacker, inflictor, damage, damagetype, weapon, GameTime);


			OnTakeDamageResistanceBuffs(victim, attacker, inflictor, damage, damagetype, weapon, GameTime);
			
			if(attacker <= MaxClients && attacker > 0)
				OnTakeDamagePlayerSpecific(victim, attacker, inflictor, damage, damagetype, weapon, GuranteedGib);
		
			OnTakeDamageBuildingBonusDamage(attacker, inflictor, damage, damagetype, weapon, GameTime);

#if defined ZR			
			OnTakeDamageScalingWaveDamage(attacker, inflictor, damage, damagetype, weapon);
#endif
			OnTakeDamageVehicleDamage(attacker, inflictor, damage, damagetype);

			if(attacker <= MaxClients && attacker > 0)
			{
				if(!(i_HexCustomDamageTypes[victim] & ZR_DAMAGE_DO_NOT_APPLY_BURN_OR_BLEED))
				{
					DoClientHitmarker(attacker);
				}
#if defined RPG
				OnTakeDamageRpgPotionBuff(victim, attacker, inflictor, damage, damagetype, weapon, damageForce, damagePosition,damagecustom, GameTime);
#endif
				if(!(i_HexCustomDamageTypes[victim] & ZR_DAMAGE_DO_NOT_APPLY_BURN_OR_BLEED))
				{
					if(WeaponWasValid)
					{
						float modified_damage = NPC_OnTakeDamage_Equipped_Weapon_Logic(victim, attacker, inflictor, damage, damagetype, weapon, damageForce, damagePosition, i_HexCustomDamageTypes[victim]);	
						damage = modified_damage;
#if defined ZR		
						OnTakeDamage_HandOfElderMages(attacker, weapon);
#endif
						OnTakeDamageOldExtraWeapons(victim, attacker, inflictor, damage, damagetype, weapon, GameTime);
						OnTakeDamageBackstab(victim, attacker, inflictor, damage, damagetype, weapon, GameTime);
					}
				}
				if(TF2_IsPlayerInCondition(attacker, TFCond_NoHealingDamageBuff) || damagetype & DMG_CRIT)
				{		
					damage *= 1.35;
					bool PlaySound = false;
					if(f_MinicritSoundDelay[attacker] < GetGameTime())
					{
						PlaySound = true;
						f_MinicritSoundDelay[attacker] = GetGameTime() + 0.25;
					}
					
					DisplayCritAboveNpc(victim, attacker, PlaySound,_,_,true); //Display crit above head
					
					damagetype &= ~DMG_CRIT;
				}
			}	
		}
		NpcSpecificOnTakeDamage(victim, attacker, inflictor, damage, damagetype, weapon, damageForce, damagePosition, damagecustom);
		if(!(i_HexCustomDamageTypes[victim] & ZR_DAMAGE_NOAPPLYBUFFS_OR_DEBUFFS))
		{
#if defined ZR	
			if(SeargentIdeal_Existant())
			{
				SeargentIdeal_Protect(victim, attacker, inflictor, damage, damagetype, weapon, damageForce, damagePosition);
				if(damage == 0.0)
				{
					b_DoNotDisplayHurtHud[victim] = true;
					return Plugin_Handled;
				}
			}
#endif
			if(attacker <= MaxClients && attacker > 0)
			{
				if(WeaponWasValid)
				{
					float modified_damage = NPC_OnTakeDamage_Equipped_Weapon_Logic_PostCalc(victim, attacker, inflictor, damage, damagetype, weapon, damageForce, damagePosition);	
					damage = modified_damage;
				}
			}
		}
	}


	OnTakeDamageBleedNpc(victim, attacker, inflictor, damage, damagetype, weapon, damagePosition, GameTime);
	npcBase.m_vecpunchforce(damageForce, true);
	npcBase.m_bGib = false;
	if(!npcBase.m_bDissapearOnDeath) //Make sure that if they just vanish, its always false. so their deathsound plays.
	{
		if((damagetype & DMG_BLAST))
		{
			npcBase.m_bGib = true;
		}
		else if((i_HexCustomDamageTypes[victim] & ZR_DAMAGE_GIB_REGARDLESS))
		{
			npcBase.m_bGib = true;
		}
		else if(damage > (GetEntProp(victim, Prop_Data, "m_iMaxHealth") * 1.5))
		{
			npcBase.m_bGib = true;
		}
	}
#if defined ZR
	if(RogueFizzyDrink())
	{
		npcBase.m_bGib = true;
	}
#endif
	if(GuranteedGib)
	{
		npcBase.m_bGib = true;
	}

	if(damage <= 0.0)
	{
		Damageaftercalc = 0.0;
		return Plugin_Handled;	
	}
	Damageaftercalc = damage;
	
	return Plugin_Changed;
}

public void NPC_OnTakeDamage_Post(int victim, int attacker, int inflictor, float damage, int damagetype, int weapon, const float damageForce[3], const float damagePosition[3])
{
	if(GetEntProp(attacker, Prop_Send, "m_iTeamNum") == GetEntProp(victim, Prop_Send, "m_iTeamNum"))
		return;
		
	int health = GetEntProp(victim, Prop_Data, "m_iHealth");
	if((Damageaftercalc > 0.0 || (weapon > -1 && i_ArsenalBombImplanter[weapon] > 0)) && !b_NpcIsInvulnerable[victim] && !b_DoNotDisplayHurtHud[victim]) //make sure to still show it if they are invinceable!
	{
		if(inflictor > 0 && inflictor <= MaxClients)
		{
			GiveRageOnDamage(inflictor, Damageaftercalc);
			Calculate_And_Display_hp(inflictor, victim, Damageaftercalc, false);
		}
		else if(attacker > 0 && attacker <= MaxClients)
		{
			GiveRageOnDamage(attacker, Damageaftercalc);
			Calculate_And_Display_hp(attacker, victim, Damageaftercalc, false);	
		}
		OnPostAttackUniqueWeapon(attacker, victim, weapon, i_HexCustomDamageTypes[victim]);


		Event event = CreateEvent("npc_hurt");
		if(event) 
		{
			event.SetInt("entindex", victim);
			event.SetInt("health", health);
			event.SetInt("damageamount", RoundToFloor(Damageaftercalc));
			event.SetBool("crit", (damagetype & DMG_ACID) == DMG_ACID);

			if(attacker > 0 && attacker <= MaxClients)
			{
				event.SetInt("attacker_player", GetClientUserId(attacker));
				event.SetInt("weaponid", 0);
			}
			else 
			{
				event.SetInt("attacker_player", 0);
				event.SetInt("weaponid", 0);
			}

			event.Fire();
		}
	}

	i_HexCustomDamageTypes[victim] = 0; //Reset it back to 0.
	if(health <= 0)
		CBaseCombatCharacter_EventKilledLocal(victim, attacker, inflictor, Damageaftercalc, damagetype, weapon, damageForce, damagePosition);

	Damageaftercalc = 0.0;
}

void GiveRageOnDamage(int client, float damage)
{
	if(!GetEntProp(client, Prop_Send, "m_bRageDraining"))
	{
		float rage = GetEntPropFloat(client, Prop_Send, "m_flRageMeter") + (damage * 0.05);
		if(rage > 100.0)
			rage = 100.0;
			
		SetEntPropFloat(client, Prop_Send, "m_flRageMeter", rage);
	}
}

stock void Generic_OnTakeDamage(int victim, int attacker)
{
	if(attacker > 0)
	{
		CClotBody npc = view_as<CClotBody>(victim);
		float gameTime = GetGameTime(npc.index);

		if(npc.m_flHeadshotCooldown < gameTime)
		{
			npc.m_flHeadshotCooldown = gameTime + DEFAULT_HURTDELAY;
			npc.m_blPlayHurtAnimation = true;
		}
	}
}

stock void Calculate_And_Display_hp(int attacker, int victim, float damage, bool ignore, int overkill = 0)
{
	b_DisplayDamageHud[attacker] = true;
	i_HudVictimToDisplay[attacker] = victim;
	float GameTime = GetGameTime();
	bool raidboss_active = false;
	if(!b_NpcIsInvulnerable[victim])
	{
#if defined ZR
		if(IsValidEntity(EntRefToEntIndex(RaidBossActive)))
		{
			raidboss_active = true;
		}
		if(overkill <= 0)
		{
			Damage_dealt_in_total[attacker] += damage;
		}
		else
		{
			Damage_dealt_in_total[attacker] += overkill; //dont award for overkilling.
		}
#endif
		if(GameTime > f_damageAddedTogetherGametime[attacker])
		{
			if(!raidboss_active)
			{
				f_damageAddedTogether[attacker] = 0.0; //reset to 0 if raid isnt active.
			}
		}
		if(!ignore) //Cannot be a just show function
		{
			f_damageAddedTogether[attacker] += damage;
		}
		if(damage > 0)
		{
			f_damageAddedTogetherGametime[attacker] = GameTime + 0.6;
		}
	}
}


enum PlayerAnimEvent_t
{
0	PLAYERANIMEVENT_ATTACK_PRIMARY, 	
1	PLAYERANIMEVENT_ATTACK_SECONDARY,
2	PLAYERANIMEVENT_ATTACK_GRENADE,
3	PLAYERANIMEVENT_RELOAD,
4	PLAYERANIMEVENT_RELOAD_LOOP,
5	PLAYERANIMEVENT_RELOAD_END,
6	PLAYERANIMEVENT_JUMP,
7	PLAYERANIMEVENT_SWIM,
8	PLAYERANIMEVENT_DIE,
9	PLAYERANIMEVENT_FLINCH_CHEST,
10	PLAYERANIMEVENT_FLINCH_HEAD,
11	PLAYERANIMEVENT_FLINCH_LEFTARM,
12	PLAYERANIMEVENT_FLINCH_RIGHTARM,
13	PLAYERANIMEVENT_FLINCH_LEFTLEG,
14	PLAYERANIMEVENT_FLINCH_RIGHTLEG,
15	PLAYERANIMEVENT_DOUBLEJUMP,

	// Cancel.
16	PLAYERANIMEVENT_CANCEL,
17	PLAYERANIMEVENT_SPAWN,

	// Snap to current yaw exactly
18	PLAYERANIMEVENT_SNAP_YAW,

19	PLAYERANIMEVENT_CUSTOM,				// Used to play specific activities
20	PLAYERANIMEVENT_CUSTOM_GESTURE,
21	PLAYERANIMEVENT_CUSTOM_SEQUENCE,	// Used to play specific sequences
22	PLAYERANIMEVENT_CUSTOM_GESTURE_SEQUENCE,

	// TF Specific. Here until there's a derived game solution to this.
23	PLAYERANIMEVENT_ATTACK_PRE,
24	PLAYERANIMEVENT_ATTACK_POST,
25	PLAYERANIMEVENT_GRENADE1_DRAW,
26	PLAYERANIMEVENT_GRENADE2_DRAW,
27	PLAYERANIMEVENT_GRENADE1_THROW,
28	PLAYERANIMEVENT_GRENADE2_THROW,
29	PLAYERANIMEVENT_VOICE_COMMAND_GESTURE,
30	PLAYERANIMEVENT_DOUBLEJUMP_CROUCH,
31	PLAYERANIMEVENT_STUN_BEGIN,
32	PLAYERANIMEVENT_STUN_MIDDLE,
33	PLAYERANIMEVENT_STUN_END,
34	PLAYERANIMEVENT_PASSTIME_THROW_BEGIN,
35	PLAYERANIMEVENT_PASSTIME_THROW_MIDDLE,
36	PLAYERANIMEVENT_PASSTIME_THROW_END,
37	PLAYERANIMEVENT_PASSTIME_THROW_CANCEL,

38	PLAYERANIMEVENT_ATTACK_PRIMARY_SUPER,

39	PLAYERANIMEVENT_COUNT
};
*/