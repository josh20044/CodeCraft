extends Node

var interpreter_path = ProjectSettings.globalize_path("res://python_env/venv/Scripts/python.exe")
var email_script_path = ProjectSettings.globalize_path("user://email_script.py")
var output = []
var activeCode : String = "none"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func Send_email(receiver: String, code: String):
	var exit_code = OS.execute(interpreter_path, [email_script_path, receiver, code], output, false)
	print(output)

func generate_code(digit: int) -> String:
	var code = ""
	var rng = RandomNumberGenerator.new()
	var nums = ["0","1","2","3","4","5","6","7","8","9"]
	for i in range(digit):
		code = code + nums[rng.randi_range(0, nums.size()-1)]
	activeCode = code
	return code
