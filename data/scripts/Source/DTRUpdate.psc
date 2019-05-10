Scriptname DTRUpdate extends Quest  

;DTRStorage Property DTStorage Auto
DTRConfig Property DTConfig Auto
DTRTools Property DTTools Auto
DTRActor Property DTActor Auto
DTRMain Property DTMain Auto


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
	
	DTTools.log("Update DTR - version:"+version+" FINISH",2, true)
	DTMain.grabAdditionalStats();
	DTConfig.lastVersion = version
EndFunction

function updateTo01()
	updateOnEveryLoad()	
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
endFunction