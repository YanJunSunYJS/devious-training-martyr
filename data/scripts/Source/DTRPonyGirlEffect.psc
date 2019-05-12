Scriptname DTRPonyGirlEffect extends ActiveMagicEffect  


DTRActor   Property DTActor   Auto
DTRConfig  Property DTConfig  Auto
DTRStorage Property DTStorage Auto
DTRTools   Property DTTools   Auto
DTRSound   Property DTSound   Auto

Actor Property acActor Auto
Int Property Slot Auto
Bool Property EffectIsRunning Auto
Bool Property MainProcessingIsFinished Auto
Actor[] Property foundActors Auto

Armor Property inventoryArmbinder  Auto
Armor Property scriptArmbinder  Auto
Armor Property inventoryPonyboots  Auto
Armor Property scriptPonyboots  Auto
Armor Property inventoryPonyGag  Auto
Armor Property scriptPonyGag  Auto

Zadlibs property libs auto

SexLabFramework Property SexLab Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	
	Slot = DTActor.isRegistered(akTarget)

	if Slot == -1 || DTActor.npcs_ponySlut[Slot] > 1; || DTActor.achievementBlindSlut[slot] == false
		DTActor.npcs_ponySlut[Slot] = 1
		EffectIsRunning = false
		self.Dispel()
		return
	endIf
	
	;/
	sslThreadModel thread = SexLab.NewThread()
	sslBaseAnimation[] anims
	anims = SexLab.GetAnimationsByTags(1, "", "chastity",True)
	thread.AddActor(akTarget) ;adds the player﻿ into the animation
	thread.SetAnimations(anims)
	thread.StartThread()
	sslActorAlias	  ac = thread.ActorAlias(akTarget)
	utility.wait(10)
	debug.notification("orgasm")
	ac.orgasm(-2)
	;libs.ActorOrgasm(akTarget,25)
	/;
	
	DTActor.npcs_ponySlut[Slot] = 2
	acActor = akTarget
	EffectIsRunning = true

	inventoryArmbinder = DTConfig.deviceInventoryArmbinder[DTConfig.deviceColorIndex]
	scriptArmbinder = DTConfig.deviceScriptArmbinder[DTConfig.deviceColorIndex]
	inventoryPonyboots = DTConfig.deviceInventoryPonyBoots[DTConfig.deviceColorIndex]
	scriptPonyboots = DTConfig.deviceScriptPonyBoots[DTConfig.deviceColorIndex]
	inventoryPonyGag = DTConfig.deviceInventoryPonyGag[DTConfig.deviceColorIndex]
	scriptPonyGag = DTConfig.deviceScriptPonyGag[DTConfig.deviceColorIndex]	
	libs.equipdevice(acActor,inventoryArmbinder,scriptArmbinder ,libs.zad_DeviousArmbinder)
	libs.equipdevice(acActor,inventoryPonyboots,scriptPonyboots ,libs.zad_DeviousBoots)
	libs.equipdevice(acActor,inventoryPonyGag,scriptPonyGag ,libs.zad_DeviousGag)
	libs.equipdevice(acActor,DTStorage.zadx_HR_PlugPonyTail01Inventory,DTStorage.zadx_HR_PlugPonyTail01Rendered ,libs.zad_DeviousPlugAnal)

	registerForSingleUpdate(1.0)
EndEvent

function turnOffEffect()
	DTActor.npcs_ponySlut[Slot] = 1
	EffectIsRunning = false
	;can log errors but dont worry
	libs.RemoveDevice(acActor, inventoryArmbinder, scriptArmbinder, libs.zad_DeviousArmbinder)
	libs.RemoveDevice(acActor, inventoryPonyboots, scriptPonyboots, libs.zad_DeviousBoots)
	libs.RemoveDevice(acActor, inventoryPonyGag, scriptPonyGag, libs.zad_DeviousGag)
	libs.RemoveDevice(acActor,DTStorage.zadx_HR_PlugPonyTail01Inventory,DTStorage.zadx_HR_PlugPonyTail01Rendered , libs.zad_DeviousPlugAnal)
	DTActor.npcs_ref[Slot].removeItem(inventoryArmbinder,1,true)
	DTActor.npcs_ref[Slot].removeItem(scriptArmbinder,1,true)
	DTActor.npcs_ref[Slot].removeItem(inventoryPonyboots,1,true)
	DTActor.npcs_ref[Slot].removeItem(scriptPonyboots,1,true)
	DTActor.npcs_ref[Slot].removeItem(inventoryPonyGag,1,true)
	DTActor.npcs_ref[Slot].removeItem(scriptPonyGag,1,true)
	DTActor.npcs_ref[Slot].removeItem(DTStorage.zadx_HR_PlugPonyTail01Inventory,1,true)
	DTActor.npcs_ref[Slot].removeItem(DTStorage.zadx_HR_PlugPonyTail01Rendered,1,true)
endFunction

Event OnEffectFinish(Actor acActor, Actor akCaster)
	if EffectIsRunning == true
		turnOffEffect()
	endif
EndEvent

Event OnUpdate()
	if DTActor.npcs_ponySlut[Slot] < 2
		turnOffEffect()
		self.Dispel()
	endif
	if EffectIsRunning == true
		RegisterForSingleUpdate(2)
	endIf
EndEvent