Scriptname DTRDTRArousedSlutEffect extends ActiveMagicEffect  

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
		self.Dispel()
		return
	endIf
EndEvent

Event OnEffectFinish(Actor acActor, Actor akCaster)
	if EffectIsRunning == true
;		turnOffEffect()
	endif
EndEvent