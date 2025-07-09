extends Control

var iCanSeeYourPasswordSir = false
var iCanSeeYourConfirmPasswordSir = false

var icon_close = preload("res://Icons/eyehidden.png")
var icon_open = preload("res://Icons/eye.png")

var thread_send : Thread

var fname_valid
var mname_valid
var lname_valid
var uname_valid
var snum_valid
var email_valid

var user_info : Dictionary = {
	"fname": "",
	"mname": "",
	"lname": "",
	"snum": "",
	"uname": ""
}

var pass_valid = false
var con_pass = false
var pass_text = ""

var code_correct = false

var send_timer_start = false
var send_timer_duration = 10
var send_timer: float = send_timer_duration

var active_node

func _ready() -> void:
	thread_send = Thread.new()
	$http_real.request_completed.connect(_on_request_completed)
	Firebase.Auth.login_succeeded.connect(on_login_succeeded)
	Firebase.Auth.signup_succeeded.connect(on_signup_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	Firebase.Auth.signup_failed.connect(on_signup_failed)
	
	fname_valid = false
	mname_valid = false
	lname_valid = false
	snum_valid = false
	uname_valid = false
	email_valid = false

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

	# send timer code
	
	if send_timer_start:
		send_timer -= delta
		$Panel/VBoxContainer/HBoxContainer/SendVCodeButton.text = str(int(send_timer))
		if send_timer <= 0:
			send_timer = send_timer_duration
			send_timer_start = false
			$Panel/VBoxContainer/HBoxContainer/SendVCodeButton.disabled = false
			$Panel/VBoxContainer/HBoxContainer/SendVCodeButton.text = "SEND"
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
	print("Login success!")
	Firebase.Auth.save_auth(auth)

func on_signup_succeeded(auth):
	#print(auth)
	#$StateLabel.text = "Sign up success!"
	print("Sign up success!")
	Firebase.Auth.save_auth(auth)
	Tool.userID = Firebase.Auth.auth.localid
	send_data()
	print(user_info)
	UiSignals.signup_success = true

func on_login_failed(error_code, message):
	print(error_code)
	print(message)
	Tool.spawn_modal(self, message)
	#$StateLabel.text = "Login failed. Error: %s" % message

func on_signup_failed(error_code, message):
	print(error_code)
	print("Sign up failed. Error: %s" % message)
	Tool.spawn_modal(self, message)
	#$StateLabel.text = "Sign up failed. Error: %s" % message

func _on_confirm_button_pressed() -> void:
	if not validate_input(): return
	var email = $Panel/VBoxContainer/EmailTextBox.text
	var password = $Panel/VBoxContainer/PasswordBox.text
	Firebase.Auth.signup_with_email_and_password(email, password)

func _on_send_v_code_button_pressed() -> void:
	if not send_anim_error(): return
	thread_send = Thread.new()
	thread_send.start(send_code.bind($Panel/VBoxContainer/EmailTextBox.text))
	$Panel/VBoxContainer/HBoxContainer/SendVCodeButton.disabled = true
	send_timer_start = true
	
func send_code(email: String):
	var code = Tool.generate_code(6)
	var receiver_email = email
	Tool.Send_email(receiver_email, code)

func validate_input() -> bool:
	
	fname_valid = false
	mname_valid = false
	lname_valid = false
	snum_valid = false
	uname_valid = false
	email_valid = false
	
	validate_text()
	if fname_valid and mname_valid and lname_valid and snum_valid and uname_valid and code_correct and email_valid and pass_valid and con_pass:
		return true
	return false

func validate_text():
	if $Panel/FNameTextBox.text != "":
		fname_valid = true
		user_info["fname"] = $Panel/FNameTextBox.text
	if $Panel/MNameTextBox.text != "":
		mname_valid = true
		user_info["mname"] = $Panel/MNameTextBox.text
	if $Panel/LNameTextBox.text != "":
		lname_valid = true
		user_info["lname"] = $Panel/LNameTextBox.text
	if $Panel/UsernameTextBox.text != "":
		uname_valid = true
		user_info["uname"] = $Panel/UsernameTextBox.text
	if $Panel/SNumberTextBox.text.length() == 10:
		snum_valid = true
		user_info["snum"] = $Panel/SNumberTextBox.text
	if $Panel/VBoxContainer/EmailTextBox.text != "" and $Panel/VBoxContainer/EmailTextBox.text.contains("@gmail.com"):
		email_valid = true
	anim_error()

func send_anim_error() -> bool:
	
	if $Panel/VBoxContainer/EmailTextBox.text != "" and $Panel/VBoxContainer/EmailTextBox.text.contains("@gmail.com"):
		email_valid = true
	
	if not email_valid:
		var node = $Panel/VBoxContainer/EmailTextBox
		var tween = get_tree().create_tween()
		node.modulate = Color.RED
		tween.tween_property(node, "modulate", Color.WHITE, 0.5)
		return false
	return true
func anim_error():
	if not fname_valid:
		var node = $Panel/FNameTextBox
		var tween = get_tree().create_tween()
		node.modulate = Color.RED
		tween.tween_property(node, "modulate", Color.WHITE, 0.5)
	if not mname_valid:
		var node = $Panel/MNameTextBox
		var tween = get_tree().create_tween()
		node.modulate = Color.RED
		tween.tween_property(node, "modulate", Color.WHITE, 0.5)
	if not lname_valid:
		var node = $Panel/LNameTextBox
		var tween = get_tree().create_tween()
		node.modulate = Color.RED
		tween.tween_property(node, "modulate", Color.WHITE, 0.5)
	if not snum_valid:
		var node = $Panel/SNumberTextBox
		var tween = get_tree().create_tween()
		node.modulate = Color.RED
		tween.tween_property(node, "modulate", Color.WHITE, 0.5)
	if not uname_valid:
		var node = $Panel/UsernameTextBox
		var tween = get_tree().create_tween()
		node.modulate = Color.RED
		tween.tween_property(node, "modulate", Color.WHITE, 0.5)
	if not email_valid:
		var node = $Panel/VBoxContainer/EmailTextBox
		var tween = get_tree().create_tween()
		node.modulate = Color.RED
		tween.tween_property(node, "modulate", Color.WHITE, 0.5)
	if not code_correct:
		var node = $Panel/VBoxContainer/HBoxContainer/VCodeTextBox
		var tween = get_tree().create_tween()
		node.modulate = Color.RED
		tween.tween_property(node, "modulate", Color.WHITE, 0.5)
	if not pass_valid:
		var node = $Panel/VBoxContainer/PasswordBox
		var tween = get_tree().create_tween()
		node.modulate = Color.RED
		tween.tween_property(node, "modulate", Color.WHITE, 0.5)
	if not con_pass:
		var node = $Panel/ConfirmPasswordBox
		var tween = get_tree().create_tween()
		node.modulate = Color.RED
		tween.tween_property(node, "modulate", Color.WHITE, 0.5)
func _exit_tree() -> void:
	thread_send.wait_to_finish()

func _on_username_text_box_text_changed(new_text: String) -> void:
	var old_caret_position: int = $Panel/UsernameTextBox.caret_column
	var word: String = ""
	var regex: RegEx = RegEx.new()
	regex.compile("[A-Za-z0-9 ]")
	var diff: int = regex.search_all(new_text).size() - new_text.length()
	for valid_character in regex.search_all(new_text):
		word += valid_character.get_string()
	$Panel/UsernameTextBox.set_text(word)
	$Panel/UsernameTextBox.caret_column = old_caret_position + diff

func _on_v_code_text_box_text_changed(new_text: String) -> void:
	var caret_col = $Panel/VBoxContainer/HBoxContainer/VCodeTextBox.caret_column
	var filtered_text := ""
	for i in range(new_text.length()):
		var c := new_text[i]
		if c.is_valid_int():
			filtered_text += c
		else:
			if i < caret_col:
				caret_col -= 1
	$Panel/VBoxContainer/HBoxContainer/VCodeTextBox.text = filtered_text
	$Panel/VBoxContainer/HBoxContainer/VCodeTextBox.caret_column = caret_col
	
	if $Panel/VBoxContainer/HBoxContainer/VCodeTextBox.text == Tool.activeCode:
		$Panel/VBoxContainer/HBoxContainer/VCodeTextBox.modulate = Color.LIGHT_GREEN
		$Panel/VBoxContainer/HBoxContainer/SendVCodeButton.disabled = true
		code_correct = true
	else:
		$Panel/VBoxContainer/HBoxContainer/VCodeTextBox.modulate = Color.INDIAN_RED
		$Panel/VBoxContainer/HBoxContainer/SendVCodeButton.disabled = false
		code_correct = false

func _on_password_box_text_changed(new_text: String) -> void:
	if new_text.length() < 8:
		$Panel/VBoxContainer/PasswordBox.modulate = Color.INDIAN_RED
		pass_valid = false
	if new_text.length() > 7 and new_text.length() < 13:
		$Panel/VBoxContainer/PasswordBox.modulate = Color.LIGHT_GREEN
		pass_valid = true
		pass_text = new_text

func _on_confirm_password_box_text_changed(new_text: String) -> void:
	if pass_text == new_text:
		$Panel/ConfirmPasswordBox.modulate = Color.LIGHT_GREEN
		con_pass = true
	else:
		$Panel/ConfirmPasswordBox.modulate = Color.INDIAN_RED
		con_pass = false

const host : String = "https://codecraft-database-default-rtdb.asia-southeast1.firebasedatabase.app/"
func send_data() -> void:
	var data = JSON.stringify(user_info)
	print(Tool.userID)
	var url = host + ("user/%s.json" % Tool.userID)
	$http_real.request(url, [], HTTPClient.METHOD_PUT, data)

func _on_request_completed( result: int, response_code: int, _headers: PackedStringArray, _body: PackedByteArray) -> void:
	if result == $http_real.RESULT_SUCCESS:
		UiSignals.open_login.emit()
		UiSignals.close_register.emit()


func _on_button_pressed() -> void:
	send_data()
