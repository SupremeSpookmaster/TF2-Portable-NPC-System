#pragma semicolon 1
#pragma newdecls required

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
		baseNPC.flMaxYawRate = NPC_DEFAULT_YAWRATE;
		baseNPC.flDeathDropHeight = 999999.0;

		CBaseNPC_Locomotion locomotion = baseNPC.GetLocomotion();

		SetEntProp(npc, Prop_Data, "m_bSequenceLoops", true);
		//potentially newly added ? or might not get set ?
		//Just set it to true at all times.
		if(Ally)
		{
			SetEntityCollisionGroup(npc, 24);
		}
		else
		{
			AddNpcToAliveList(npc, 0);
		}
		
		b_NpcCollisionType[npc] = 0;
		if(!Ally)
		{
#if defined ZR
			if(IgnoreBuildings || (!VIPBuilding_Active() && IsValidEntity(EntRefToEntIndex(RaidBossActive)))) //During an active raidboss, make sure that they ignore barricades
#else
			if(IgnoreBuildings)
#endif
			{
#if defined ZR
				if(VIPBuilding_Active())
				{
					f_AvoidObstacleNavTime[npc] = FAR_FUTURE;
					b_AvoidObstacleType[npc] = true;
					Change_Npc_Collision(npc, num_ShouldCollideEnemyTDIgnoreBuilding);
				}
				else
#endif
				{
					Change_Npc_Collision(npc, num_ShouldCollideEnemyIngoreBuilding);
				}
			}
			else
			{
#if defined ZR
				if(VIPBuilding_Active())
				{
					f_AvoidObstacleNavTime[npc] = FAR_FUTURE;
					b_AvoidObstacleType[npc] = true;
					Change_Npc_Collision(npc, num_ShouldCollideEnemyTD);
				}
				else
#endif
				{
					Change_Npc_Collision(npc, num_ShouldCollideEnemy);
				}
			}
		}
		else
		{
			if(Ally_Invince)
			{
				Change_Npc_Collision(npc, num_ShouldCollideAllyInvince);
			}
			else
			{
				Change_Npc_Collision(npc, num_ShouldCollideAlly);
			}
		}

		locomotion.SetCallback(LocomotionCallback_IsEntityTraversable, IsEntityTraversable);
		view_as<CBaseAnimating>(npc).Hook_HandleAnimEvent(CBaseAnimating_HandleAnimEvent);
		
		//so map makers can choose between NPCs and Clients
		
		if(!Ally || ForceNpcClipping)
			h_NpcSolidHookType[npc] = DHookRaw(g_hGetSolidMask, true, view_as<Address>(baseNPC.GetBody()));
		else
			h_NpcSolidHookType[npc] = DHookRaw(g_hGetSolidMaskAlly, true, view_as<Address>(baseNPC.GetBody()));


		SetEntityFlags(npc, FL_NPC);
		
		SetEntProp(npc, Prop_Data, "m_nSolidType", 2); 

		//Don't bleed.
		SetEntProp(npc, Prop_Data, "m_bloodColor", -1); //Don't bleed
		
		b_BoundingBoxVariant[npc] = 0; //This will tell lag compensation what to revert to once the calculations are done.
		static float m_vecMaxs[3];
		static float m_vecMins[3];
		if(isGiant)
		{
			b_IsGiant[npc] = true;
			b_BoundingBoxVariant[npc] = 1;
			m_vecMaxs = view_as<float>( { 30.0, 30.0, 120.0 } );
			m_vecMins = view_as<float>( { -30.0, -30.0, 0.0 } );	
		}			
		else
		{
			m_vecMaxs = view_as<float>( { 24.0, 24.0, 82.0 } );
			m_vecMins = view_as<float>( { -24.0, -24.0, 0.0 } );		
		}

		if(CustomThreeDimensions[1] != 0.0)
		{
			f3_CustomMinMaxBoundingBox[npc][0] = CustomThreeDimensions[0];
			f3_CustomMinMaxBoundingBox[npc][1] = CustomThreeDimensions[1];
			f3_CustomMinMaxBoundingBox[npc][2] = CustomThreeDimensions[2];

			m_vecMaxs[0] = f3_CustomMinMaxBoundingBox[npc][0];
			m_vecMaxs[1] = f3_CustomMinMaxBoundingBox[npc][1];
			m_vecMaxs[2] = f3_CustomMinMaxBoundingBox[npc][2];

			m_vecMins[0] = -f3_CustomMinMaxBoundingBox[npc][0];
			m_vecMins[1] = -f3_CustomMinMaxBoundingBox[npc][1];
			m_vecMins[2] = 0.0;
		}
		
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

		f3_AvoidOverrideMin[npc] = m_vecMins_Body;
		f3_AvoidOverrideMax[npc] = m_vecMaxs_Body;
		f3_AvoidOverrideMinNorm[npc] = m_vecMins;
		f3_AvoidOverrideMaxNorm[npc] = m_vecMaxs;
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
		


#if defined ZR
		if(Ally && !Ally_Collideeachother)
		{
			npcstats.m_iTeamGlow = TF2_CreateGlow(npc);
			
			SetVariantColor(view_as<int>({184, 56, 59, 200}));
			AcceptEntityInput(npcstats.m_iTeamGlow, "SetGlowColor");
		}
#endif
		
		SDKHook(npc, SDKHook_Think, NpcBaseThink);
		SDKHook(npc, SDKHook_ThinkPost, NpcBaseThinkPost);
//		SDKHook(npc, SDKHook_SetTransmit, SDKHook_Settransmit_Baseboss);
		
		b_ThisWasAnNpc[npc] = true;

		if(IsRaidBoss)
		{
			RemoveAllDamageAddition();
		}
	
		return view_as<CClotBody>(npc);
	}	//THIS IS THE END OF THE NPC_CREATION METHOD
		property int index 
	{ 
		public get() { return view_as<int>(this); } 
	}
	public void PlayGibSound() { //ehehee this sound is funny 
		int sound = GetRandomInt(0, sizeof(g_GibSound) - 1);
	
		EmitSoundToAll(g_GibSound[sound], this.index, SNDCHAN_AUTO, 80, _, 1.0, _, _);
		EmitSoundToAll(g_GibSound[sound], this.index, SNDCHAN_AUTO, 80, _, 1.0, _, _);
		EmitSoundToAll(g_GibSound[sound], this.index, SNDCHAN_AUTO, 80, _, 1.0, _, _);
	}
	public void PlayGibSoundMetal() { //ehehee this sound is funny 
		int sound = GetRandomInt(0, sizeof(g_GibSoundMetal) - 1);
	
		EmitSoundToAll(g_GibSoundMetal[sound], this.index, SNDCHAN_AUTO, 80, _, 1.0, _, _);
		EmitSoundToAll(g_GibSoundMetal[sound], this.index, SNDCHAN_AUTO, 80, _, 1.0, _, _);
		EmitSoundToAll(g_GibSoundMetal[sound], this.index, SNDCHAN_AUTO, 80, _, 1.0, _, _);
	}
	public void PlayStepSound(const char[] sound, float volume = 1.0, int Npc_Type = 1, bool custom = false)
	{
		if(!custom)
		{
			switch(Npc_Type)
			{
				case STEPSOUND_NORMAL: //normal
				{
					EmitSoundToAll(sound, this.index, SNDCHAN_AUTO, 80, _, volume, 100, _);
				}
				case STEPSOUND_GIANT: //giant
				{
					EmitSoundToAll(sound, this.index, SNDCHAN_AUTO, 80, _, volume, 80, _);
				}
				
			}
		}
		else
		{
			switch(Npc_Type)
			{
				case STEPSOUND_NORMAL: //normal
				{
					EmitCustomToAll(sound, this.index, SNDCHAN_AUTO, 80, _, volume, 100, _);
				}
				case STEPSOUND_GIANT: //giant
				{
					EmitCustomToAll(sound, this.index, SNDCHAN_AUTO, 80, _, volume, 80, _);
				}
			}			
		}
	//	PrintToServer("%i PlayStepSound(\"%s\")", this.index, sound);
	}
	
	property int m_iOverlordComboAttack
	{
		public get()							{ return i_OverlordComboAttack[this.index]; }
		public set(int TempValueForProperty) 	{ i_OverlordComboAttack[this.index] = TempValueForProperty; }
	}
	property int m_iTargetAlly
	{
		public get()							{ return i_TargetAlly[this.index]; }
		public set(int TempValueForProperty) 	{ i_TargetAlly[this.index] = TempValueForProperty; }
	}
	property bool m_bGetClosestTargetTimeAlly
	{
		public get()							{ return b_GetClosestTargetTimeAlly[this.index]; }
		public set(bool TempValueForProperty) 	{ b_GetClosestTargetTimeAlly[this.index] = TempValueForProperty; }
	}
	property bool m_bWasSadAlready
	{
		public get()							{ return b_WasSadAlready[this.index]; }
		public set(bool TempValueForProperty) 	{ b_WasSadAlready[this.index] = TempValueForProperty; }
	}
	property int m_iChanged_WalkCycle
	{
		public get()							{ return i_Changed_WalkCycle[this.index]; }
		public set(int TempValueForProperty) 	{ i_Changed_WalkCycle[this.index] = TempValueForProperty; }
	}
	property float m_flDuration
	{
		public get()							{ return fl_Duration[this.index]; }
		public set(float TempValueForProperty) 	{ fl_Duration[this.index] = TempValueForProperty; }
	}
	property float m_flExtraDamage
	{
		public get()							{ return fl_ExtraDamage[this.index]; }
		public set(float TempValueForProperty) 	{ fl_ExtraDamage[this.index] = TempValueForProperty; }
	}
	property float m_flHurtie
	{
		public get()							{ return fl_Hurtie[this.index]; }
		public set(float TempValueForProperty) 	{ fl_Hurtie[this.index] = TempValueForProperty; }
	}
	property float m_flheal_cooldown
	{
		public get()							{ return fl_heal_cooldown[this.index]; }
		public set(float TempValueForProperty) 	{ fl_heal_cooldown[this.index] = TempValueForProperty; }
	}
	property float m_flidle_talk
	{
		public get()							{ return fl_idle_talk[this.index]; }
		public set(float TempValueForProperty) 	{ fl_idle_talk[this.index] = TempValueForProperty; }
	}
	property float m_flDoingSpecial
	{
		public get()							{ return fl_DoingSpecial[this.index]; }
		public set(float TempValueForProperty) 	{ fl_DoingSpecial[this.index] = TempValueForProperty; }
	}
	property float m_flComeToMe
	{
		public get()							{ return fl_ComeToMe[this.index]; }
		public set(float TempValueForProperty) 	{ fl_ComeToMe[this.index] = TempValueForProperty; }
	}
	property int m_iMedkitAnnoyance
	{
		public get()							{ return i_MedkitAnnoyance[this.index]; }
		public set(int TempValueForProperty) 	{ i_MedkitAnnoyance[this.index] = TempValueForProperty; }
	}
	property bool m_b_stand_still
	{
		public get()							{ return b_stand_still[this.index]; }
		public set(bool TempValueForProperty) 	{ b_stand_still[this.index] = TempValueForProperty; }
	}
	
	
	property bool m_b_follow
	{
		public get()							{ return b_follow[this.index]; }
		public set(bool TempValueForProperty) 	{ b_follow[this.index] = TempValueForProperty; }
	}
	property bool m_bmovedelay_walk
	{
		public get()							{ return b_movedelay_walk[this.index]; }
		public set(bool TempValueForProperty) 	{ b_movedelay_walk[this.index] = TempValueForProperty; }
	}
	property bool m_bmovedelay_run
	{
		public get()							{ return b_movedelay_run[this.index]; }
		public set(bool TempValueForProperty) 	{ b_movedelay_run[this.index] = TempValueForProperty; }
	}
	property bool m_bIsFriendly
	{
		public get()							{ return b_IsFriendly[this.index]; }
		public set(bool TempValueForProperty) 	{ b_IsFriendly[this.index] = TempValueForProperty; }
	}
	property bool m_bReloaded
	{
		public get()							{ return b_Reloaded[this.index]; }
		public set(bool TempValueForProperty) 	{ b_Reloaded[this.index] = TempValueForProperty; }
	}
	
	property float m_flFollowing_Master_Now
	{
		public get()							{ return fl_Following_Master_Now[this.index]; }
		public set(float TempValueForProperty) 	{ fl_Following_Master_Now[this.index] = TempValueForProperty; }
	}
	property float m_flHookDamageTaken
	{
		public get()							{ return fl_HookDamageTaken[this.index]; }
		public set(float TempValueForProperty) 	{ fl_HookDamageTaken[this.index] = TempValueForProperty; }
	}
	property float m_flGrappleCooldown
	{
		public get()							{ return fl_GrappleCooldown[this.index]; }
		public set(float TempValueForProperty) 	{ fl_GrappleCooldown[this.index] = TempValueForProperty; }
	}
	property float m_flStandStill
	{
		public get()							{ return fl_StandStill[this.index]; }
		public set(float TempValueForProperty) 	{ fl_StandStill[this.index] = TempValueForProperty; }
	}
	property float m_flNextFlameSound
	{
		public get()							{ return fl_NextFlameSound[this.index]; }
		public set(float TempValueForProperty) 	{ fl_NextFlameSound[this.index] = TempValueForProperty; }
	}
	property float m_flFlamerActive
	{
		public get()							{ return fl_FlamerActive[this.index]; }
		public set(float TempValueForProperty) 	{ fl_FlamerActive[this.index] = TempValueForProperty; }
	}
	property float m_flWaveScale
	{
		public get()							{ return fl_WaveScale[this.index]; }
		public set(float TempValueForProperty) 	{ fl_WaveScale[this.index] = TempValueForProperty; }
	}
	
	property bool m_bDoSpawnGesture
	{
		public get()							{ return b_DoSpawnGesture[this.index]; }
		public set(bool TempValueForProperty) 	{ b_DoSpawnGesture[this.index] = TempValueForProperty; }
	}
	property bool m_bLostHalfHealth
	{
		public get()							{ return b_LostHalfHealth[this.index]; }
		public set(bool TempValueForProperty) 	{ b_LostHalfHealth[this.index] = TempValueForProperty; }
	}
	property bool m_bLostHalfHealthAnim
	{
		public get()							{ return b_LostHalfHealthAnim[this.index]; }
		public set(bool TempValueForProperty) 	{ b_LostHalfHealthAnim[this.index] = TempValueForProperty; }
	}
	property bool m_bDuringHighFlight
	{
		public get()							{ return b_DuringHighFlight[this.index]; }
		public set(bool TempValueForProperty) 	{ b_DuringHighFlight[this.index] = TempValueForProperty; }
	}
	property bool m_bDuringHook
	{
		public get()							{ return b_DuringHook[this.index]; }
		public set(bool TempValueForProperty) 	{ b_DuringHook[this.index] = TempValueForProperty; }
	}
	property bool m_bGrabbedSomeone
	{
		public get()							{ return b_GrabbedSomeone[this.index]; }
		public set(bool TempValueForProperty) 	{ b_GrabbedSomeone[this.index] = TempValueForProperty; }
	}
	property bool m_bUseDefaultAnim
	{
		public get()							{ return b_UseDefaultAnim[this.index]; }
		public set(bool TempValueForProperty) 	{ b_UseDefaultAnim[this.index] = TempValueForProperty; }
	}
	property bool m_bFlamerToggled
	{
		public get()							{ return b_FlamerToggled[this.index]; }
		public set(bool TempValueForProperty) 	{ b_FlamerToggled[this.index] = TempValueForProperty; }
	}
	property bool m_bCamo
	{
		public get()							{ return b_IsCamoNPC[this.index]; }
		public set(bool TempValueForProperty) 	{ b_IsCamoNPC[this.index] = TempValueForProperty; }
	}
	property bool m_bNoKillFeed
	{
		public get()							{ return b_NoKillFeed[this.index]; }
		public set(bool TempValueForProperty) 	{ b_NoKillFeed[this.index] = TempValueForProperty; }
	}
	property bool m_bmovedelay_gun
	{
		public get()							{ return b_movedelay_gun[this.index]; }
		public set(bool TempValueForProperty) 	{ b_movedelay_gun[this.index] = TempValueForProperty; }
	}
	property bool m_flHalf_Life_Regen
	{
		public get()							{ return b_Half_Life_Regen[this.index]; }
		public set(bool TempValueForProperty) 	{ b_Half_Life_Regen[this.index] = TempValueForProperty; }
	}
	property float m_flDead_Ringer_Invis
	{
		public get()							{ return fl_Dead_Ringer_Invis[this.index]; }
		public set(float TempValueForProperty) 	{ fl_Dead_Ringer_Invis[this.index] = TempValueForProperty; }
	}
	property float m_flDead_Ringer
	{
		public get()							{ return fl_Dead_Ringer[this.index]; }
		public set(float TempValueForProperty) 	{ fl_Dead_Ringer[this.index] = TempValueForProperty; }
	}
	property bool m_flDead_Ringer_Invis_bool
	{
		public get()							{ return b_Dead_Ringer_Invis_bool[this.index]; }
		public set(bool TempValueForProperty) 	{ b_Dead_Ringer_Invis_bool[this.index] = TempValueForProperty; }
	}
	property int m_iAttacksTillMegahit
	{
		public get()							{ return i_AttacksTillMegahit[this.index]; }
		public set(int TempValueForProperty) 	{ i_AttacksTillMegahit[this.index] = TempValueForProperty; }
	}
	property float m_flCharge_Duration
	{
		public get()							{ return fl_Charge_Duration[this.index]; }
		public set(float TempValueForProperty) 	{ fl_Charge_Duration[this.index] = TempValueForProperty; }
	}
	property float m_flCharge_delay
	{
		public get()							{ return fl_Charge_delay[this.index]; }
		public set(float TempValueForProperty) 	{ fl_Charge_delay[this.index] = TempValueForProperty; }
	}
	property int g_TimesSummoned
	{
		public get()							{ return i_TimesSummoned[this.index]; }
		public set(int TempValueForProperty) 	{ i_TimesSummoned[this.index] = TempValueForProperty; }
	}
	property float m_flAttackHappens_2
	{
		public get()							{ return fl_AttackHappens_2[this.index]; }
		public set(float TempValueForProperty) 	{ fl_AttackHappens_2[this.index] = TempValueForProperty; }
	}
	property bool m_bFUCKYOU
	{
		public get()							{ return b_FUCKYOU[this.index]; }
		public set(bool TempValueForProperty) 	{ b_FUCKYOU[this.index] = TempValueForProperty; }
	}
	property bool m_bFUCKYOU_move_anim
	{
		public get()							{ return b_FUCKYOU_move_anim[this.index]; }
		public set(bool TempValueForProperty) 	{ b_FUCKYOU_move_anim[this.index] = TempValueForProperty; }
	}
	property bool Healing
	{
		public get()							{ return b_healing[this.index]; }
		public set(bool TempValueForProperty) 	{ b_healing[this.index] = TempValueForProperty; }
	}
	property bool m_bnew_target
	{
		public get()							{ return b_new_target[this.index]; }
		public set(bool TempValueForProperty) 	{ b_new_target[this.index] = TempValueForProperty; }
	}
	property float m_flReloadIn
	{
		public get()							{ return fl_ReloadIn[this.index]; }
		public set(float TempValueForProperty) 	{ fl_ReloadIn[this.index] = TempValueForProperty; }
	}
	property float m_flAngerDelay
	{
		public get()							{ return fl_AngerDelay[this.index]; }
		public set(float TempValueForProperty) 	{ fl_AngerDelay[this.index] = TempValueForProperty; }
	}
	property float m_flmovedelay
	{
		public get()							{ return fl_movedelay[this.index]; }
		public set(float TempValueForProperty) 	{ fl_movedelay[this.index] = TempValueForProperty; }
	}
	property float m_flNextChargeSpecialAttack
	{
		public get()							{ return fl_NextChargeSpecialAttack[this.index]; }
		public set(float TempValueForProperty) 	{ fl_NextChargeSpecialAttack[this.index] = TempValueForProperty; }
	}
	property float m_flNextRangedSpecialAttack
	{
		public get()							{ return fl_NextRangedSpecialAttack[this.index]; }
		public set(float TempValueForProperty) 	{ fl_NextRangedSpecialAttack[this.index] = TempValueForProperty; }
	}
	
	property float m_flNextRangedSpecialAttackHappens
	{
		public get()							{ return fl_NextRangedSpecialAttackHappens[this.index]; }
		public set(float TempValueForProperty) 	{ fl_NextRangedSpecialAttackHappens[this.index] = TempValueForProperty; }
	}
	property float m_flRangedSpecialDelay
	{
		public get()							{ return fl_RangedSpecialDelay[this.index]; }
		public set(float TempValueForProperty) 	{ fl_RangedSpecialDelay[this.index] = TempValueForProperty; }
	}
	property bool m_fbRangedSpecialOn
	{
		public get()							{ return b_RangedSpecialOn[this.index]; }
		public set(bool TempValueForProperty) 	{ b_RangedSpecialOn[this.index] = TempValueForProperty; }
	}
	property float m_flNextIdleSound
	{
		public get()							{ return fl_NextIdleSound[this.index]; }
		public set(float TempValueForProperty) 	{ fl_NextIdleSound[this.index] = TempValueForProperty; }
	}
	property float m_flInJump
	{
		public get()							{ return fl_InJump[this.index]; }
		public set(float TempValueForProperty) 	{ fl_InJump[this.index] = TempValueForProperty; }
	}
	property bool m_bDissapearOnDeath
	{
		public get()							{ return b_DissapearOnDeath[this.index]; }
		public set(bool TempValueForProperty) 	{ b_DissapearOnDeath[this.index] = TempValueForProperty; }
	}

	property bool m_bIsGiant
	{
		public get()							{ return b_IsGiant[this.index]; }
		public set(bool TempValueForProperty) 	{ b_IsGiant[this.index] = TempValueForProperty; }
	}
	property bool Anger
	{
		public get()							{ return b_Anger[this.index]; }
		public set(bool TempValueForProperty) 	{ b_Anger[this.index] = TempValueForProperty; }
	}
	property bool m_bPathing
	{
		public get()							{ return b_Pathing[this.index]; }
		public set(bool TempValueForProperty) 	{ b_Pathing[this.index] = TempValueForProperty; }
	}

	property bool m_bThisEntityIgnored
	{
		public get()							{ return b_ThisEntityIgnored[this.index]; }
		public set(bool TempValueForProperty) 	{ b_ThisEntityIgnored[this.index] = TempValueForProperty; }
	}
	
	property bool m_bJumping
	{
		public get()							{ return b_Pathing[this.index]; }
		public set(bool TempValueForProperty) 	{ b_Pathing[this.index] = TempValueForProperty; }
	}
	property float m_flDoingAnimation
	{
		public get()							{ return fl_DoingAnimation[this.index]; }
		public set(float TempValueForProperty) 	{ fl_DoingAnimation[this.index] = TempValueForProperty; }
	}
	property float m_flNextRangedBarrage_Spam
	{
		public get()							{ return fl_NextRangedBarrage_Spam[this.index]; }
		public set(float TempValueForProperty) 	{ fl_NextRangedBarrage_Spam[this.index] = TempValueForProperty; }
	}
	property float m_flNextRangedBarrage_Singular
	{
		public get()							{ return fl_NextRangedBarrage_Singular[this.index]; }
		public set(float TempValueForProperty) 	{ fl_NextRangedBarrage_Singular[this.index] = TempValueForProperty; }
	}
	property bool m_bNextRangedBarrage_OnGoing
	{
		public get()							{ return b_NextRangedBarrage_OnGoing[this.index]; }
		public set(bool TempValueForProperty) 	{ b_NextRangedBarrage_OnGoing[this.index] = TempValueForProperty; }
	}

	property float m_flJumpStartTimeInternal
	{
		public get()							{ return fl_JumpStartTimeInternal[this.index]; }
		public set(float TempValueForProperty) 	{ fl_JumpStartTimeInternal[this.index] = TempValueForProperty; }
	}

	property float m_flJumpStartTime
	{
		public get()							{ return fl_JumpStartTime[this.index]; }
		public set(float TempValueForProperty) 	{ fl_JumpStartTime[this.index] = TempValueForProperty; }
	}
	property float m_flNextTeleport
	{
		public get()							{ return fl_NextTeleport[this.index]; }
		public set(float TempValueForProperty) 	{ fl_NextTeleport[this.index] = TempValueForProperty; }
	}
	property float m_flJumpCooldown
	{
		public get()							{ return fl_JumpCooldown[this.index]; }
		public set(float TempValueForProperty) 	{ fl_JumpCooldown[this.index] = TempValueForProperty; }
	}
	
	property float m_flNextThinkTime
	{
		public get()							{ return fl_NextThinkTime[this.index]; }
		public set(float TempValueForProperty) 	{ fl_NextThinkTime[this.index] = TempValueForProperty; }
	}
	property float m_flNextRunTime
	{
		public get()							{ return fl_NextRunTime[this.index]; }
		public set(float TempValueForProperty) 	{ fl_NextRunTime[this.index] = TempValueForProperty; }
	}
	property float m_flNextDelayTime
	{
		public get()							{ return fl_NextDelayTime[this.index]; }
		public set(float TempValueForProperty) 	{ fl_NextDelayTime[this.index] = TempValueForProperty; }
	}

	property float m_flNextMeleeAttack
	{
		public get()							{ return fl_NextMeleeAttack[this.index]; }
		public set(float TempValueForProperty) 	{ fl_NextMeleeAttack[this.index] = TempValueForProperty; }
	}
	property float m_flAttackHappens
	{
		public get()							{ return fl_AttackHappensMinimum[this.index]; }
		public set(float TempValueForProperty) 	{ fl_AttackHappensMinimum[this.index] = TempValueForProperty; }
	}
	property float m_flAttackHappens_bullshit
	{
		public get()							{ return fl_AttackHappensMaximum[this.index]; }
		public set(float TempValueForProperty) 	{ fl_AttackHappensMaximum[this.index] = TempValueForProperty; }
	}
	property bool m_flAttackHappenswillhappen
	{
		public get()							{ return b_AttackHappenswillhappen[this.index]; }
		public set(bool TempValueForProperty) 	{ b_AttackHappenswillhappen[this.index] = TempValueForProperty; }
	}
	
	
	property float m_flMeleeArmor
	{
		public get()							{ return fl_MeleeArmor[this.index]; }
		public set(float TempValueForProperty) 	{ fl_MeleeArmor[this.index] = TempValueForProperty; }
	}
	property float m_flRangedArmor
	{
		public get()				{ return fl_RangedArmor[this.index]; }
		public set(float TempValueForProperty) 	{ fl_RangedArmor[this.index] = TempValueForProperty; }
	}
	property bool m_bScalesWithWaves
	{
		public get()							{ return b_ScalesWithWaves[this.index]; }
		public set(bool TempValueForProperty) 	{ b_ScalesWithWaves[this.index] = TempValueForProperty; }	
	
	}
	property float m_flSpeed
	{
		public get()							{ return fl_Speed[this.index]; }
		public set(float TempValueForProperty) 	{ fl_Speed[this.index] = TempValueForProperty; }
	}
	property int m_iTarget
	{
		public get()							{ return i_Target[this.index]; }
		public set(int TempValueForProperty) 	{ i_Target[this.index] = TempValueForProperty; }
	}
	property int m_iBleedType
	{
		public get()							{ return i_BleedType[this.index]; }
		public set(int TempValueForProperty) 	{ i_BleedType[this.index] = TempValueForProperty; }
	}
	property int m_iState
	{
		public get()							{ return i_State[this.index]; }
		public set(int TempValueForProperty) 	{ i_State[this.index] = TempValueForProperty; }
	}
	property bool m_bmovedelay
	{
		public get()							{ return b_movedelay[this.index]; }
		public set(bool TempValueForProperty) 	{ b_movedelay[this.index] = TempValueForProperty; }
	}
	property int m_iStepNoiseType
	{
		public get()							{ return i_StepNoiseType[this.index]; }
		public set(int TempValueForProperty) 	{ i_StepNoiseType[this.index] = TempValueForProperty; }
	}
	property int m_iNpcStepVariation
	{
		public get()							{ return i_NpcStepVariation[this.index]; }
		public set(int TempValueForProperty) 	{ i_NpcStepVariation[this.index] = TempValueForProperty; }
	}
	property float m_fCreditsOnKill
	{
		public get()							{ return f_CreditsOnKill[this.index]; }
		public set(float TempValueForProperty) 	{ f_CreditsOnKill[this.index] = TempValueForProperty; }
	}
	property float m_flGetClosestTargetTime
	{
		public get()							{ return fl_GetClosestTargetTime[this.index]; }
		public set(float TempValueForProperty) 	{ fl_GetClosestTargetTime[this.index] = TempValueForProperty; }
	}
	property float m_flGetClosestTargetNoResetTime
	{
		public get()							{ return fl_GetClosestTargetNoResetTime[this.index]; }
		public set(float TempValueForProperty) 	{ fl_GetClosestTargetNoResetTime[this.index] = TempValueForProperty; }
	}
	property float m_flNextRangedAttack
	{
		public get()							{ return fl_NextRangedAttack[this.index]; }
		public set(float TempValueForProperty) 	{ fl_NextRangedAttack[this.index] = TempValueForProperty; }
	}
	property float m_flNextRangedAttackHappening
	{
		public get()							{ return fl_NextRangedAttackHappening[this.index]; }
		public set(float TempValueForProperty) 	{ fl_NextRangedAttackHappening[this.index] = TempValueForProperty; }
	}
	property int m_iAttacksTillReload
	{
		public get()							{ return i_AttacksTillReload[this.index]; }
		public set(int TempValueForProperty) 	{ i_AttacksTillReload[this.index] = TempValueForProperty; }
	}
	property float m_flNextHurtSound
	{
		public get()							{ return fl_NextHurtSound[this.index]; }
		public set(float TempValueForProperty) 	{ fl_NextHurtSound[this.index] = TempValueForProperty; }
	}
	property float m_flHeadshotCooldown
	{
		public get()							{ return fl_HeadshotCooldown[this.index]; }
		public set(float TempValueForProperty) 	{ fl_HeadshotCooldown[this.index] = TempValueForProperty; }
	}
	property bool m_blPlayHurtAnimation
	{
		public get()							{ return b_PlayHurtAnimation[this.index]; }
		public set(bool TempValueForProperty) 	{ b_PlayHurtAnimation[this.index] = TempValueForProperty; }
	}
	property bool m_fbGunout
	{
		public get()							{ return b_Gunout[this.index]; }
		public set(bool TempValueForProperty) 	{ b_Gunout[this.index] = TempValueForProperty; }
	}
	property bool bCantCollidie
	{
		public get()							{ return b_CantCollidie[this.index]; }
		public set(bool TempValueForProperty) 	{ b_CantCollidie[this.index] = TempValueForProperty; }
	}
	property bool bCantCollidieAlly
	{
		public get()							{ return b_CantCollidieAlly[this.index]; }
		public set(bool TempValueForProperty) 	{ b_CantCollidieAlly[this.index] = TempValueForProperty; }
	}
	property bool bBuildingIsStacked
	{
		public get()							{ return b_BuildingIsStacked[this.index]; }
		public set(bool TempValueForProperty) 	{ b_BuildingIsStacked[this.index] = TempValueForProperty; }
	}
	property bool bBuildingIsPlaced
	{
		public get()							{ return b_bBuildingIsPlaced[this.index]; }
		public set(bool TempValueForProperty) 	{ b_bBuildingIsPlaced[this.index] = TempValueForProperty; }
	}
	property bool bXenoInfectedSpecialHurt
	{
		public get()							{ return b_XenoInfectedSpecialHurt[this.index]; }
		public set(bool TempValueForProperty) 	{ b_XenoInfectedSpecialHurt[this.index] = TempValueForProperty; }
	}
	property float flXenoInfectedSpecialHurtTime
	{
		public get()							{ return fl_XenoInfectedSpecialHurtTime[this.index]; }
		public set(float TempValueForProperty) 	{ fl_XenoInfectedSpecialHurtTime[this.index] = TempValueForProperty; }
	}
	property bool m_bThisNpcIsABoss
	{
		public get()							{ return b_thisNpcIsABoss[this.index]; }
		public set(bool TempValueForProperty) 	{ b_thisNpcIsABoss[this.index] = TempValueForProperty; }
	}
	property bool m_bStaticNPC
	{
		public get()							{ return b_StaticNPC[this.index]; }
		public set(bool TempValueForProperty) 	{ b_StaticNPC[this.index] = TempValueForProperty; }
	}
	
	property bool m_bThisNpcGotDefaultStats_INVERTED //This is the only one, reasoning is that is that i kinda need to check globablly if any base_boss spawned outside of this plugin and apply stuff accordingly.
	{
		public get()							{ return b_ThisWasAnNpc[this.index]; }
		public set(bool TempValueForProperty) 	{ b_ThisWasAnNpc[this.index] = TempValueForProperty; }
	}
	property bool m_bInSafeZone
	{
		public get()							{ return view_as<bool>(i_InSafeZone[this.index]); }
	}
	property float m_fHighTeslarDebuff 
	{
		public get()							{ return f_HighTeslarDebuff[this.index]; }
		public set(float TempValueForProperty) 	{ f_HighTeslarDebuff[this.index] = TempValueForProperty; }
	}
	property float m_fLowTeslarDebuff 
	{
		public get()							{ return f_LowTeslarDebuff[this.index]; }
		public set(float TempValueForProperty) 	{ f_LowTeslarDebuff[this.index] = TempValueForProperty; }
	}
	
	property float mf_WidowsWineDebuff 
	{
		public get()							{ return f_WidowsWineDebuff[this.index]; }
		public set(float TempValueForProperty) 	{ f_WidowsWineDebuff[this.index] = TempValueForProperty; }
	}
	
	property bool m_bFrozen
	{
		public get()				{ return b_Frozen[this.index]; }
		public set(bool TempValueForProperty) 	{ b_Frozen[this.index] = TempValueForProperty; }
	}
	
	property bool m_bAllowBackWalking
	{
		public get()				{ return b_AllowBackWalking[this.index]; }
		public set(bool TempValueForProperty) 	{ b_AllowBackWalking[this.index] = TempValueForProperty; }
	}
	public float GetDebuffPercentage()//For the future incase we want to alter it easier
	{
		float speed_for_return = 1.0;
		float Gametime = GetGameTime();
		float GametimeNpc = GetGameTime(this.index);
		speed_for_return *= fl_Extra_Speed[this.index];
		
		bool Is_Boss = true;
#if defined ZR
		if(IS_MusicReleasingRadio() && !b_IsAlliedNpc[this.index])
			speed_for_return *= 0.9;
#endif
		if(i_CurrentEquippedPerk[this.index] == 4)
		{
			speed_for_return *= 1.25;
		}
		if(b_npcspawnprotection[this.index])
		{
			speed_for_return *= 1.35;
		}
		if(!this.m_bThisNpcIsABoss)
		{
			
#if defined ZR
			if(EntRefToEntIndex(RaidBossActive) != this.index)
#endif
			
			{
				Is_Boss = false;
			}
		}
		
		if(f_TankGrabbedStandStill[this.index] > Gametime)
		{
			speed_for_return = 0.0;
			return speed_for_return;
		}
		if(f_TimeFrozenStill[this.index] > GametimeNpc)
		{
			speed_for_return = 0.0;
			return speed_for_return;
		}
		if (this.m_bFrozen && !b_CannotBeSlowed[this.index])
		{
			speed_for_return = 0.0;
			return speed_for_return;
		}	
		if(b_PernellBuff[this.index])
		{
			speed_for_return *= 1.15;
		}
		if(f_HussarBuff[this.index] > Gametime)
		{
			speed_for_return *= 1.20;
		}
		if(f_GodArkantosBuff[this.index] > Gametime)
		{
			speed_for_return *= 1.50;
		}
		if(b_NpcResizedForCrouch[this.index])
		{
			speed_for_return *= 0.33333;
		}
		if(f_Ruina_Speed_Buff[this.index]> Gametime)
		{
			speed_for_return *= f_Ruina_Speed_Buff_Amt[this.index];
		}

#if defined ZR
		SeabornVanguard_SpeedBuff(this, speed_for_return);	
#endif

		if(!Is_Boss && !b_CannotBeSlowed[this.index]) //Make sure that any slow debuffs dont affect these.
		{
			if(f_MaimDebuff[this.index] > Gametime)
			{
				speed_for_return *= 0.35;
			}
			if(f_PotionShrinkEffect[this.index] > Gametime)
			{
				speed_for_return *= 0.35;
			}
			if(f_PassangerDebuff[this.index] > Gametime)
			{
				speed_for_return *= 0.20;
			}
			
			if(this.m_fHighTeslarDebuff > Gametime)
			{
				speed_for_return *= 0.65;
			}
			else if(this.m_fLowTeslarDebuff > Gametime)
			{
				speed_for_return *= 0.75;
			}

			if(f_SpecterDyingDebuff[this.index] > Gametime)
			{
				speed_for_return *= 0.4;
			}
			
			if(f_HighIceDebuff[this.index] > Gametime)
			{
				speed_for_return *= 0.85;
			}
			else if(f_LowIceDebuff[this.index] > Gametime)
			{
				speed_for_return *= 0.90;
			}
			else if (f_VeryLowIceDebuff[this.index] > Gametime)
			{
				speed_for_return *= 0.95;
			}
		}
		else if (!b_CannotBeSlowed[this.index])
		{
			if(this.m_fHighTeslarDebuff > Gametime)
			{
				speed_for_return *= 0.9;
			}
			else if(this.m_fLowTeslarDebuff > Gametime)
			{
				speed_for_return *= 0.95;
			}
			if(f_PassangerDebuff[this.index] > Gametime)
			{
				speed_for_return *= 0.9;
			}
			if(f_MaimDebuff[this.index] > Gametime)
			{
				speed_for_return *= 0.9;
			}
			if(f_PotionShrinkEffect[this.index] > Gametime)
			{
				speed_for_return *= 0.9;
			}
			
			if(f_HighIceDebuff[this.index] > Gametime)
			{
				speed_for_return *= 0.95;
			}
			else if(f_LowIceDebuff[this.index] > Gametime)
			{
				speed_for_return *= 0.96;
			}
			else if (f_VeryLowIceDebuff[this.index] > Gametime)
			{
				speed_for_return *= 0.97;
			}
			if(f_SpecterDyingDebuff[this.index] > Gametime)
			{
				speed_for_return *= 0.75;
			}
		}
		if(this.mf_WidowsWineDebuff > Gametime && !b_CannotBeSlowed[this.index])
		{
			float slowdown_amount = this.mf_WidowsWineDebuff - Gametime;
			
			float max_amount = FL_WIDOWS_WINE_DURATION;
			
			slowdown_amount = slowdown_amount / max_amount;
			
			slowdown_amount -= 1.0;
			
			slowdown_amount *= -1.0;
			
			if(!Is_Boss)
			{
				if(slowdown_amount < 0.1)
				{
					slowdown_amount = 0.1;
				}
				else if(slowdown_amount > 1.0)
				{
					slowdown_amount = 1.0;
				}	
			}
			else
			{
				if(slowdown_amount < 0.8)
				{
					slowdown_amount = 0.8;
				}
				else if(slowdown_amount > 1.0)
				{
					slowdown_amount = 1.0;
				}	
			}
			speed_for_return *= slowdown_amount;
		}
#if defined RPG
		if (b_DungeonContracts_ZombieSpeedTimes3[this.index])
		{
			speed_for_return *= 3.0;
		}	
#endif				

		return speed_for_return;
	}
	public float GetRunSpeed()//For the future incase we want to alter it easier
	{
		float speed_for_return;
		
		speed_for_return = this.m_flSpeed;
		
		speed_for_return *= this.GetDebuffPercentage();

#if defined ZR
		if(!b_IsAlliedNpc[this.index])
		{
			speed_for_return *= Zombie_DelayExtraSpeed();
		}
		if(b_IsAlliedNpc[this.index])
		{
			if(VIPBuilding_Active())
				speed_for_return *= 2.0;
		}
#endif
		return speed_for_return; 
	}
	public void m_vecLastValidPos(float pos[3], bool set)
	{
		if(set)
		{
			f3_VecTeleportBackSave[this.index][0] = pos[0];
			f3_VecTeleportBackSave[this.index][1] = pos[1];
			f3_VecTeleportBackSave[this.index][2] = pos[2];
		}
		else
		{
			pos[0] = f3_VecTeleportBackSave[this.index][0];
			pos[1] = f3_VecTeleportBackSave[this.index][1];
			pos[2] = f3_VecTeleportBackSave[this.index][2];
		}
	}
	
	public void m_vecLastValidPosJump(float pos[3], bool set)
	{
		if(set)
		{
			f3_VecTeleportBackSaveJump[this.index][0] = pos[0];
			f3_VecTeleportBackSaveJump[this.index][1] = pos[1];
			f3_VecTeleportBackSaveJump[this.index][2] = pos[2];
		}
		else
		{
			pos[0] = f3_VecTeleportBackSaveJump[this.index][0];
			pos[1] = f3_VecTeleportBackSaveJump[this.index][1];
			pos[2] = f3_VecTeleportBackSaveJump[this.index][2];
		}
	}
	public void m_vecpunchforce(float pos[3], bool set)
	{
		if(set)
		{
			f3_VecPunchForce[this.index][0] = pos[0];
			f3_VecPunchForce[this.index][1] = pos[1];
			f3_VecPunchForce[this.index][2] = pos[2];
		}
		else
		{
			pos[0] = f3_VecPunchForce[this.index][0];
			pos[1] = f3_VecPunchForce[this.index][1];
			pos[2] = f3_VecPunchForce[this.index][2];
		}
	}
	property bool m_bGib
	{
		public get()							{ return b_DoGibThisNpc[this.index]; }
		public set(bool TempValueForProperty) 	{ b_DoGibThisNpc[this.index] = TempValueForProperty; }
	}
	property bool g_bNPCVelocityCancel
	{
		public get()							{ return b_NPCVelocityCancel[this.index]; }
		public set(bool TempValueForProperty) 	{ b_NPCVelocityCancel[this.index] = TempValueForProperty; }
	}
	property bool g_bNPCTeleportOutOfStuck
	{
		public get()							{ return b_NPCTeleportOutOfStuck[this.index]; }
		public set(bool TempValueForProperty) 	{ b_NPCTeleportOutOfStuck[this.index] = TempValueForProperty; }
	}
	property float m_flDoSpawnGesture
	{
		public get()							{ return fl_DoSpawnGesture[this.index]; }
		public set(float TempValueForProperty) 	{ fl_DoSpawnGesture[this.index] = TempValueForProperty; }
	}
	property float m_flReloadDelay
	{
		public get()							{ return fl_ReloadDelay[this.index]; }
		public set(float TempValueForProperty) 	{ fl_ReloadDelay[this.index] = TempValueForProperty; }
	}
	property bool m_bisWalking
	{
		public get()							{ return b_isWalking[this.index]; }
		public set(bool TempValueForProperty) 	{ b_isWalking[this.index] = TempValueForProperty; }
	}
	property bool m_bDoNotGiveWaveDelay
	{
		public get()							{ return b_DoNotGiveWaveDelay[this.index]; }
		public set(bool TempValueForProperty) 	{ b_DoNotGiveWaveDelay[this.index] = TempValueForProperty; }
	}
	property float m_bisGiantWalkCycle
	{
		public get()							{ return b_isGiantWalkCycle[this.index]; }
		public set(float TempValueForProperty) 	{ b_isGiantWalkCycle[this.index] = TempValueForProperty; }
	}
	
	property int m_iSpawnProtectionEntity
	{
		public get()		 
		{ 
			return EntRefToEntIndex(i_SpawnProtectionEntity[this.index]); 
		}
		public set(int iInt) 
		{
			if(iInt == -1)
			{
				i_SpawnProtectionEntity[this.index] = INVALID_ENT_REFERENCE;
			}
			else
			{
				i_SpawnProtectionEntity[this.index] = EntIndexToEntRef(iInt);
			}
		}
	}
#if defined ZR
	property int m_iTeamGlow
	{
		public get()		 
		{ 
			return EntRefToEntIndex(i_TeamGlow[this.index]); 
		}
		public set(int iInt) 
		{
			if(iInt == -1)
			{
				i_TeamGlow[this.index] = INVALID_ENT_REFERENCE;
			}
			else
			{
				i_TeamGlow[this.index] = EntIndexToEntRef(iInt);
			}
		}
	}
	property bool m_bTeamGlowDefault
	{
		public get()							{ return b_TeamGlowDefault[this.index]; }
		public set(bool TempValueForProperty) 	{ b_TeamGlowDefault[this.index] = TempValueForProperty; }
	}
#endif
	property int m_iTextEntity1
	{
		public get()		 
		{
			return EntRefToEntIndex(i_TextEntity[this.index][0]); 
		}
		public set(int iInt) 
		{
			if(iInt == -1)
			{
				i_TextEntity[this.index][0] = INVALID_ENT_REFERENCE;
			}
			else
			{
				i_TextEntity[this.index][0] = EntIndexToEntRef(iInt);
			}
		}
	}
	property int m_iTextEntity2
	{
		public get()		 
		{ 
			return EntRefToEntIndex(i_TextEntity[this.index][1]); 
		}
		public set(int iInt) 
		{
			if(iInt == -1)
			{
				i_TextEntity[this.index][1] = INVALID_ENT_REFERENCE;
			}
			else
			{
				i_TextEntity[this.index][1] = EntIndexToEntRef(iInt);
			}
		}
	}
	property int m_iTextEntity3
	{
		public get()		 
		{ 
			return EntRefToEntIndex(i_TextEntity[this.index][2]); 
		}
		public set(int iInt) 
		{
			if(iInt == -1)
			{
				i_TextEntity[this.index][2] = INVALID_ENT_REFERENCE;
			}
			else
			{
				i_TextEntity[this.index][2] = EntIndexToEntRef(iInt);
			}
		}
	}
	property int m_iTextEntity4
	{
		public get()		 
		{ 
			return EntRefToEntIndex(i_TextEntity[this.index][3]); 
		}
		public set(int iInt) 
		{
			if(iInt == -1)
			{
				i_TextEntity[this.index][3] = INVALID_ENT_REFERENCE;
			}
			else
			{
				i_TextEntity[this.index][3] = EntIndexToEntRef(iInt);
			}
		}
	}
	property int m_iWearable1
	{
		public get()		 
		{ 
			return EntRefToEntIndex(i_Wearable[this.index][0]); 
		}
		public set(int iInt) 
		{
			if(iInt == -1)
			{
				i_Wearable[this.index][0] = INVALID_ENT_REFERENCE;
			}
			else
			{
				i_Wearable[this.index][0] = EntIndexToEntRef(iInt);
			}
		}
	}
	property int m_iWearable2
	{
		public get()		 
		{ 
			return EntRefToEntIndex(i_Wearable[this.index][1]); 
		}
		public set(int iInt) 
		{
			if(iInt == -1)
			{
				i_Wearable[this.index][1] = INVALID_ENT_REFERENCE;
			}
			else
			{
				i_Wearable[this.index][1] = EntIndexToEntRef(iInt);
			}
		}
	}
	property int m_iWearable3
	{
		public get()		 
		{ 
			return EntRefToEntIndex(i_Wearable[this.index][2]); 
		}
		public set(int iInt) 
		{
			if(iInt == -1)
			{
				i_Wearable[this.index][2] = INVALID_ENT_REFERENCE;
			}
			else
			{
				i_Wearable[this.index][2] = EntIndexToEntRef(iInt);
			}
		}
	}
	property int m_iWearable4
	{
		public get()		 
		{ 
			return EntRefToEntIndex(i_Wearable[this.index][3]); 
		}
		public set(int iInt) 
		{
			if(iInt == -1)
			{
				i_Wearable[this.index][3] = INVALID_ENT_REFERENCE;
			}
			else
			{
				i_Wearable[this.index][3] = EntIndexToEntRef(iInt);
			}
		}
	}
	property int m_iWearable5
	{
		public get()		 
		{ 
			return EntRefToEntIndex(i_Wearable[this.index][4]); 
		}
		public set(int iInt) 
		{
			if(iInt == -1)
			{
				i_Wearable[this.index][4] = INVALID_ENT_REFERENCE;
			}
			else
			{
				i_Wearable[this.index][4] = EntIndexToEntRef(iInt);
			}
		}
	}
	property int m_iWearable6
	{
		public get()		 
		{ 
			return EntRefToEntIndex(i_Wearable[this.index][5]); 
		}
		public set(int iInt) 
		{
			if(iInt == -1)
			{
				i_Wearable[this.index][5] = INVALID_ENT_REFERENCE;
			}
			else
			{
				i_Wearable[this.index][5] = EntIndexToEntRef(iInt);
			}
		}
	}
	property int m_iWearable7
	{
		public get()		 
		{ 
			return EntRefToEntIndex(i_Wearable[this.index][6]); 
		}
		public set(int iInt) 
		{
			if(iInt == -1)
			{
				i_Wearable[this.index][6] = INVALID_ENT_REFERENCE;
			}
			else
			{
				i_Wearable[this.index][6] = EntIndexToEntRef(iInt);
			}
		}
	}
	property int m_iFreezeWearable
	{
		public get()		 
		{ 
			return EntRefToEntIndex(i_FreezeWearable[this.index]); 
		}
		public set(int iInt) 
		{
			if(iInt == -1)
			{
				i_FreezeWearable[this.index] = INVALID_ENT_REFERENCE;
			}
			else
			{
				i_FreezeWearable[this.index] = EntIndexToEntRef(iInt);
			}
		}
	}
	
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
	//	this.SetSequence(iSequence);
		this.SetPlaybackRate(1.0);
		this.SetCycle(0.0);
		this.ResetSequenceInfo();
		this.m_iState = iSequence;
	//	int layer = this.FindGestureLayerBySequence(iSequence);
	//	if(layer != -1)
	//	{
	//		CAnimationLayer alayer = this.GetAnimOverlay(layer);
	//		alayer.m_flPlaybackRate = 1.0;
	//		alayer.m_flCycle = 0.0;
	//	}
	
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
	public void DispatchParticleEffect(int entity, const char[] strParticle, float flStartPos[3], float vecAngles[3], float flEndPos[3], 
									   int iAttachmentPointIndex = 0, ParticleAttachment_t iAttachType = PATTACH_CUSTOMORIGIN, bool bResetAllParticlesOnEntity = false, float colour[3] = {0.0,0.0,0.0})
	{
		int tblidx = FindStringTable("ParticleEffectNames");
		if (tblidx == INVALID_STRING_TABLE) 
		{
			LogError("Could not find string table: ParticleEffectNames");
			return;
		}
		char tmp[256];
		int count = GetStringTableNumStrings(tblidx);
		int stridx = INVALID_STRING_INDEX;
		for (int i = 0; i < count; i++)
		{
			ReadStringTable(tblidx, i, tmp, sizeof(tmp));
			if (StrEqual(tmp, strParticle, false))
			{
				stridx = i;
				break;
			}
		}
		if (stridx == INVALID_STRING_INDEX)
		{
			LogError("Could not find particle: %s", strParticle);
			return;
		}
	
		TE_Start("TFParticleEffect");
		TE_WriteFloat("m_vecOrigin[0]", flStartPos[0]);
		TE_WriteFloat("m_vecOrigin[1]", flStartPos[1]);
		TE_WriteFloat("m_vecOrigin[2]", flStartPos[2]);
		TE_WriteVector("m_vecAngles", vecAngles);
		TE_WriteNum("m_iParticleSystemIndex", stridx);
		TE_WriteNum("entindex", entity);
		TE_WriteNum("m_iAttachType", view_as<int>(iAttachType));
		TE_WriteNum("m_iAttachmentPointIndex", iAttachmentPointIndex);
		TE_WriteNum("m_bResetParticles", bResetAllParticlesOnEntity);	
		TE_WriteNum("m_bControlPoint1", 0);	
		TE_WriteNum("m_ControlPoint1.m_eParticleAttachment", 0);  
		TE_WriteFloat("m_ControlPoint1.m_vecOffset[0]", flEndPos[0]);
		TE_WriteFloat("m_ControlPoint1.m_vecOffset[1]", flEndPos[1]);
		TE_WriteFloat("m_ControlPoint1.m_vecOffset[2]", flEndPos[2]);
		TE_SendToAll();
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
		if(!CvarDisableThink.BoolValue)
		{
			this.m_bPathing = true;

			this.GetPathFollower().SetMinLookAheadDistance(100.0);
		}
	}
	public void StopPathing()
	{
		f_DelayComputingOfPath[this.index] = 0.0; //find new target instantly.
		this.GetPathFollower().Invalidate();
		this.GetLocomotion().Stop();

		this.m_bPathing = false;
	}
	public void SetGoalEntity(int target, bool ignoretime = false)
	{
		if(ignoretime || DelayPathing(this.index))
		{
			if(IsEntityTowerDefense(this.index))
			{
				if(this.m_bPathing && this.IsOnGround())
				{
					if(i_WasPathingToHere[this.index] == target)
						return;

					i_WasPathingToHere[this.index] = target;
				}
				else
				{
					i_WasPathingToHere[this.index] = 0;
				}
			}
			if(this.m_bPathing)
			{
				this.GetPathFollower().ComputeToTarget(this.GetBot(), target);
				float DistanceCheck[3];
				GetEntPropVector(target, Prop_Data, "m_vecAbsOrigin", DistanceCheck);
				AddDelayPather(this.index, DistanceCheck);
			}
		}
	}
	public void SetGoalVector(const float vec[3], bool ignoretime = false)
	{	
		if(ignoretime || DelayPathing(this.index))
		{
			if(IsEntityTowerDefense(this.index))
			{
				if(this.m_bPathing && this.IsOnGround())
				{
					if(f3_WasPathingToHere[this.index][0] == vec[0] && f3_WasPathingToHere[this.index][1] == vec[1] && f3_WasPathingToHere[this.index][2] == vec[2])
						return;

					f3_WasPathingToHere[this.index] = vec;
				}
				else
				{
					f3_WasPathingToHere[this.index][0] = 0.0;
					f3_WasPathingToHere[this.index][1] = 0.0;
					f3_WasPathingToHere[this.index][2] = 0.0;
				}
			}
			if(this.m_bPathing)
			{
				this.GetPathFollower().ComputeToPos(this.GetBot(), vec);
				AddDelayPather(this.index, vec);
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
	
	public int EquipItem(
	const char[] attachment,
	const char[] model,
	const char[] anim = "",
	int skin = 0,
	float model_size = 1.0)
	{
		int item = CreateEntityByName("prop_dynamic_override");
		DispatchKeyValue(item, "model", model);

		if(model_size == 1.0)
		{
			DispatchKeyValueFloat(item, "modelscale", GetEntPropFloat(this.index, Prop_Send, "m_flModelScale"));
		}
		else
		{
			DispatchKeyValueFloat(item, "modelscale", model_size);
		}

		DispatchSpawn(item);
		
		SetEntProp(item, Prop_Send, "m_fEffects", EF_BONEMERGE|EF_PARENT_ANIMATES);
		SetEntityMoveType(item, MOVETYPE_NONE);
		SetEntProp(item, Prop_Data, "m_nNextThinkTick", -1.0);
	
		if(anim[0])
		{
			SetVariantString(anim);
			AcceptEntityInput(item, "SetAnimation");
		}

#if defined RPG
		SetEntPropFloat(item, Prop_Send, "m_fadeMinDist", 1600.0);
		SetEntPropFloat(item, Prop_Send, "m_fadeMaxDist", 1800.0);
#endif

		SetVariantString("!activator");
		AcceptEntityInput(item, "SetParent", this.index);

		if(attachment[0])
		{
			SetVariantString(attachment);
			AcceptEntityInput(item, "SetParentAttachmentMaintainOffset"); 
		}	
		
		SetEntityCollisionGroup(item, 1);
		SetEntProp(item, Prop_Send, "m_usSolidFlags", 12); 
		SetEntProp(item, Prop_Data, "m_nSolidType", 6); 

		return item;
	}

	public int EquipItemSeperate(
	const char[] attachment,
	const char[] model,
	const char[] anim = "",
	int skin = 0,
	float model_size = 1.0,
	float offset = 0.0,
	bool DontParent = false)
	{
		int item = CreateEntityByName("prop_dynamic");
		DispatchKeyValue(item, "model", model);

		if(model_size == 1.0)
		{
			DispatchKeyValueFloat(item, "modelscale", GetEntPropFloat(this.index, Prop_Send, "m_flModelScale"));
		}
		else
		{
			DispatchKeyValueFloat(item, "modelscale", model_size);
		}

		DispatchSpawn(item);
		
		SetEntityMoveType(item, MOVETYPE_NONE);
		SetEntProp(item, Prop_Data, "m_nNextThinkTick", -1.0);
		float eyePitch[3];
		GetEntPropVector(this.index, Prop_Data, "m_angRotation", eyePitch);

		float VecOrigin[3];
		VecOrigin = GetAbsOrigin(this.index);
		VecOrigin[2] += offset;

		TeleportEntity(item, VecOrigin, eyePitch, NULL_VECTOR);
		if(DontParent)
		{
			return item;
		}
		

		if(!StrEqual(anim, ""))
		{
			SetVariantString(anim);
			AcceptEntityInput(item, "SetAnimation");
		}

#if defined RPG
		SetEntPropFloat(item, Prop_Send, "m_fadeMinDist", 1600.0);
		SetEntPropFloat(item, Prop_Send, "m_fadeMaxDist", 1800.0);
#endif

		SetVariantString("!activator");
		AcceptEntityInput(item, "SetParent", this.index);
		SetEntityCollisionGroup(item, 1);
		SetEntProp(item, Prop_Send, "m_usSolidFlags", 12); 
		SetEntProp(item, Prop_Data, "m_nSolidType", 6); 
		return item;
	} 
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
		
#if defined ZR
		bool ingore_buildings = false;
		if(Ignore_Buildings || (!VIPBuilding_Active() && IsValidEntity(EntRefToEntIndex(RaidBossActive))))
		{
			ingore_buildings = true;
		}
#else
		bool ingore_buildings = view_as<bool>(Ignore_Buildings);
#endif
		// See if we hit anything.
		if(countAoe > 0)
		{
			Zero(i_EntitiesHitAoeSwing_NpcSwing);
			i_EntitiesHitAtOnceMax_NpcSwing = countAoe; //How many do we stack
			
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