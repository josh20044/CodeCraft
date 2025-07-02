extends Control

var iCanSeeYourPassSir = false

var icon_close = preload("res://Icons/eyehidden.png")
var icon_open = preload("res://Icons/eye.png")

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if iCanSeeYourPassSir == true:
		$Panel/VBoxContainer/PasswordTextBox.secret = false
		$Panel/Close_Open.icon = icon_close
	else:
		$Panel/VBoxContainer/PasswordTextBox.secret = true
		$Panel/Close_Open.icon = icon_open


func _on_close_open_pressed() -> void:
	if iCanSeeYourPassSir == true:
		iCanSeeYourPassSir = false
	else:
		iCanSeeYourPassSir = true


func _on_close_button_pressed() -> void:
	UiSignals.close_login.emit()


func _on_register_now_button_gui_input(event: InputEvent) -> void:
	if event.as_text() == "Left Mouse Button":
		UiSignals.open_register.emit()
		

func _on_forget_password_button_gui_input(event: InputEvent) -> void:
	if event.as_text() == "Left Mouse Button":
		UiSignals.open_forgot.emit()
