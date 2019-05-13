Scriptname DTRArousedSlutEffect extends ActiveMagicEffect  

DTRActor   Property DTActor   Auto
DTRConfig  Property DTConfig  Auto
DTRStorage Property DTStorage Auto
DTRTools   Property DTTools   Auto
DTRSound   Property DTSound   Auto

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

Faction Property SexLabAnimatingFaction Auto

bool Property zazAnimFilter Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)


	stageCounter  = self.GetMagnitude() as int 			;set up max animation cycles (for 1 it happens 2 time)
	OrgasmCountDown = -2								;to navigate "stage" and distance to orgasm
	OrgasmCount = 0										;orgasm counter

	;std init
	Slot = DTActor.isRegistered(akTarget)
	if Slot == -1 || DTActor.npcs_chastitySlut[Slot] > 1 || DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousBelt) == false
		if DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousBelt) == false
			debug.messagebox("Shaout works only with chastity belt!")
		endif
		DTActor.npcs_ponySlut[Slot] = 1		
		self.Dispel()
		return
	endIf

	;save variable and turn off dd animatio filters
	zazAnimFilter = libs.config.useAnimFilter
	libs.config.useAnimFilter = false
		
	DTActor.npcs_chastitySlut[Slot] = 2
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

	;setup sexlab
	sexLabThread.AddActor(acActor ) ;adds the player﻿ into the animation
	sexLabThread.SetAnimations(Sanims)
	String hook = "DTR" ; "This is the name of the Hook"
	sexLabThread.SetHook(hook)

	RegisterForModEvent("StageStart_" + hook, "SexLabStageCh")
	RegisterForModEvent("PositionChange_" + hook, "SexLabStageCh")
	RegisterForModEvent("HookAnimationStart_" + hook, "OnAnimationStart")
	RegisterForModEvent("HookAnimationEnd_" + hook, "OnAnimationEnd")
	sexLabThreadCtr = sexLabThread.StartThread()
	actorAlias = sexLabThread.ActorAlias(acActor )
EndEvent



function stopEffect()
	libs.config.useAnimFilter = zazAnimFilter
	String hook = "DTR" ; "This is the name of the Hook"
	UnRegisterForModEvent("StageStart_" + hook)
	UnRegisterForModEvent("PositionChange_" + hook)
	UnRegisterForModEvent("HookAnimationStart_" + hook)
	UnRegisterForModEvent("HookAnimationEnd_" + hook)
	EffectIsRunning = false
	DTActor.npcs_chastitySlut[Slot] = 1
	self.dispel()
endFunction

Event onUpdate()
	if acActor.getFactionRank(SexLabAnimatingFaction)<0 || EffectIsRunning==false || DTActor.npcs_chastitySlut[Slot] == 1
		
		stopEffect()
		self.dispel()
		return
	endif

	if (EffectIsRunning==true)
		processOrgasmProgression()
		RegisterForSingleUpdate(2)
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
		return
	endif
	Utility.wait(19)
	sexLabThreadCtr.goToStage(1)
	stageCounter -=1
EndEvent


Event OnEffectFinish(Actor acActor, Actor akCaster)
	
	if OrgasmCount>0
		libs.Trip(DTActor.npcs_ref[slot])
	else
		libs.ChastityBeltStruggle(DTActor.npcs_ref[slot])
	endif
	stopEffect()
EndEvent


function processOrgasmProgression()

	if orgasmCount > self.GetMagnitude() as int
		debug.notification("no more!")
		return
	endif

	float mod = 0
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
	Int arMod = actorAlias.GetFullEnjoyment()

	if arMod > 100
		arMod = 100
	endif

	if actorAlias.GetFullEnjoyment() > 90
		if Utility.randomInt(0,200) < actorAlias.GetFullEnjoyment()
			if OrgasmCountDown<-1
				OrgasmCountDown = 5
			endif
			if OrgasmCountDown > -2
				if OrgasmCountDown == 5
					DTSound.playSoundSimple(acActor,DTStorage.SexLabVoiceFemale01Medium)
				elseif OrgasmCountDown == 4
					DTSound.playSoundSimple(acActor,DTStorage.SexLabVoiceFemale02Hot)
				elseif OrgasmCountDown == 3
					DTSound.playSoundSimple(acActor,DTStorage.SexLabVoiceFemale03Hot)
				elseif OrgasmCountDown == 2
					DTSound.playSoundSimple(acActor,DTStorage.SexLabVoiceFemale03Hot)
				elseif OrgasmCountDown == 1
					;make orgasm harder
					if Utility.randomInt(0, (maxscore * 10)) < mod as int
						OrgasmCountDown += 1
					endif
					DTSound.playSoundSimple(acActor,DTStorage.SexLabVoiceFemale03Hot)
				elseif OrgasmCountDown == 0
					DTSound.playSoundSimple(acActor,DTStorage.zadOrgasm)
					actorAlias.orgasm(-2)
					OrgasmCount += 1
				elseif OrgasmCountDown == -1
					DTSound.playSoundSimple(acActor,DTStorage.SexLabVoiceFemale01Medium)
				else
				endif
				OrgasmCountDown -= 1
			endif
			
		endif
	endif
endFunction
