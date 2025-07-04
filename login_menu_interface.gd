extends Control

var iCanSeeYourPassSir = false

var icon_close = preload("res://Icons/eyehidden.png")
var icon_open = preload("res://Icons/eye.png")

func _ready() -> void:
	Firebase.Auth.login_succeeded.connect(on_login_succeeded)
	Firebase.Auth.signup_succeeded.connect(on_signup_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	Firebase.Auth.signup_failed.connect(on_signup_failed)

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

# firebase

func on_login_succeeded(auth):
	print("Login success!")
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


func _on_login_button_pressed() -> void:
	var email = $Panel/VBoxContainer/EmailTextBox.text
	var password = $Panel/VBoxContainer/PasswordTextBox.text
	Firebase.Auth.login_with_email_and_password(email, password)


func _on_google_sign_in_button_pressed() -> void:
	var provider : AuthProvider = Firebase.Auth.get_GoogleProvider()
	Firebase.Auth.get_auth_localhost(provider, 8060)
