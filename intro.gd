extends Node2D

func _ready() -> void:
	$AnimationPlayer.play("DriftZ")

func _process(delta: float) -> void:
	pass



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "DriftZ":
		get_tree().change_scene_to_file("res://main_menu_screen.tscn")
