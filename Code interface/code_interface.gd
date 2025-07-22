extends Control

var codeblock = preload("res://Code interface/code_block.tscn")
var codespace = preload("res://Code interface/code_space.tscn")
var id_to_add = 0
var grabed = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if not event.pressed:
			for i in get_children():
				if i.name == "grab_code":
					i.queue_free()
					drop_code()
					grabed = false

func _ready() -> void:
	CodeGlobal.grabcode.connect(grab_code)
	CodeGlobal.codeColided.connect(code_colided)
	CodeGlobal.codeUnColided.connect(code_uncolided)
	CodeGlobal.coderemove.connect(code_remove)
	
	for i in range(5):
		var space = codespace.instantiate()
		space.index = i
		$HBoxContainer/terminal/ScrollContainer/VBoxContainer.add_child(space)

func _process(delta: float) -> void:
	for i in get_children():
		if i.name == "grab_code":
			var mousepos = get_global_mouse_position()
			i.position.x = mousepos.x - 75
			i.position.y = mousepos.y - 50

func _on_button_pressed() -> void:
	var code = codeblock.instantiate()
	code.small = true
	code.custom_minimum_size = Vector2(0.0, 20.0)
	code.ID = id_to_add
	id_to_add += 1
	$"HBoxContainer/code bag/ScrollContainer/VBoxContainer".add_child(code)

func grab_code():
	if grabed: return
	var code = codeblock.instantiate()
	code.name = "grab_code"
	code.small = true
	code.custom_minimum_size = Vector2(0.0, 20.0)
	code.visible = false
	code.ID = -1
	add_child(code)
	grabed = true

func drop_code():
	var code = codeblock.instantiate()
	code.position = Vector2(0 ,0)
	code.collision_disabled = true
	$HBoxContainer/terminal/ScrollContainer/VBoxContainer.get_child(CodeGlobal.current_space_index).add_child(code)

func code_colided(index : int):
	for i in $HBoxContainer/terminal/ScrollContainer/VBoxContainer.get_children():
		i.collision_disabled = true
	$HBoxContainer/terminal/ScrollContainer/VBoxContainer.get_child(index).collision_disabled = false

func code_uncolided():
	for i in $HBoxContainer/terminal/ScrollContainer/VBoxContainer.get_children():
		i.collision_disabled = false

func code_remove(index : int):
	if $HBoxContainer/terminal/ScrollContainer/VBoxContainer.get_child(index).get_child_count() <= 2: return
	$HBoxContainer/terminal/ScrollContainer/VBoxContainer.get_child(index).get_child(2).queue_free()
	print($HBoxContainer/terminal/ScrollContainer/VBoxContainer.get_child(index).get_child_count())
