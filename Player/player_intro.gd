extends State
class_name player_intro

func Enter():
	$"../../CodeCraftMainMC/AnimationTree".set("parameters/OneShot 2/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	$"../../CodeCraftMainMC/AnimationTree".set("parameters/TimeScale/scale", 3)
	$"../.."._cancel_movement = true
	
func Exit():
	pass

func Update(_delta: float):
	if !$"../../CodeCraftMainMC/AnimationTree".get("parameters/OneShot 2/active"):
		$"../../CodeCraftMainMC/AnimationTree".set("parameters/TimeScale/scale", 1)
		Transitioned.emit(self, "idle")
		$"../.."._cancel_movement = false
		

func Physics_Update(_delta: float):
	pass
