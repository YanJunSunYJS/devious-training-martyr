Scriptname DTRScriptEffect extends activemagiceffect  


DTRMain Property DTMain Auto
DTRActor Property DTActor Auto
DTRStorage Property DTStorage Auto
DTRConfig Property DTConfig Auto 

Int Slot
Bool Enabled
Bool waitForProcess 

zadLibs Property libs Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)


	Slot = DTActor.isRegistered(akTarget)
	
	if Slot == -1	
		self.Dispel()
	endIf
	
;	Terminate = False;
	;acActor = akTarget
	
	RegisterForSingleUpdate(5.0)
	Enabled = true
endEvent

Event OnEffectFinish(Actor acActor, Actor akCaster)
	Enabled = false
endEvent

Event OnHit(ObjectReference akAggressor, Form akSource, Projectile akProjectile, bool abPowerAttack, bool abSneakAttack, bool abBashAttack, bool abHitBlocked)
	Utility.wait(0.5)
	DTMain.grabAdditionalStats()
endEvent