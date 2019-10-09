Scriptname DTRBlindSlutEffect extends ActiveMagicEffect  

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

Armor Property inventoryBlindfold  Auto
Armor Property scriptBlindfold  Auto

Zadlibs property libs auto  

Event OnEffectStart(Actor akTarget, Actor akCaster)

	if DTConfig.modEnabled == false
		Debug.messagebox("Devious Training is disabled, please enable to use this spell.")
		self.Dispel()
		return
	endif



	Slot = DTActor.isRegistered(akTarget)

	if Slot == -1 || DTActor.npcs_blindSlut[Slot] > 1; || DTActor.achievementBlindSlut[slot] == false
		inventoryBlindfold = DTConfig.deviceInventoryBlindfold[DTConfig.deviceColorIndex]
		scriptBlindfold = DTConfig.deviceScriptBlindfold[DTConfig.deviceColorIndex]
		turnOffEffect()
		self.Dispel()
		return
	endIf
	
	DTActor.npcs_blindSlut[Slot] = 2
	acActor = akTarget
	EffectIsRunning = true
	RegisterForSingleUpdate(0.1)

	inventoryBlindfold = DTConfig.deviceInventoryBlindfold[DTConfig.deviceColorIndex]
	scriptBlindfold = DTConfig.deviceScriptBlindfold[DTConfig.deviceColorIndex]
	libs.equipdevice(acActor,inventoryBlindfold,scriptBlindfold ,libs.zad_DeviousBlindfold)

EndEvent

function turnOffEffect()
	
	DTActor.npcs_blindSlut[Slot] = 1
	EffectIsRunning = false

	libs.RemoveDevice(acActor, inventoryBlindfold, scriptBlindfold, libs.zad_DeviousBlindfold)
endFunction

Event OnEffectFinish(Actor acActor, Actor akCaster)
	turnOffEffect()
EndEvent

Event OnUpdate()

	Actor[] actors	
	actors = DTTools.getActors(acActor,10000)
	int i = actors.length
	while i > 0
		i -= 1
		if actors[i]!=None && actors[i].isDead()==false && actors[i].IsHostileToActor(DTActor.npcs_ref[Slot])

			float distance = DTActor.npcs_ref[Slot].GetDistance(actors[i])
			int reductor = 10000
			float volume = 1.0 - (distance/reductor) as float

			if distance < 2000
				volume = 1.0
			endIf
				
			if DTActor.npcs_ref[Slot].IsSprinting()
				debug.trace("actor sprint")
				volume = volume * 0.1
			endIf				
			if DTActor.npcs_ref[Slot].IsRunning()
				debug.trace("actor run")
				volume = volume*0.5
			endIf

			if distance < 1000
				volume = 1.0
			endIf
				
				
			debug.trace("distance" +distance+" volume:"+volume)
			if volume > 0.1
				if actors[i].GetFactionRank (DTStorage.SkeletonFaction)> - 1
					DTSound.playSoundSimple(acActor, DTStorage.DTRHeartBeatZombieMarker, volume)
				elseIf actors[i].GetFactionRank (DTStorage.DraugrFaction)> - 1
					DTSound.playSoundSimple(acActor, DTStorage.DTRHeartBeatZombieMarker, volume)
				elseIf actors[i].GetFactionRank (DTStorage.DwarvenAutomatonFaction)> - 1
					DTSound.playSoundSimple(acActor, DTStorage.DTRHeartBeatAutomatMarker, volume)
				elseIf actors[i].GetFactionRank (DTStorage.CreatureFaction)> - 1
					DTSound.playSoundSimple(acActor, DTStorage.DTRHeartBeatCreatureMarker, volume)
				else
					DTSound.playSoundSimple(acActor, DTStorage.DTRHeartBeatHumanMarker, volume)
				endif
			endif
		endif
	endWhile

	if EffectIsRunning == true
		RegisterForSingleUpdate(2.5)
	endIf
EndEvent