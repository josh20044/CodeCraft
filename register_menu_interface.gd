extends Control

var iCanSeeYourPasswordSir = false
var iCanSeeYourConfirmPasswordSir = false

var icon_close = preload("res://Icons/eyehidden.png")
var icon_open = preload("res://Icons/eye.png")

func _process(delta: float) -> void:
	if iCanSeeYourPasswordSir == true:
		$Panel/VBoxContainer/PasswordBox.secret = false
		$Panel/Password.icon = icon_close
	else:
		$Panel/VBoxContainer/PasswordBox.secret = true
		$Panel/Password.icon = icon_open
	
	if iCanSeeYourConfirmPasswordSir == true:
		$Panel/ConfirmPasswordBox.secret = false
		$Panel/ConfirmPassword.icon = icon_close
	else:
		$Panel/ConfirmPasswordBox.secret = true
		$Panel/ConfirmPassword.icon = icon_open




func _on_password_pressed() -> void:
	if iCanSeeYourPasswordSir == true:
		iCanSeeYourPasswordSir = false
	else:
		iCanSeeYourPasswordSir = true


func _on_confirm_password_pressed() -> void:
	if iCanSeeYourConfirmPasswordSir == true:
		iCanSeeYourConfirmPasswordSir = false
	else:
		iCanSeeYourConfirmPasswordSir = true


func _on_close_button_pressed() -> void:
	UiSignals.close_register.emit()
