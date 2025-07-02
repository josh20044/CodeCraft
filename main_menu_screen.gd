extends Node2D

var menu_ui = preload("res://menu_ui.tscn")
var login_ui = preload("res://login_menu_interface.tscn")
var register_ui = preload("res://register_menu_interface.tscn")
var forgot_ui = preload("res://forgot_password_interface.tscn")


var is_login_ui_open = false 
var is_register_open = false
var is_forgot_open = false

func _ready() -> void:
	UiSignals.open_menu.connect(open_menu)
	UiSignals.close_menu.connect(close_menu)
	UiSignals.open_login.connect(open_login)
	UiSignals.close_login.connect(close_login)
	UiSignals.open_register.connect(open_register)
	UiSignals.close_register.connect(close_register)
	UiSignals.open_forgot.connect(open_forgot)
	UiSignals.close_forgot.connect(close_forgot)
func _process(delta: float) -> void:
	$AnimationPlayer.play("StartFlicker")


func _on_menu_pressed() -> void:
	UiSignals.open_menu.emit()

func open_menu():
	$CanvasLayer/Control/ui.add_child(menu_ui.instantiate())
func close_menu():
	for i in $CanvasLayer/Control/ui.get_children():
		i.queue_free()

func _on__start_game__gui_input(event: InputEvent) -> void:
	if event.as_text() == "Left Mouse Button" and not is_login_ui_open:
		open_login()

func open_login():
	$CanvasLayer/Control/ui.add_child(login_ui.instantiate())
	is_login_ui_open = true

func close_login():
	for i in $CanvasLayer/Control/ui.get_children():
		i.queue_free()
	is_login_ui_open = false

func open_register():
	if not is_register_open:
		close_login()
		$CanvasLayer/Control/ui.add_child(register_ui.instantiate())
		is_register_open = true

func close_register():
	for i in $CanvasLayer/Control/ui.get_children():
		i.queue_free()
	open_login()
	is_register_open = false

func open_forgot():
	if not is_forgot_open:
		close_login()
		$CanvasLayer/Control/ui.add_child(forgot_ui.instantiate())
		is_forgot_open = true

func close_forgot():
	for i in $CanvasLayer/Control/ui.get_children():
		i.queue_free()
	open_login()
	is_forgot_open = false
