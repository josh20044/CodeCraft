extends Control

var small = false
var ID = 0
var amount = 0
var collision_disabled = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Area2D/CollisionShape2D.disabled = collision_disabled


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if small:
		await get_tree().process_frame
		scale = Vector2(0.5, 0.5)
		if name == "grab_code":
			modulate.a = 0.5
			position.y -= 1
		if not visible:
			visible = true

func _on_panel_mouse_entered() -> void:
	#print(ID)
	pass

func _on_panel_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			CodeGlobal.grabcode.emit()
