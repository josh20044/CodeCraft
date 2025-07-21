extends State
class_name player_fall

func Enter():
	$"../../CodeCraftMainMC/AnimationPlayer".play("Running")

func Exit():
	pass

func Update(_delta: float):
	if Input.is_action_just_released("shift left"):
		Transitioned.emit(self, "walk")
		

func Physics_Update(_delta: float):
	pass
