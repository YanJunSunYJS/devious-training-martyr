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

Zadlibs property libs auto



Event OnEffectStart(Actor akTarget, Actor akCaster)

	Slot = DTActor.isRegistered(akTarget)

	if Slot == -1 || DTActor.npcs_ponySlut[Slot] > 1; || DTActor.achievementBlindSlut[slot] == false
		inventoryArmbinder = DTConfig.deviceInventoryArmbinder[DTConfig.deviceColorIndex]
		scriptArmbinder = DTConfig.deviceScriptArmbinder[DTConfig.deviceColorIndex]
		inventoryPonyboots = DTConfig.deviceInventoryPonyBoots[DTConfig.deviceColorIndex]
		scriptPonyboots = DTConfig.deviceScriptPonyBoots[DTConfig.deviceColorIndex]
		turnOffEffect()
		self.Dispel()
		return
	endIf
	
	DTActor.npcs_ponySlut[Slot] = 2
	acActor = akTarget
	EffectIsRunning = true
	

	inventoryArmbinder = DTConfig.deviceInventoryArmbinder[DTConfig.deviceColorIndex]
	scriptArmbinder = DTConfig.deviceScriptArmbinder[DTConfig.deviceColorIndex]
	inventoryPonyboots = DTConfig.deviceInventoryPonyBoots[DTConfig.deviceColorIndex]
	scriptPonyboots = DTConfig.deviceScriptPonyBoots[DTConfig.deviceColorIndex]
	libs.equipdevice(acActor,inventoryArmbinder,scriptArmbinder ,libs.zad_DeviousArmbinder)
	libs.equipdevice(acActor,inventoryPonyboots,scriptPonyboots ,libs.zad_DeviousBoots)

EndEvent

function turnOffEffect()
	debug.messagebox("opk")
	DTActor.npcs_ponySlut[Slot] = 1
	EffectIsRunning = false

	libs.RemoveDevice(acActor, inventoryArmbinder, scriptArmbinder, libs.zad_DeviousArmbinder)
	libs.RemoveDevice(acActor, inventoryPonyboots, scriptPonyboots, libs.zad_DeviousBoots)
endFunction

Event OnEffectFinish(Actor acActor, Actor akCaster)
	turnOffEffect()
EndEvent