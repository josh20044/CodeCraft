extends State
class_name player_idle

func Enter():
	$"../../CodeCraftMainMC/AnimationTree".set("parameters/Transition/transition_request", "idle")
	

func Exit():
	pass

func Update(_delta: float):
	var input_dir := Input.get_vector("a", "d", "w", "s")
	if input_dir[0] != 0 or input_dir[1] != 0:
		Transitioned.emit(self, "walk")
	if Input.is_action_just_pressed("e"):
		Transitioned.emit(self, "pick")
		print("pick")

func Physics_Update(_delta: float):
	pass
