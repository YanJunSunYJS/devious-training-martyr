Scriptname DTRPlayerAlias extends ReferenceAlias 

DTRMain Property DTMain Auto


Event OnPlayerLoadGame()
	DTMain.onLoadFunction()
;	debug.messagebox("loaded")
EndEvent

Event OnLocationChange(Location akOldLoc, Location akNewLoc)
	DTMain.onLocationChanged()
endEvent
