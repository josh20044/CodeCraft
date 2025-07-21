extends Node3D

var chapter = preload("res://main_menu/Assessment.tscn")
var info = preload("res://main_menu/Info.tscn")
var skill = preload("res://main_menu/Skill_Tree.tscn")
var inventory = preload("res://main_menu/Inventory.tscn")
var task = preload("res://main_menu/Tasks.tscn")
var menu_ui = preload("res://menu_ui.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"main_ui/InGame UI/Label".text = "UID : " + Tool.userID
	
	UiSignals.chapter_open.connect(chapter_open)
	UiSignals.chapter_close.connect(chapter_close)
	
	UiSignals.info_open.connect(open_info)
	UiSignals.info_close.connect(close_info)
	
	UiSignals.skill_open.connect(open_skill)
	UiSignals.skill_close.connect(close_skill)
	
	UiSignals.inv_open.connect(open_inv)
	UiSignals.inv_close.connect(close_inv)
	
	UiSignals.task_open.connect(open_task)
	UiSignals.task_close.connect(close_task)

	UiSignals.open_menu.connect(open_menu)
	UiSignals.close_menu.connect(close_menu)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	


func _on_chapter_button_pressed() -> void:
	UiSignals.chapter_open.emit()

func chapter_open():
	$main_ui/ui.add_child(chapter.instantiate())
	var tween = get_tree().create_tween()
	tween.tween_property($main_ui/ui, "position:x", 0.0, 0.2)

func chapter_close():
	for i in $main_ui/ui.get_children():
		i.queue_free()
	var tween = get_tree().create_tween()
	tween.tween_property($main_ui/ui, "position:x", 1280.0, 0.2)
	
func open_info():
	$main_ui/ui.add_child(info.instantiate())
	var tween = get_tree().create_tween()
	tween.tween_property($main_ui/ui, "position:x", 0.0, 0.2)
	
func close_info():
	for i in $main_ui/ui.get_children():
		i.queue_free()
	var tween = get_tree().create_tween()
	tween.tween_property($main_ui/ui, "position:x", 1280.0, 0.2)

func open_skill():
	$main_ui/ui.add_child(skill.instantiate())
	var tween = get_tree().create_tween()
	tween.tween_property($main_ui/ui, "position:x", 0.0, 0.2)
	
func close_skill():
	for i in $main_ui/ui.get_children():
		i.queue_free()
	var tween = get_tree().create_tween()
	tween.tween_property($main_ui/ui, "position:x", 1280.0, 0.2)
	
func _on_index_button_pressed() -> void:
	UiSignals.skill_open.emit()

func open_inv():
	$main_ui/ui.add_child(inventory.instantiate())
	var tween = get_tree().create_tween()
	tween.tween_property($main_ui/ui, "position:x", 0.0, 0.2)
	
func close_inv():
	for i in $main_ui/ui.get_children():
		i.queue_free()
	var tween = get_tree().create_tween()
	tween.tween_property($main_ui/ui, "position:x", 1280.0, 0.2)

func _on_inventory_button_pressed() -> void:
	UiSignals.inv_open.emit()

func open_task():
	$main_ui/ui.add_child(task.instantiate())
	var tween = get_tree().create_tween()
	tween.tween_property($main_ui/ui, "position:x", 0.0, 0.2)

func close_task():
	for i in $main_ui/ui.get_children():
		i.queue_free()
	var tween = get_tree().create_tween()
	tween.tween_property($main_ui/ui, "position:x", 1280.0, 0.2)

func _on_task_button_pressed() -> void:
	UiSignals.task_open.emit()

func open_menu():
	$main_ui/ui.add_child(menu_ui.instantiate())
	var tween = get_tree().create_tween()
	tween.tween_property($main_ui/ui, "position:x", 0.0, 0.2)

func close_menu():
	for i in $main_ui/ui.get_children():
		i.queue_free()
	var tween = get_tree().create_tween()
	tween.tween_property($main_ui/ui, "position:x", 1280.0, 0.2)

func _on_menu_button_pressed() -> void:
	UiSignals.open_menu.emit()
