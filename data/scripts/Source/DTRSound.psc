Scriptname DTRSound extends Quest  

DTRActor Property DTActor Auto
DTRConfig Property DTConfig Auto

function playSound(int slot, sound effect, float volume = 1.0)

	;if DTConfig.addSounds == false
	;	return
	;endif

	int lastPointer = DTActor.npcs_lastSound[slot]
	lastPointer = lastPointer + 1
	if lastPointer > 5
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
	
	
endfunction