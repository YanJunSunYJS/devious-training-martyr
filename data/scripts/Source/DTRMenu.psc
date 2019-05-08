Scriptname DTRMenu extends SKI_ConfigBase

DTRMain Property DTMain Auto

Event OnGameReload()
	parent.OnGameReload()
	Return
EndEvent


Event OnVersionUpdate(Int ver)
	OnConfigInit()
	Return
EndEvent

Int Function GetVersion()
	OnConfigInit()
	Return (DTMain.getVersion()*100) as int
EndFunction

Event OnConfigClose()
	;DTMain.resetAllWhatImportant()
endEvent

Event OnConfigInit()
	ModName = "Devious Training Martyr"
	Return
EndEvent



Event OnPageReset(string page)
	OnConfigInit()
	SetCursorFillMode(TOP_TO_BOTTOM)
	SetCursorPosition(0)	

	if (page == "")
		LoadCustomContent("DeviousTraining/DT.dds", 176, 23)
		return
	else
		UnloadCustomContent()
	endIf
  