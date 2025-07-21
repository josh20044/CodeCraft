extends State
class_name player_walk

func Enter():
	$"../../CodeCraftMainMC/AnimationTree".set("parameters/Transition/transition_request", "walk")

func Exit():
	pass

func Update(_delta: float):
	var input_dir := Input.get_vector("a", "d", "w", "s")
	if input_dir[0] == 0.0 and input_dir[1] == 0.0:
		Transitioned.emit(self, "idle")
	if Input.is_action_just_pressed("e"):
		Transitioned.emit(self, "pick")
	if Input.is_action_pressed("shift left"):
		Transitioned.emit(self, "run")
func Physics_Update(_delta: float):
	pass
