Scriptname DTRPlayerAlias extends ReferenceAlias 

DTRMain Property DTMain Auto
DTRActor Property DTActor Auto

Event OnPlayerLoadGame()
	DTMain.onLoadFunction()
;	debug.messagebox("loaded")
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	DTMain.onLocationChanged()
endEvent

Event OnObjectEquipped(Form akBaseObject, ObjectReference akReference)
	int Slot = DTActor.isRegistered(Game.getPlayer())	
	DTActor.addEffectByStuff(Slot)	;;always player!
endEvent
