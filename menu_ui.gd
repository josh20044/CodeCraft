extends Control
var setting_ui = preload("res://settings_ui.tscn")
var keybind_ui = preload("res://keybind_ui.tscn")


var is_setting_open = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	UiSignals.open_keybind.connect(open_keybind)
	UiSignals.close_keybind.connect(close_keybind)
	UiSignals.open_setting.connect(open_setting)
	UiSignals.close_setting.connect(close_setting)
	open_setting()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_setting_pressed() -> void:
	close_keybind()
	open_setting()

func _on_close_button_pressed() -> void:
	UiSignals.close_menu.emit()

func open_setting():
	if not is_setting_open:
		$Panel/ScrollContainer.add_child(setting_ui.instantiate())
		is_setting_open = true
		print("hello")

func close_setting():
	for i in $Panel/ScrollContainer.get_children():
		i.queue_free()
	is_setting_open = false

func open_keybind():
	close_setting()
	$Panel/ScrollContainer.add_child(keybind_ui.instantiate())
	
func close_keybind():
	for i in $Panel/ScrollContainer.get_children():
		i.queue_free()
	is_setting_open = false
