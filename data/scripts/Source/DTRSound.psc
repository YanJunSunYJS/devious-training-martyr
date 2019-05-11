Scriptname DTRSound extends Quest  

DTRActor Property DTActor Auto
DTRConfig Property DTConfig Auto

Int[] Property SoundObj Auto
Int Property SoundPointer  Auto

function playSoundSimple(actor acActor, sound effect, float volume = 1.0)
	if volume<=0.0 
		return
	endIf
	
	if volume>=1.0 
		volume = 1.0
	endIf

	SoundObj[soundPointer] = effect.play(acActor)
	Sound.SetInstanceVolume(SoundObj[soundPointer],volume)

	soundPointer = soundPointer + 1

	if soundPointer>60
		soundPointer = 0
	endif
	
endfunction

function playSound(int slot, sound effect, float volume = 1.0)

	if volume<=0.0 
		return
	endIf
	
	if volume>=1.0 
		volume = 1.0
	endIf
	
	;if DTConfig.addSounds == false
	;	return
	;endif

	int lastPointer = DTActor.npcs_lastSound[slot]
	lastPointer = lastPointer + 1
	if lastPointer > 9
		lastPointer = 1
	endif
	
	 DTActor.npcs_lastSound[slot] = lastPointer
		
	
	if lastPointer == 1
		DTActor.npc_sound1[slot] = effect.play(DTActor.npcs_ref[slot])
		Sound.SetInstanceVolume(DTActor.npc_sound1[slot],volume)
	endif
	
	if lastPointer == 2
		DTActor.npc_sound2[slot] = effect.play(DTActor.npcs_ref[slot])
		Sound.SetInstanceVolume(DTActor.npc_sound2[slot],volume)
	endif
	
	if lastPointer == 3
		DTActor.npc_sound3[slot] = effect.play(DTActor.npcs_ref[slot])
		Sound.SetInstanceVolume(DTActor.npc_sound3[slot],volume)
	endif

	if lastPointer == 4
		DTActor.npc_sound4[slot] = effect.play(DTActor.npcs_ref[slot])
		Sound.SetInstanceVolume(DTActor.npc_sound4[slot],volume)
	endif
	
	if lastPointer == 5
		DTActor.npc_sound5[slot] = effect.play(DTActor.npcs_ref[slot])
		Sound.SetInstanceVolume(DTActor.npc_sound5[slot],volume)
	endif

	if lastPointer == 6
		DTActor.npc_sound6[slot] = effect.play(DTActor.npcs_ref[slot])
		Sound.SetInstanceVolume(DTActor.npc_sound6[slot],volume)
	endif
	
	if lastPointer == 7
		DTActor.npc_sound7[slot] = effect.play(DTActor.npcs_ref[slot])
		Sound.SetInstanceVolume(DTActor.npc_sound7[slot],volume)
	endif
	
	if lastPointer == 8
		DTActor.npc_sound8[slot] = effect.play(DTActor.npcs_ref[slot])
		Sound.SetInstanceVolume(DTActor.npc_sound8[slot],volume)
	endif
	
	if lastPointer == 9
		DTActor.npc_sound9[slot] = effect.play(DTActor.npcs_ref[slot])
		Sound.SetInstanceVolume(DTActor.npc_sound9[slot],volume)
	endif
	
	
endfunction