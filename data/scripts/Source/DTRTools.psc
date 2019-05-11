Scriptname DTRTools extends Quest  


DTRConfig Property DTConfig Auto

import MiscUtil
import MfgConsoleFunc


function log2(String Context, String Msg, int level = 2, bool showAlways = false)

	log(Context+" - "+Msg,level, showAlways)

endFunction

function log(String Msg, int level = 2, bool showAlways = false)
	
	if DTConfig.showConsoleOutput == true || showAlways == true
		PrintConsole("DTR: "+ Msg)
	endIf
	
	if DTConfig.showTraceOutput == true || showAlways == true
		debug.trace("DTR: "+ Msg)
	endIf
endFunction

;SCAN

Actor[] function getActors(Actor acAktor, float rad = 0.0)
	Actor[] actors
	actors = new Actor[32]
	Actor acActor = acAktor
	if rad == 0.0
		;rad = DTConfig.scanerRange as float
		rad = 1000;
	endif
	float posx = acActor.GetPositionX()
	float posy = acActor.GetPositionY()
	float posz = acActor.GetPositionZ()
	int i = 0
	int index = 0
	while i < 30
		actor npctoadd = Game.FindRandomActor(posx, posy, posz, rad)
		if actors.find(npctoadd) == -1 && npctoadd != acAktor && npctoadd.isDead() == false
			actors[index] = npctoadd
			index+=1
		endif
		i+=1
	endWhile
	return actors
endFunction
