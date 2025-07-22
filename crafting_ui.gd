extends Control

func _ready() -> void:
	var popup = get_node("Panel2/Panel2/Button2/MenuButton").get_popup()
	popup.clear()
	popup.add_item("Option 1")
	popup.add_item("Option 2")
	
	for i in range(popup.get_item_count()):
		popup.set_item_text_alignment(i, HORIZONTAL_ALIGNMENT_CENTER)
