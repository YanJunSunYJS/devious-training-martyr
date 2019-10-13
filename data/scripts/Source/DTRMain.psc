Scriptname DTRMain extends Quest  

; external elements
DTRConfig Property DTConfig Auto
DTRTools Property DTTools Auto
DTRUpdate Property DTUpdate Auto
DTRActor Property DTActor Auto

;hardcoded version info
Float function getVersion()
	return 1.5
endFunction

;hardcoded version info (as string)
String function getDisplayVersion()
	return "1.0"
endFunction

;start mod
Event OnInit()

	;setup simple info at first
	DTConfig.modEnabled = true
	DTConfig.showConsoleOutput = true
	DTConfig.showTraceOutput = true
	DTConfig.lastVersion = 0			;set low value to force all updates

	;force first update
	DTUpdate.Update(getVersion())
	Utility.wait(5.0)
	startMod()
EndEvent

;disable all elements
function stopMod()
	DTConfig.modEnabled = false
	stopEvents()
endFunction

;enable all important elements
function startMod()
	DTConfig.modEnabled = true
	stopEvents()
	initEvents()
	grabActors()
endFunction

;function to support save/load
function onLoadFunction()
	debug.trace("DTR - onLoadFunction")
	DTUpdate.Update(getVersion())
	stopEvents()
	initEvents()
	
	int i = 0
	while i < DTActor.getArrayCount()
		if DTActor.npcs_ref[i]!=None
			DTActor.resetAllChanges(i)
		endif
		i+=1
	endwhile
	
	onLocationChanged()
endFunction

;period run 
function onLocationChanged()
	debug.trace("DTR - onLocationChanged")
endFunction



; IMPORTANT FOR INTEGRATION

	;IMPORTANT! TWO EVENTS CONTAIN IN NAME PREFIX - PLEASE CHANGE IT IF YOU NEED YOUR OWN!
	; Initialize important event
	function initEvents()
		RegisterForModEvent("DT_ActorRegister", "eventRegister")
		RegisterForModEvent("DT_ActorUnRegister", "eventUnRegister")
		RegisterForModEvent("DT_ActorLevelChange", "eventLevelUp")
		RegisterForModEvent("DT_CheckActorDTR", "eventCheckActor")						;IMPORTANT: Syntax: DT_CheckActor(MOD PREFIX)
		RegisterForModEvent("DT_AdditionalStatsActorDTR", "eventAdditionalStatsActor")	;IMPORTANT: Syntax: DT_AdditionalStatsActor(MOD PREFIX)
		RegisterForModEvent("DT_Updated", "eventUpdate")
		RegisterForModEvent("DT_NewEvent", "eventNewEvent")
		UnregisterForModEvent("DT_SendStatus")
		RegisterForModEvent("DT_SendStatus", "eventStatus")
	endFunction

	; Uninitialize important event
	function stopEvents()
		UnregisterForModEvent("DT_ActorRegister")
		UnregisterForModEvent("DT_ActorUnRegister")
		UnregisterForModEvent("DT_ActorLevelChange")
		UnregisterForModEvent("DT_CheckActorDTR")										;IMPORTANT: Syntax: DT_CheckActor(MOD PREFIX)
		UnregisterForModEvent("DT_AdditionalStatsActorDTR")								;IMPORTANT: Syntax: DT_AdditionalStatsActor(MOD PREFIX)
		UnregisterForModEvent("DT_Updated")
		UnregisterForModEvent("DT_NewEvent")
	endFunction
	 
	;EVENTS:
	
	
		
		;TODO: finish it
		;recive status of DeviousTraining.esp
		Event eventStatus(string status)
			
			;DTTools.log2("Status", status)
			
			;updateActors()
			if status == "disable" || status == "uninstall"
				DTConfig.modEnabled = false
				int i = 0
				while i < DTActor.getArrayCount()
					if DTActor.npcs_ref[i]!=None
				;		if DTActor.npcs_ref[i].hasSpell(DTConfig.EffectSpell)
				;			DTActor.npcs_ref[i].removeSpell(DTConfig.EffectSpell)
				;		endif
				;		DTActor.resetAllChanges(i)
					DTActor.unregisterActor(DTActor.npcs_ref[i],i)
					endif
					i+=1
				endwhile
			endif
	
			if status == "enable"
				if DTConfig.modEnabled == false
					startMod()
				endif
			endif	
	
			if status == "uninstall"
				stopMod()
				int i = 0
				while i < DTActor.getArrayCount()
					if DTActor.npcs_ref[i]!=None
						DTActor.unregisterActor(DTActor.npcs_ref[i],i)
					endif
					i+=1
				endwhile
				;UnregisterForModEvent("DT_SendStatus")
				stopEvents()
			endif
		endEvent
		

		
		Event eventNewEvent(Form akActorForm, int Slot ,String kind,int value)
			actor akActor = akActorForm as Actor
			if kind == "zazHit"
				DTActor.processActor(Slot, "zazHit", value)
			endif
		endEvent
		
		;This event is called when DT detect changes (or want to force changes)
		;Its a signal that something happens in core (levelup/MCM/etc...)
		Event eventUpdate(float version)
			updateActors()
			onLocationChanged()
		endEvent

		;Collect some extra info about PC (list inside function)
		Event eventAdditionalStatsActor(Form akActorForm,int modIndex,int orgasm,int steps, int dmg,int dmgZad, int days)
			DTTools.log2("DTR orgasm",orgasm)
			DTTools.log2("DTR steps",steps)
			DTTools.log2("DTR dmg",dmg)
			DTTools.log2("DTR dmgZad",dmgZad)
			DTTools.log2("DTR days",days)
			
			;DTActor.processActor(modIndex, "weight", steps , orgasm)
			;DTActor.processActor(modIndex, "tats_days", days)
			DTActor.processActor(modIndex, "tats_hitsZad", dmgZad)
			
		endEvent
		
		;
		Event eventCheckActor(Form akActorForm,int modIndex)
			DTTools.log2("DTR","eventCheckActor")
			actor akActor = akActorForm as Actor
			DTActor.registerActor(akActor,modIndex)
			DTActor.processActor(modIndex)
		endEvent
		
		
		Event eventRegister(Form akActorForm,int modIndex)
			DTTools.log2("DTR","eventRegister")
			actor akActor = akActorForm as Actor
			DTActor.registerActor(akActor,modIndex)
		endEvent

		
		Event eventUnRegister(Form akActorForm,int modIndex)
			DTTools.log2("DTR","eventUnRegister")
		   actor akActor = akActorForm as Actor
		   DTActor.unregisterActor(akActor,modIndex)
		   
		endEvent

		Event eventLevelUp(Form akActorForm,int modIndex,String itemname, int oldlevel, int newlevel)
		DTTools.log2("DTR","eventLevelUp")
		DTTools.log2("DTR","eventLevelUp " + itemname)
		DTTools.log2("DTR","eventLevelUp " + oldlevel)
		DTTools.log2("DTR","eventLevelUp " + newlevel)
		   actor akActor = akActorForm as Actor
		   DTActor.processActor(modIndex, itemname, newlevel)
			;DTTools.log2("eventUnRegister",akActorForm)
			;DTTools.log2("eventUnRegister",itemname)
			;DTTools.log2("eventUnRegister",oldlevel)
			;DTTools.log2("eventUnRegister",newlevel)
		   
			;debug.trace("eventLevelUp")
			;debug.trace(akActor)
			;debug.trace(itemname)
			;debug.trace(oldlevel)
			;debug.trace(newlevel)
			;debug.notification("akActor")
			;debug.notification("eventLevelUp")
		endEvent
	
	;FUNCTIONS:
	
		;Request actor list
		function grabActors()
			DTTools.log2("CallEvent","DTR_Ping")
			int handle = ModEvent.Create("DT_Ping") 
			ModEvent.pushString(handle,"DTR")
			ModEvent.Send(handle)		
		endFunction
		
		
		;Request additional stuff
		function grabAdditionalStats()
			DTTools.log2("CallEvent","DT_AdditionalStats")
			int handle = ModEvent.Create("DT_AdditionalStats") 
			ModEvent.pushString(handle,"DTR")
			ModEvent.Send(handle)		
		endFunction
		
		
		function updateActors()
			int i = 0
			while i < DTActor.getArrayCount()
				if DTActor.npcs_ref[i]!=None
					DTActor.processActor(i)
				endif
				i+=1
			endwhile
		endFunction
