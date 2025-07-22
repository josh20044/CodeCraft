extends State
class_name player_code

func Enter():
	$"../../CodeCraftMainMC/AnimationTree".set("parameters/OneShot 3/request", AnimationNodeOneShot.ONE_SHOT_REQUEST_FIRE)
	$"../.."._cancel_movement = true
	
func Exit():
	pass

func Update(_delta: float):
	if !$"../../CodeCraftMainMC/AnimationTree".get("parameters/OneShot 3/active"):
		Transitioned.emit(self, "idle")
		$"../.."._cancel_movement = false
		

func Physics_Update(_delta: float):
	pass
