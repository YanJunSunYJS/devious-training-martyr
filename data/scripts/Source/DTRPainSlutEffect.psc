Scriptname DTRPainSlutEffect extends activemagiceffect  

DTRActor   Property DTActor   Auto
DTRConfig  Property DTConfig  Auto
DTRStorage Property DTStorage Auto
DTRTools   Property DTTools   Auto
DTRSound   Property DTSound   Auto

String File

Int SpankCount

Actor Property acActor Auto
Int Property Slot Auto
Bool Property EffectIsRunning Auto
Int Property OrgasmCount Auto
Zadlibs property libs auto
SexLabFramework Property SexLab Auto
slaUtilScr Property Aroused Auto

sslThreadController property sexLabThreadCtr Auto
sslThreadModel property sexLabThread Auto
sslActorAlias Property actorAlias Auto

Int Property OrgasmCountDown Auto

Int Property stageCounter Auto

Int SLSOSpeed1

Faction Property SexLabAnimatingFaction Auto

bool Property zazAnimFilter Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

	if DTConfig.modEnabled == false
		Debug.messagebox("Devious Training is disabled, please enable to use this spell.")
		self.Dispel()
		return
	endif


	SpankCount = 0
	stageCounter  = 3 + self.GetMagnitude() as int 			;set up max animation cycles (for 1 it happens 2 time)
	OrgasmCountDown = -2								;to navigate "stage" and distance to orgasm
	OrgasmCount = 0										;orgasm counter

	;std init
	Slot = DTActor.isRegistered(akTarget)	

	if DTActor.npcs_ref[Slot].WornHasKeyword(libs.zad_DeviousArmbinder) || DTActor.npcs_ref[Slot].WornHasKeyword(libs.zad_DeviousYoke)
		debug.notification("You need free hands!")
		self.Dispel()
		return
	endif

	File = "/SLSO/Config.json"
	SLSOSpeed1=JsonUtil.GetIntValue(File, "game_animation_speed_control")
	JsonUtil.SetIntValue(File, "game_animation_speed_control",0)

	;save variable and turn off dd animatio filters
	zazAnimFilter = libs.config.useAnimFilter
	libs.config.useAnimFilter = false

	DTActor.npcs_painSlut[Slot] = 2
	EffectIsRunning = true
	acActor = akTarget
	sexLabThread = SexLab.NewThread()
	sslBaseAnimation[] Sanims
	Sanims = New sslBaseAnimation[1]

	;select correct animation related with devices
	if DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousArmbinder)
		Sanims[0] = SexLab.GetAnimationObject("DDArmbinderSolo")
	elseif DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousYoke)
		Sanims[0] = SexLab.GetAnimationObject("DDYokeSolo")
	else
		Sanims[0] = SexLab.GetAnimationObject("DDBeltedSolo")
	endif
	Sanims[0] = SexLab.GetAnimationObject("DDBeltedSolo")

	;setup sexlab
	sexLabThread.AddActor(acActor ) ;adds the player﻿ into the animation
	sexLabThread.SetAnimations(Sanims)
	String hook = "DTR" ; "This is the name of the Hook"
	sexLabThread.SetHook(hook)

	RegisterForModEvent("StageStart_" + hook, "SexLabStageCh")
	
	;RegisterForModEvent("PositionChange_" + hook, "SexLabStageCh")
	RegisterForModEvent("HookAnimationStart_" + hook, "OnAnimationStart")
	RegisterForModEvent("HookAnimationEnd_" + hook, "OnAnimationEnd")
	sexLabThreadCtr = sexLabThread.StartThread()
	actorAlias = sexLabThread.ActorAlias(acActor )
EndEvent



function stopEffect()
	;set back org settings
	JsonUtil.SetIntValue(File, "game_animation_speed_control",SLSOSpeed1)
	libs.config.useAnimFilter = zazAnimFilter
	String hook = "DTR" ; "This is the name of the Hook"
	UnRegisterForModEvent("StageStart_" + hook)
	UnRegisterForModEvent("PositionChange_" + hook)
	UnRegisterForModEvent("HookAnimationStart_" + hook)
	UnRegisterForModEvent("HookAnimationEnd_" + hook)
	EffectIsRunning = false
	DTActor.npcs_painSlut[Slot] = 1
	self.dispel()
endFunction

Event onUpdate()
	Debug.SendAnimationEvent(acActor, "DDZazHornyB")
	if acActor.getFactionRank(SexLabAnimatingFaction)<0 || EffectIsRunning==false || stageCounter <= SpankCount
		stopEffect()
		self.dispel()
		return
	endif
	sexLabThreadCtr.goToStage(1)
	Debug.SendAnimationEvent(acActor, "DDZazHornyB")
	;sexLabThreadCtr.goToStage(1)
	
	
	
	if (EffectIsRunning==true)
		RegisterForSingleUpdate(16)
	endif
EndEvent

Event OnAnimationStart(int threadID, bool HasPlayer) 
	RegisterForSingleUpdate(1)
EndEvent

Event OnAnimationEnd(int threadID, bool HasPlayer) 
	stopEffect()
EndEvent

Event SexLabStageCh(string hookName, string argString, float argNum, form sender)
	if stageCounter < 1 || EffectIsRunning == false
	;	return
	endif
	Debug.SendAnimationEvent(acActor, "DDZazHornyA")
	Utility.wait(1)
	if SpankCount < 1
		Debug.SendAnimationEvent(acActor, "DDZazHornyA")
		Utility.wait(1)
		Debug.SendAnimationEvent(acActor, "DDZazHornyA")
		processOrgasmProgression()
		Utility.wait(3.0)		
		Debug.SendAnimationEvent(acActor, "DDZazHornyA")
		processOrgasmProgression()
		Utility.wait(4.0)
		Debug.SendAnimationEvent(acActor, "DDZazHornyB")
		processOrgasmProgression()
		Utility.wait(3.0)		
		Debug.SendAnimationEvent(acActor, "DDZazHornyB")
	else	
		Debug.SendAnimationEvent(acActor, "DDZazHornyA")
		Utility.wait(1)
		Debug.SendAnimationEvent(acActor, "DDZazHornyB")
		processOrgasmProgression()
		Utility.wait(2.0)
		processOrgasmProgression()
		Utility.wait(2.0)
		processOrgasmProgression()
		Utility.wait(2.5)
		processOrgasmProgression()
		Utility.wait(3.0)
		DTSound.playSoundSimple(acActor,DTStorage.DTRSlapsMarker)
		gainPleasure()
		Utility.wait(0.5)
		;processOrgasmProgression()
		
		int enjoyment = actorAlias.GetFullEnjoyment()
		bool orgasm = false
		
		if enjoyment > 150
			if Utility.randomInt(0,1)==0
				orgasm = true
			endif
		else
			if Utility.randomInt(0,3)==4
				orgasm = true
			endif
		endif
		
		if enjoyment < 80
			orgasm = false
		endif
		
		
		if orgasm == false
				if DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousGag)
					DTSound.playSoundSimple(acActor,DTStorage.DTRGagMoan02Marker)
					else
					DTSound.playSoundSimple(acActor,DTStorage.SexLabVoiceFemale03Hot)
					endif
		else
		Utility.wait(0.5)
			if DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousGag)
				DTSound.playSoundSimple(acActor,DTStorage.DTRGagMoan00Marker)
			else
				DTSound.playSoundSimple(acActor,DTStorage.zadOrgasm)
			endif
			Utility.wait(1.0)
			actorAlias.orgasm(-2)
OrgasmCount = 1
			Utility.wait(2.0)
			stopEffect()
		endif
		
		Utility.wait(2.0)
		

	endif
	
	SpankCount = SpankCount + 1
	
	;Utility.wait(1.0)
	
	

	
	;stageCounter -=1
EndEvent


Event OnEffectFinish(Actor acActor, Actor akCaster)
	
	if OrgasmCount>0
		libs.Trip(DTActor.npcs_ref[slot])
	else
		libs.ChastityBeltStruggle(DTActor.npcs_ref[slot])
	endif
	stopEffect()
EndEvent

function gainPleasure()
	float mod = 33
	int score = 0
	int maxscore = 0
	maxscore += 1
	if DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousBoots)
		mod = mod + ( 0.2 * acActor.getFactionRank(DTConfig.DT_Boots) )
		score += 1
	endif
	maxscore += 1
	if DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousCorset)
		mod = mod + ( 0.4 * acActor.getFactionRank(DTConfig.DT_Corset) )
		score += 1
	endif
	maxscore += 1
	if DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousHarness)
		mod = mod + ( 0.3 * acActor.getFactionRank(DTConfig.DT_Harness) )
		score += 1
	endif
	maxscore += 1
	if DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousLegCuffs)
		mod = mod + ( 0.3 * acActor.getFactionRank(DTConfig.DT_Legscuffs) )
		score += 1
	endif
	maxscore += 1
	if DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousArmCuffs)
		mod = mod + ( 0.3 * acActor.getFactionRank(DTConfig.DT_Armscuffs) )
		score += 1
	endif
	maxscore += 1
	if DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousGag)
		mod = mod + ( 0.2 * acActor.getFactionRank(DTConfig.DT_Gag) )
		score += 1
	endif
	maxscore += 1
	if DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousCollar)
		mod = mod + ( 0.2 * acActor.getFactionRank(DTConfig.DT_Collar) )
		score += 1
	endif
	maxscore += 1
	if DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousBlindfold)
		mod = mod + ( 0.5 * acActor.getFactionRank(DTConfig.DT_Blindfold) )
		score += 1
	endif
	maxscore += 1
	if DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousPlugAnal)
		mod = mod + ( 0.3 * acActor.getFactionRank(DTConfig.DT_AnalPlug) )
		score += 1
	endif
	maxscore += 1
	if DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousPlugVaginal)
		mod = mod + ( 0.5 * acActor.getFactionRank(DTConfig.DT_VaginalPlug) )
		score += 1
	endif	
	actorAlias.BonusEnjoyment(acActor ,mod as Int)	

		

					
endFunction

function processOrgasmProgression()
	int enjoyment = actorAlias.GetFullEnjoyment()

	
	if enjoyment < 50
		if DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousGag)
			DTSound.playSoundSimple(acActor,DTStorage.DTRGagMoan05Marker)
		else
			DTSound.playSoundSimple(acActor,DTStorage.SexLabVoiceFemale01Medium)
		endif
	endif
	if enjoyment >= 50 && enjoyment < 90
		if DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousGag)
			DTSound.playSoundSimple(acActor,DTStorage.DTRGagMoan04Marker)
		else
			DTSound.playSoundSimple(acActor,DTStorage.SexLabVoiceFemale02Hot)
		endif
	endif
	if enjoyment >= 90 && enjoyment < 120
			if DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousGag)
			DTSound.playSoundSimple(acActor,DTStorage.DTRGagMoan04Marker)
		else
			DTSound.playSoundSimple(acActor,DTStorage.SexLabVoiceFemale02Hot)
		endif
	endif
	if enjoyment >= 120
			if DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousGag)
			DTSound.playSoundSimple(acActor,DTStorage.DTRGagMoan04Marker)
		else
			DTSound.playSoundSimple(acActor,DTStorage.SexLabVoiceFemale02Hot)
		endif
	endif
	
endFunction