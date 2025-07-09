extends LineEdit


func _ready() -> void:
	text_changed.connect(_on_text_changed)
	
func _on_text_changed(new_text: String) -> void:
	var caret_col := caret_column
	var filtered_text := ""
	for i in range(new_text.length()):
		var c := new_text[i]
		if c.is_valid_int():
			filtered_text += c
		else:
			if i < caret_col:
				caret_col -= 1
	text = filtered_text
	caret_column = caret_col
