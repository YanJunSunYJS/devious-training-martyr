Scriptname DTRMenu extends SKI_ConfigBase

DTRMain Property DTMain Auto
DTRConfig Property DTConfig Auto

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

	Pages = new String[1]
	Pages[0] = "General settings"

	deviceType = new string[4]
	deviceType[0] = "White Ebonite"
	deviceType[1] = "White Leather"
	deviceType[2] = "Black Ebonite"
	deviceType[3] = "Black Leather"
	
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

	if (page == "General settings" || page == "")
		SetTitleText("General settings, version:"+DTMain.getDisplayVersion())
	endIf
EndEvent

string[] deviceType
