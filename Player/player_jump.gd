extends State
class_name player_jump

func Enter():
	$"../../CodeCraftMainMC/AnimationPlayer".play_section("Jump", 0.5, 0.8)

func Exit():
	pass

func Update(_delta: float):
	if Input.is_action_just_released("shift left"):
		Transitioned.emit(self, "walk")
		

func Physics_Update(_delta: float):
	pass
