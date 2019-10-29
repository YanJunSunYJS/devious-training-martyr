Scriptname DTRUpdate extends Quest  

;DTRStorage Property DTStorage Auto
DTRConfig Property DTConfig Auto
DTRTools Property DTTools Auto
DTRActor Property DTActor Auto
DTRMain Property DTMain Auto
DTRSound Property DTSound Auto
DTRStorage Property DTStorage Auto

SexLabFramework Property SexLab Auto

Function Update(Float version)
	DTTools.log("Update - Check for updates...",2, true)
	updateOnEveryLoad()
	if version <= DTConfig.lastVersion
		DTTools.log("Update - Not update requied",2, true)
		return
	endIf
	DTTools.log("Update DTR - version:"+version+" START", 2, true)
	updateAlwyas()	
	if DTConfig.lastVersion < 0.1
		DTTools.log("Run module updateTo01",2, true)
		updateTo01()
	endIf	

	if DTConfig.lastVersion < 1.1
		DTTools.log("Run module updateTo1.1",2, true)
		updateTo11()
	endIf
	
	if DTConfig.lastVersion < 1.2
		DTTools.log("Run module updateTo1.2",2, true)
		updateTo12()
	endIf
	
	if DTConfig.lastVersion < 1.3
		DTTools.log("Run module updateTo1.3",2, true)
		updateTo13()
	endIf

	if DTConfig.lastVersion < 1.5
		DTTools.log("Run module updateTo1.5",2, true)
		updateTo15()
	endIf

	if DTConfig.lastVersion < 1.6
		DTTools.log("Run module updateTo1.6",2, true)
		updateTo16()
	endIf

	DTTools.log("Update DTR - version:"+version+" FINISH",2, true)
	DTMain.grabAdditionalStats();
	DTConfig.lastVersion = version
EndFunction


function updateTo16()	

endFunction

function updateTo15()	
	
endFunction

function updateTo13()	
	DTConfig.deviceColorIndex = 0
	int i = 0
	
	DTActor.npcs_chastitySlut = new int[32]
	while i < DTActor.getArrayCount()
		DTActor.npcs_chastitySlut[i] = 0
		i+=1
	endwhile
endFunction

function updateTo12()
	DTSound.SoundObj = new Int[64]
	DTSound.SoundPointer = 0
	
EndFunction
function updateTo11()
	DTConfig.scanerRange  = 1000
	DTActor.npc_sound1 = new int[32]
	DTActor.npc_sound2 = new int[32]
	DTActor.npc_sound3 = new int[32]
	DTActor.npc_sound4 = new int[32]
	DTActor.npc_sound5 = new int[32]
	DTActor.npc_sound6 = new int[32]
	DTActor.npc_sound7 = new int[32]
	DTActor.npc_sound8 = new int[32]
	DTActor.npc_sound9 = new int[32]
	DTActor.npcs_lastSound = new int[32]
	int i = 0
	while i < DTActor.getArrayCount()
		DTActor.npc_sound1[i] = 0
		DTActor.npc_sound2[i] = 0
		DTActor.npc_sound3[i] = 0
		DTActor.npc_sound4[i] = 0
		DTActor.npc_sound5[i] = 0
		DTActor.npc_sound6[i] = 0
		DTActor.npc_sound7[i] = 0
		DTActor.npc_sound8[i] = 0
		DTActor.npc_sound9[i] = 0
		DTActor.npcs_lastSound[i] = 0
		
		i+=1
	endwhile
endFunction

function updateTo01()
	updateOnEveryLoad()	
	DTConfig.scanerRange = 1000;
	DTActor.npcs_ref       = new actor[32]
	DTActor.npcs_ponySlut  = new int[32]
	DTActor.npcs_blindSlut = new int[32]
	DTActor.npcs_painSlut  = new int[32]
	DTConfig.mcmWorking    = false
	int i = 0
	while i < DTActor.getArrayCount()
		DTActor.npcs_ref[i] = None
		DTActor.npcs_ponySlut[i]  = 0
		DTActor.npcs_blindSlut[i] = 0
		DTActor.npcs_painSlut[i]  = 0
		i+=1
	endwhile

endFunction

function updateAlwyas()

	DTConfig.deviceInventoryBlindfold = new Armor[4]
	DTConfig.deviceScriptBlindfold = new Armor[4]
	DTConfig.deviceInventoryArmbinder = new Armor[4]
	DTConfig.deviceScriptArmbinder = new Armor[4]
	DTConfig.deviceInventoryPonyBoots = new Armor[4]
	DTConfig.deviceScriptPonyBoots = new Armor[4]
	DTConfig.deviceInventoryPonyGag = new Armor[4]
	DTConfig.deviceScriptPonyGag = new Armor[4]

	DTConfig.deviceInventoryBlindfold[0] = DTStorage.zadx_WTEEBlindfoldInventory
	DTConfig.deviceInventoryBlindfold[1] = DTStorage.zadx_WTLblindfoldInventory
	DTConfig.deviceInventoryBlindfold[2] = DTStorage.zadx_EboniteBlindfoldInventory
	DTConfig.deviceInventoryBlindfold[3] = DTStorage.zad_blindfoldInventory
	
	DTConfig.deviceScriptBlindfold[0] = DTStorage.zadx_WTEblindfoldBlocking_scriptInstance
	DTConfig.deviceScriptBlindfold[1] = DTStorage.zadx_WTLblindfold_scriptInstance
	DTConfig.deviceScriptBlindfold[2] = DTStorage.zadx_EboniteBlindfold_scriptInstance
	DTConfig.deviceScriptBlindfold[3] = DTStorage.zad_blindfold01_scriptInstance
	
	DTConfig.deviceInventoryArmbinder[0] = DTStorage.zadx_WTEarmbinderInventory
	DTConfig.deviceInventoryArmbinder[1] = DTStorage.zadx_WTLarmbinderInventory
	DTConfig.deviceInventoryArmbinder[2] = DTStorage.zadx_EboniteArmbinderInventory
	DTConfig.deviceInventoryArmbinder[3] = DTStorage.zad_armBinderInventory
	
	DTConfig.deviceScriptArmbinder[0] = DTStorage.zadx_WTEarmbinder_scriptInstance
	DTConfig.deviceScriptArmbinder[1] = DTStorage.zadx_WTLarmbinder_scriptInstance
	DTConfig.deviceScriptArmbinder[2] = DTStorage.zadx_EboniteArmbinder_scriptInstance
	DTConfig.deviceScriptArmbinder[3] = DTStorage.zad_armbinder01_scriptInstance
	
	DTConfig.deviceInventoryPonyBoots[0] = DTStorage.zadx_XinWTEbonitePonyBootsInventory
	DTConfig.deviceInventoryPonyBoots[1] = DTStorage.zadx_XinWTLPonyBootsInventory
	DTConfig.deviceInventoryPonyBoots[2] = DTStorage.zadx_XinEbonitePonyBootsInventory
	DTConfig.deviceInventoryPonyBoots[3] = DTStorage.zadx_XinPonyBootsInventory
	
	DTConfig.deviceScriptPonyBoots[0] = DTStorage.zadx_XinWTEbonitePonyBoot_scriptInstance
	DTConfig.deviceScriptPonyBoots[1] = DTStorage.zadx_XinWTLPonyBoot_scriptInstance
	DTConfig.deviceScriptPonyBoots[2] = DTStorage.zadx_XinEbonitePonyBoot_scriptInstance
	DTConfig.deviceScriptPonyBoots[3] = DTStorage.zadx_XinPonyBoot_scriptInstance
	
	DTConfig.deviceInventoryPonyGag[0] = DTStorage.zadx_dud_Pony_Harness_Blinders_White_Ebonite_Inventory
	DTConfig.deviceInventoryPonyGag[1] = DTStorage.zadx_dud_Pony_Harness_Blinders_White_Leather_Inventory
	DTConfig.deviceInventoryPonyGag[2] = DTStorage.zadx_dud_Pony_Harness_Blinders_Ebonite_BlackInventory
	DTConfig.deviceInventoryPonyGag[3] = DTStorage.zadx_dud_Pony_Harness_Blinders_Leather_BlackInventory
	
	DTConfig.deviceScriptPonyGag[0] = DTStorage.zadx_dud_Pony_Harness_Blinders_White_Ebonite_Rendered
	DTConfig.deviceScriptPonyGag[1] = DTStorage.zadx_dud_Pony_Harness_Blinders_White_Leather_Rendered
	DTConfig.deviceScriptPonyGag[2] = DTStorage.zadx_dud_Pony_Harness_Blinders_Ebonite_BlackRendered
	DTConfig.deviceScriptPonyGag[3] = DTStorage.zadx_dud_Pony_Harness_Blinders_Leather_BlackRendered

	DTConfig.DT_Boots = Game.GetFormFromFile(0x08023e6c, "DeviousTraining.esp") as Faction
	DTConfig.DT_Corset = Game.GetFormFromFile(0x08023e6d, "DeviousTraining.esp") as Faction
	DTConfig.DT_Harness = Game.GetFormFromFile(0x08023e6e, "DeviousTraining.esp") as Faction
	DTConfig.DT_Legscuffs = Game.GetFormFromFile(0x08023e6f, "DeviousTraining.esp") as Faction
	DTConfig.DT_Armscuffs = Game.GetFormFromFile(0x08023e70, "DeviousTraining.esp") as Faction
	DTConfig.DT_Gag = Game.GetFormFromFile(0x08023e71, "DeviousTraining.esp") as Faction
	DTConfig.DT_Collar = Game.GetFormFromFile(0x08023e72, "DeviousTraining.esp") as Faction
	DTConfig.DT_Chastitybelt = Game.GetFormFromFile(0x08023e73, "DeviousTraining.esp") as Faction
	DTConfig.DT_Chastitybra = Game.GetFormFromFile(0x08023e74, "DeviousTraining.esp") as Faction
	DTConfig.DT_Gloves = Game.GetFormFromFile(0x08023e75, "DeviousTraining.esp") as Faction
	DTConfig.DT_Armbinderyoke = Game.GetFormFromFile(0x08023e76, "DeviousTraining.esp") as Faction
	DTConfig.DT_Blindfold = Game.GetFormFromFile(0x08023e77, "DeviousTraining.esp") as Faction
	DTConfig.DT_AnalPlug = Game.GetFormFromFile(0x08026988, "DeviousTraining.esp") as Faction
	DTConfig.DT_VaginalPlug = Game.GetFormFromFile(0x08026989, "DeviousTraining.esp") as Faction

	DTConfig.slotMask = new Int[65]
	DTConfig.slotMask[30] = 0x00000001
	DTConfig.slotMask[31] = 0x00000002
	DTConfig.slotMask[32] = 0x00000004
	DTConfig.slotMask[33] = 0x00000008
	DTConfig.slotMask[34] = 0x00000010
	DTConfig.slotMask[35] = 0x00000020
	DTConfig.slotMask[36] = 0x00000040
	DTConfig.slotMask[37] = 0x00000080
	DTConfig.slotMask[38] = 0x00000100
	DTConfig.slotMask[39] = 0x00000200
	DTConfig.slotMask[40] = 0x00000400
	DTConfig.slotMask[41] = 0x00000800
	DTConfig.slotMask[42] = 0x00001000
	DTConfig.slotMask[43] = 0x00002000
	DTConfig.slotMask[44] = 0x00004000
	DTConfig.slotMask[45] = 0x00008000
	DTConfig.slotMask[46] = 0x00010000
	DTConfig.slotMask[47] = 0x00020000
	DTConfig.slotMask[48] = 0x00040000
	DTConfig.slotMask[49] = 0x00080000
	DTConfig.slotMask[50] = 0x00100000
	DTConfig.slotMask[51] = 0x00200000
	DTConfig.slotMask[52] = 0x00400000
	DTConfig.slotMask[53] = 0x00800000
	DTConfig.slotMask[54] = 0x01000000
	DTConfig.slotMask[55] = 0x02000000
	DTConfig.slotMask[56] = 0x04000000
	DTConfig.slotMask[57] = 0x08000000
	DTConfig.slotMask[58] = 0x10000000
	DTConfig.slotMask[59] = 0x20000000
	DTConfig.slotMask[60] = 0x40000000
	DTConfig.slotMask[61] = 0x80000000
	
	


	
	
endFunction

function updateOnEveryLoad()
;	DTConfig.EffectSpell = DTStorage.DTMEffects
	DTMain.grabActors()
	DTConfig.separateOrgasmPack = false
	if (Game.GetModbyName("SLSO.esp") != 255)
		DTConfig.separateOrgasmPack = true		
	endif
	DTConfig.playerRef = Game.GetPlayer()

endFunction