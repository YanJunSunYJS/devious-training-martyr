Scriptname DTRActor extends Quest  

DTRTools Property DTTools Auto
DTRStorage Property DTStorage Auto
DTRConfig Property DTConfig Auto
Zadlibs property libs auto
Actor[] Property npcs_ref Auto

Int[] Property npcs_ponySlut Auto
Int[] Property npcs_blindSlut Auto
Int[] Property npcs_painSlut Auto
Int[] Property npcs_chastitySlut Auto

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
	;this plugin works only with real player!
	if akActor!=DTConfig.playerRef
		return
	endif
	
	DTTools.log2("DTR register actor", akActor)
	if npcs_ref[Slot]!=akActor
		npcs_ref[Slot] = akActor
		;processActor(Slot)
		;npcs_ref[Slot].addSpell(DTStorage.DTREffects)
	endIf
endFunction

function processSpells(int Slot)
Game.getPlayer().removeSpell(DTStorage.DTRBVoicePainSlut1)
	Game.getPlayer().removeSpell(DTStorage.DTRBVoicePainSlut2)
	Game.getPlayer().removeSpell(DTStorage.DTRBVoicePainSlut3)
	Game.getPlayer().removeSpell(DTStorage.DTRBVoicePonyGirl1)
	Game.getPlayer().removeSpell(DTStorage.DTRBVoicePonyGirl2)
	Game.getPlayer().removeSpell(DTStorage.DTRBVoicePonyGirl3)
	Game.getPlayer().removeSpell(DTStorage.DTRBVoiceBlindSlut1)
	Game.getPlayer().removeSpell(DTStorage.DTRBVoiceBlindSlut2)
	Game.getPlayer().removeSpell(DTStorage.DTRBVoiceBlindSlut3)
	Game.getPlayer().removeSpell(DTStorage.DTRBVoiceArousedSlut1)
	Game.getPlayer().removeSpell(DTStorage.DTRBVoiceArousedSlut2)
	Game.getPlayer().removeSpell(DTStorage.DTRBVoiceArousedSlut3)
	;poor but will works good
	if Game.IsWordUnlocked(DTStorage.DTRPainSlutWord1)
		Game.getPlayer().addSpell(DTStorage.DTRBVoicePainSlut1,false)
	endif
	if Game.IsWordUnlocked(DTStorage.DTRPainSlutWord2)
		Game.getPlayer().addSpell(DTStorage.DTRBVoicePainSlut2,false)
	endif
	if Game.IsWordUnlocked(DTStorage.DTRPainSlutWord3)
		Game.getPlayer().addSpell(DTStorage.DTRBVoicePainSlut3,false)
	endif	
	
	if Game.IsWordUnlocked(DTStorage.DTRPonyGirlWord1)
		Game.getPlayer().addSpell(DTStorage.DTRBVoicePonyGirl1,false)
	endif
	if Game.IsWordUnlocked(DTStorage.DTRPonyGirlWord2)
		Game.getPlayer().addSpell(DTStorage.DTRBVoicePonyGirl2,false)
	endif
	if Game.IsWordUnlocked(DTStorage.DTRPonyGirlWord3)
		Game.getPlayer().addSpell(DTStorage.DTRBVoicePonyGirl3,false)
	endif
	
	if Game.IsWordUnlocked(DTStorage.DTRBlindSlutWord1)
		Game.getPlayer().addSpell(DTStorage.DTRBVoiceBlindSlut1,false)
	endif
	if Game.IsWordUnlocked(DTStorage.DTRBlindSlutWord2)
		Game.getPlayer().addSpell(DTStorage.DTRBVoiceBlindSlut2,false)
	endif
	if Game.IsWordUnlocked(DTStorage.DTRBlindSlutWord3)
		Game.getPlayer().addSpell(DTStorage.DTRBVoiceBlindSlut3,false)
	endif
	
	if Game.IsWordUnlocked(DTStorage.DTRArousedSlut1)
		Game.getPlayer().addSpell(DTStorage.DTRBVoiceArousedSlut1,false)
	endif
	if Game.IsWordUnlocked(DTStorage.DTRArousedSlut2)
		Game.getPlayer().addSpell(DTStorage.DTRBVoiceArousedSlut2,false)
	endif
	if Game.IsWordUnlocked(DTStorage.DTRArousedSlut3)
		Game.getPlayer().addSpell(DTStorage.DTRBVoiceArousedSlut3,false)
	endif
endFunction

function resetAllChanges(int Slot)
	;npcs_ref[Slot].removeSpell(DTStorage.DTREffects)
	;npcs_ref[Slot].addSpell(DTStorage.DTREffects)
	
	processSpells(Slot)
endFunction

function unregisterActor(Actor akActor, int Slot)

	;/resetAllChanges(Slot)
	ActorOverlayRemove(npcs_ref[Slot], "body", "day",true )
	ActorOverlayRemove(npcs_ref[Slot], "body", "scars",true )
	ActorOverlayRemove(npcs_ref[Slot], "body", "itemsoverlays",true )
	;procedure
	/;
	;npcs_ref[Slot].removeSpell(DTStorage.DTREffects)

	if npcs_ref[Slot]==akActor
		npcs_ref[Slot] = None
	endIf
endFunction


function processActor(int Slot, String item = "", float value = -1.0, float value2 = -1.0)

	if item == "zazHit"
		if npcs_painSlut[Slot] == 0 && DTConfig.separateOrgasmPack == true
			;nothing to do if counter is smaller than 50 hits
			if value as int < 50
				return
			endif
			;lets try...
			if Utility.randomInt(value as int,200) == 200
				npcs_painSlut[Slot] = 1
				npcs_ref[Slot].AddShout(DTStorage.DTRPainSlut)
				Game.TeachWord(DTStorage.DTRPainSlutWord1)
				Game.TeachWord(DTStorage.DTRPainSlutWord2)
				Game.TeachWord(DTStorage.DTRPainSlutWord3)
				Game.UnlockWord(DTStorage.DTRPainSlutWord1)
			endif
		endif
		return
	endif

	if npcs_blindSlut[Slot] == 0
		if npcs_ref[Slot].GetFactionRank(DTConfig.DT_Blindfold) >= 6
			npcs_blindSlut[Slot] = 1
			addEffectByStuff(Slot)
			npcs_ref[Slot].AddShout(DTStorage.DTRBlindSlut)
			Game.TeachWord(DTStorage.DTRBlindSlutWord1)
			Game.TeachWord(DTStorage.DTRBlindSlutWord2)
			Game.TeachWord(DTStorage.DTRBlindSlutWord3)
			Game.UnlockWord(DTStorage.DTRBlindSlutWord1)
		endIf
	endIf
	
	if npcs_ponySlut[Slot] == 0
		if npcs_ref[Slot].GetFactionRank(DTConfig.DT_Boots) >= 6 && npcs_ref[Slot].GetFactionRank(DTConfig.DT_Gag) >=6 && npcs_ref[Slot].GetFactionRank(DTConfig.DT_Armbinderyoke) >= 6
			npcs_ponySlut[Slot] = 1
			addEffectByStuff(Slot)
			npcs_ref[Slot].AddShout(DTStorage.DTRPonyGirl)
			Game.TeachWord(DTStorage.DTRPonyGirlWord1)
			Game.TeachWord(DTStorage.DTRPonyGirlWord2)
			Game.TeachWord(DTStorage.DTRPonyGirlWord3)
			Game.UnlockWord(DTStorage.DTRPonyGirlWord1)
		endIf
	endif
	
	if npcs_chastitySlut[Slot] == 0 && DTConfig.separateOrgasmPack == true
		if npcs_ref[Slot].GetFactionRank(DTConfig.DT_Chastitybelt) >= 6
			npcs_chastitySlut[Slot] = 1
			npcs_ref[Slot].AddShout(DTStorage.DTRArousedSlut)
			Game.TeachWord(DTStorage.DTRArousedSlut1)
			Game.TeachWord(DTStorage.DTRArousedSlut2)
			Game.TeachWord(DTStorage.DTRArousedSlut3)
			Game.UnlockWord(DTStorage.DTRArousedSlut1)
		endIf
	endif
endFunction


function addEffectByStuff(int Slot)

	if npcs_ponySlut[Slot] > 0
		if npcs_ref[Slot].WornHasKeyword(libs.zad_DeviousArmbinder) || npcs_ref[Slot].WornHasKeyword(libs.zad_DeviousYoke)
			if npcs_ref[Slot].WornHasKeyword(libs.zad_DeviousGag) && npcs_ref[Slot].WornHasKeyword(libs.zad_DeviousBoots)
				if npcs_ref[Slot].HasSpell(DTStorage.DTRPonyGirlBoost)==false
					npcs_ref[Slot].addSpell(DTStorage.DTRPonyGirlBoost)
				endIf
			else
				npcs_ref[Slot].removeSpell(DTStorage.DTRPonyGirlBoost)
			endIf
		else
			npcs_ref[Slot].removeSpell(DTStorage.DTRPonyGirlBoost)
		endIf
	endIf
	
	if npcs_blindSlut[Slot] > 0
		if npcs_ref[Slot].WornHasKeyword(libs.zad_DeviousBlindfold)
			if npcs_ref[Slot].HasSpell(DTStorage.DTRBlindSlutDetect)==false
				npcs_ref[Slot].addSpell(DTStorage.DTRBlindSlutDetect)
			endIf
		else
			npcs_ref[Slot].removeSpell(DTStorage.DTRBlindSlutDetect)
		endif
	endIf


endFunction