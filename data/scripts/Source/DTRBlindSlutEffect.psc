Scriptname DTRBlindSlutEffect extends ActiveMagicEffect  

DTRActor   Property DTActor   Auto
DTRConfig  Property DTConfig  Auto
DTRStorage Property DTStorage Auto
DTRTools   Property DTTools   Auto
DTRSound   Property DTSound   Auto
Actor Property acActor Auto
Int Property Slot Auto
Bool Property EffectIsRunning Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)

	Slot = DTActor.isRegistered(akTarget)

	if Slot == -1 || DTActor.npcs_blindSlut[Slot] > 1; || DTActor.achievementBlindSlut[slot] == false
		self.Dispel()
		return
	endIf
	
	DTActor.npcs_blindSlut[Slot] = 2
	acActor = akTarget
	EffectIsRunning = true
	RegisterForSingleUpdate(1.0)

;	if DTExpert.okBlindfold(Slot) == false
;	
;		libs.equipdevice(acActor, blindfoldInventory[DTConfig.achievement_ponygirl_colorset], blindfoldScript[DTConfig.achievement_ponygirl_colorset],DTConfig.ddKeywords[16])
;		activeEffect = true
;		selectedBlindfold = blindfoldScript[DTConfig.achievement_ponygirl_colorset] as Armor
;		DTTools.log("DT2TransformToPonyME::Equip Armbinder Selected:"+selectedBlindfold,0)
;	else
;		;DTTools.log("DT2TransformToPonyME::Equip Armbinder Skipped:"+acActor.GetWornForm(DTConfig.slotMask[46]) as Armor,0)
;	endIf

EndEvent

Event OnEffectFinish(Actor acActor, Actor akCaster)

	DTActor.npcs_blindSlut[Slot] = 1
	EffectIsRunning = false
;	if acActor.GetWornForm(DTConfig.slotMask[55]) as Armor == selectedBlindfold as Armor
;		DTTools.log("DT2TransformToPonyME::Remove Armbinder (Try)")	
;		libs.RemoveDevice(acActor, blindfoldInventory[DTConfig.achievement_ponygirl_colorset], blindfoldScript[DTConfig.achievement_ponygirl_colorset], DTConfig.ddKeywords[16])
;		acActor.RemoveItem(blindfoldInventory[DTConfig.achievement_ponygirl_colorset], 1)
;		acActor.RemoveItem(blindfoldScript[DTConfig.achievement_ponygirl_colorset], 1)
;	else
;		DTTools.log("DT2TransformToPonyME::Remove Armbinder (Fail)")	
	;DTTools.log("DT2TransformToPonyME::Compared Items: "+acActor.GetWornForm(DTConfig.slotMask[46]) as Armor+" and "+selectedArmbinder as Armor)		
;	endif
	
EndEvent

Event OnUpdate()

	Actor[] actors
	actors = DTTools.getActors(acActor,10000)
	int i = actors.length
	while i > 0
	
		i -= 1
		if actors[i]!=None
			float distance = Game.GetPlayer().GetDistance(actors[i])
			debug.notification(actors[i].GetActorBase().getName()+" "+distance)
			debug.trace(actors[i]+" "+actors[i].GetActorBase().getName()+" "+distance)
			DTSound.playSound(Slot, DTStorage.DTRHeartBeatHumanMarker, (1.0 - distance/9000))
			
		endIf
	endWhile
	
	if EffectIsRunning == true
		RegisterForSingleUpdate(3.5)
	endIf
EndEvent