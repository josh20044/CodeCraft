extends State
class_name player_run

func Enter():
	$"../../CodeCraftMainMC/AnimationTree".set("parameters/Transition/transition_request", "run")

func Exit():
	pass

func Update(_delta: float):
	if Input.is_action_just_released("shift left"):
		Transitioned.emit(self, "walk")
		

func Physics_Update(_delta: float):
	pass
