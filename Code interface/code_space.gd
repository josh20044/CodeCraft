extends Panel

var index = -1
var collision_disabled = false


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	$Area2D/CollisionShape2D.disabled = collision_disabled

func _on_area_2d_area_entered(area: Area2D) -> void:
	modulate.a = 0.5
	CodeGlobal.current_space_index = index
	CodeGlobal.codeColided.emit(index)
	
func _on_area_2d_area_exited(area: Area2D) -> void:
	modulate.a = 1.0
	CodeGlobal.codeUnColided.emit()

func _on_remove_pressed() -> void:
	CodeGlobal.coderemove.emit(index)
