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

sslThreadModel property sexLabThread Auto
sslActorAlias Property actorAlias Auto

Int Property OrgasmCountDown Auto

Int Property prob Auto

Faction Property SexLabAnimatingFaction Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	OrgasmCountDown = -2
	OrgasmCount = 0
	;prob =  self.GetMagnitude() as int
	Slot = DTActor.isRegistered(akTarget)
	if Slot == -1 || DTActor.npcs_chastitySlut[Slot] > 1 || DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousBelt) == false
		DTActor.npcs_ponySlut[Slot] = 1		
		self.Dispel()
		return
	endIf
	DTActor.npcs_chastitySlut[Slot] = 2
	EffectIsRunning = true
	acActor = akTarget
	sexLabThread = SexLab.NewThread()
	sslBaseAnimation[] anims
	anims = SexLab.GetAnimationsByTags(1, "", "chastity",True)
	sexLabThread.AddActor(acActor ) ;adds the player﻿ into the animation
	sexLabThread.SetAnimations(anims)
	String hook = "DTR" ; "This is the name of the Hook"
	sexLabThread.SetHook(hook)
	RegisterForModEvent("StageStart_" + hook, "SexLabStageCh")
	RegisterForModEvent("PositionChange_" + hook, "SexLabStageCh")
	RegisterForModEvent("HookAnimationStart_" + hook, "OnAnimationStart")
	RegisterForModEvent("HookAnimationEnd_" + hook, "OnAnimationEnd")
	sexLabThread.StartThread()
	actorAlias = sexLabThread.ActorAlias(acActor )
EndEvent



function stopEffect()
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

	if DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousBoots)
		mod = mod + ( 0.2 * acActor.getFactionRank(DTConfig.DT_Boots) )
	endif
	if DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousCorset)
		mod = mod + ( 0.4 * acActor.getFactionRank(DTConfig.DT_Corset) )
	endif
	if DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousHarness)
		mod = mod + ( 0.3 * acActor.getFactionRank(DTConfig.DT_Harness) )
	endif
	if DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousLegCuffs)
		mod = mod + ( 0.3 * acActor.getFactionRank(DTConfig.DT_Legscuffs) )
	endif
	if DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousArmCuffs)
		mod = mod + ( 0.3 * acActor.getFactionRank(DTConfig.DT_Armscuffs) )
	endif
	if DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousGag)
		mod = mod + ( 0.2 * acActor.getFactionRank(DTConfig.DT_Gag) )
	endif
	if DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousCollar)
		mod = mod + ( 0.2 * acActor.getFactionRank(DTConfig.DT_Collar) )
	endif
	if DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousBlindfold)
		mod = mod + ( 0.5 * acActor.getFactionRank(DTConfig.DT_Blindfold) )
	endif
	if DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousPlugAnal)
		mod = mod + ( 0.3 * acActor.getFactionRank(DTConfig.DT_AnalPlug) )
	endif
	if DTActor.npcs_ref[slot].WornHasKeyword(libs.zad_DeviousPlugVaginal)
		mod = mod + ( 0.5 * acActor.getFactionRank(DTConfig.DT_VaginalPlug) )
	endif
	prob = prob + ( mod * self.GetMagnitude() )  as int
	actorAlias.BonusEnjoyment(acActor ,prob as Int)	
	debug.trace("ASLUT MOD:"+mod+" PROB:"+prob+" ENJ:"+actorAlias.GetFullEnjoyment() + " LIM"+self.GetMagnitude()+" COUNT:"+OrgasmCount)
	debug.notification("MOD:"+mod+" PROB:"+prob+" ENJ:"+actorAlias.GetFullEnjoyment() + " LIM"+self.GetMagnitude()+" COUNT:"+OrgasmCount)
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
					if Utility.randomInt(0,350) > actorAlias.GetFullEnjoyment()
						OrgasmCountDown += 1
					endif
					DTSound.playSoundSimple(acActor,DTStorage.SexLabVoiceFemale03Hot)
				elseif OrgasmCountDown == 0
					DTSound.playSoundSimple(acActor,DTStorage.zadOrgasm)
					actorAlias.orgasm(-2)
					OrgasmCount += 1
					prob = (prob * 0.3) as int;
				elseif OrgasmCountDown == -1
					DTSound.playSoundSimple(acActor,DTStorage.SexLabVoiceFemale01Medium)
				else
				endif
				OrgasmCountDown -= 1
			endif
			
		endif
	endif
endFunction
