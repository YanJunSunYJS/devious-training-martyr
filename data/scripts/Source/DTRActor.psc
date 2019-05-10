Scriptname DTRActor extends Quest  

DTRTools Property DTTools Auto
DTRStorage Property DTStorage Auto

Actor[] Property npcs_ref Auto


int function getArrayCount()
	return ( npcs_ref.length - 1 )
endFunction

;return slot nr or -1 if unregistered
int function isRegistered(Actor acAktor)
	int i = 0
    while i < getArrayCount()
		if acAktor == npcs_ref[i]
			return i
		endif
		i+=1
	endWhile
	return -1
endFunction

function registerActor(Actor akActor, int Slot)
	
	DTTools.log2("DTR register actor", akActor)
	
	if npcs_ref[Slot]!=akActor
		npcs_ref[Slot] = akActor

		;processActor(Slot)
		;npcs_ref[Slot].addSpell(DTConfig.EffectSpell)
	endIf

	
	
	
endFunction

function unregisterActor(Actor akActor, int Slot)
	
	;/resetAllChanges(Slot)
	
	ActorOverlayRemove(npcs_ref[Slot], "body", "day",true )
	ActorOverlayRemove(npcs_ref[Slot], "body", "scars",true )
	ActorOverlayRemove(npcs_ref[Slot], "body", "itemsoverlays",true )
	;procedure
	npcs_ref[Slot].removeSpell(DTConfig.EffectSpell)
	/;
	if npcs_ref[Slot]==akActor
		npcs_ref[Slot] = None
	endIf
	
	
	
	
endFunction


function processActor(int Slot, String item = "", float value = -1.0, float value2 = -1.0)
endFunction