extends Control

func _process(delta: float) -> void:
	var Health_Progress_Bar = $Skills/HealthBar
	var Xp_Progress_Bar = $Skills/XpBar
	var Health_Bar = Health_Progress_Bar.get_node("HealthPercent")
	var Xp_Bar = Xp_Progress_Bar.get_node("XpPercent")
	
	Health_Bar.text = str(int(Health_Progress_Bar.value)) + " / " + str(int(Health_Progress_Bar.max_value))
	Xp_Bar.text = str(int(Xp_Progress_Bar.value)) + " / " + str(int(Xp_Progress_Bar.max_value))
