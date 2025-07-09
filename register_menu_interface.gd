extends Control

var iCanSeeYourPasswordSir = false
var iCanSeeYourConfirmPasswordSir = false

var icon_close = preload("res://Icons/eyehidden.png")
var icon_open = preload("res://Icons/eye.png")

var thread_send : Thread

func _ready() -> void:
	thread_send = Thread.new()
	
	Firebase.Auth.login_succeeded.connect(on_login_succeeded)
	Firebase.Auth.signup_succeeded.connect(on_signup_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	Firebase.Auth.signup_failed.connect(on_signup_failed)

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


func on_login_succeeded(auth):
	#print(auth)
	#$StateLabel.text = "Login success!"
	Firebase.Auth.save_auth(auth)
	get_tree().change_scene_to_file("res://Game.tscn")
	
func on_signup_succeeded(auth):
	#print(auth)
	#$StateLabel.text = "Sign up success!"
	Firebase.Auth.save_auth(auth)
	get_tree().change_scene_to_file("res://Game.tscn")
	
func on_login_failed(error_code, message):
	print(error_code)
	print(message)
	#$StateLabel.text = "Login failed. Error: %s" % message
	
func on_signup_failed(error_code, message):
	print(error_code)
	print(message)
	#$StateLabel.text = "Sign up failed. Error: %s" % message

func _on_confirm_button_pressed() -> void:
	var email = $Panel/VBoxContainer/EmailTextBox.text
	var password = $Panel/VBoxContainer/PasswordBox.text
	Firebase.Auth.signup_with_email_and_password(email, password)


func _on_send_v_code_button_pressed() -> void:
	if not validate_input(): return
	thread_send = Thread.new()
	thread_send.start(send_code.bind($Panel/VBoxContainer/EmailTextBox.text))

func send_code(email: String):
	var code = Tool.generate_code(6)
	var receiver_email = email
	Tool.Send_email(receiver_email, code)

func validate_input() -> bool:
	if $Panel/VBoxContainer/EmailTextBox.text == "":
		return false
	return true

func _exit_tree() -> void:
	thread_send.wait_to_finish()
