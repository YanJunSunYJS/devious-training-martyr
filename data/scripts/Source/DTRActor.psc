Scriptname DTRActor extends Quest  

DTRTools Property DTTools Auto
DTRStorage Property DTStorage Auto
DTRConfig Property DTConfig Auto

Actor[] Property npcs_ref Auto

Int[] Property npcs_ponySlut Auto
Int[] Property npcs_blindSlut Auto
Int[] Property npcs_painSlut Auto

Int[] Property npc_sound1 Auto
Int[] Property npc_sound2 Auto
Int[] Property npc_sound3 Auto
Int[] Property npc_sound4 Auto
Int[] Property npc_sound5 Auto
Int[] Property npc_sound6 Auto
Int[] Property npc_sound7 Auto
Int[] Property npc_sound8 Auto
Int[] Property npc_sound9 Auto
Int[] Property npcs_lastSound Auto



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

		if npcs_blindSlut[Slot] == 0
			if npcs_ref[Slot].GetFactionRank(DTConfig.DT_Blindfold) > 0
				npcs_blindSlut[Slot] = 1
				npcs_ref[Slot].AddShout(DTStorage.DTRBlindSlut)
				Game.TeachWord(DTStorage.DTRBlindSlutWord1)
				Game.TeachWord(DTStorage.DTRBlindSlutWord2)
				Game.TeachWord(DTStorage.DTRBlindSlutWord3)
			endIf
		endIf
endFunction
