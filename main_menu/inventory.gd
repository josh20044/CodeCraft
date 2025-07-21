extends Control

var selected_index = -1

func _ready() -> void:
	update_cells()

func _process(delta: float) -> void:
	pass

func _on_return_btn_pressed() -> void:
	UiSignals.inv_close.emit()

func initialize():
	var inventory_index = 0
	for i in $Panel/Slots/Storage.get_children():
		if i is Button:
			inventory_index += 1

func update_cells():
	var button_index = 0
	var label_index = 0
	for i in $Panel/Slots/Storage.get_children():
		if i is Button:
			if PlayerGlobal.inventory_cell[button_index] != -1:
				i.text = PlayerGlobal.Inventory[button_index].NAME
			button_index += 1
		if i is Label:
			if PlayerGlobal.inventory_cell[label_index] != -1:
				i.text = str(PlayerGlobal.Inventory[label_index].AMOUNT)
			label_index += 1

	var pre_index = 0
	for i in $Panel/Slots/Storage.get_children():
		if i is Button:
			if i.is_connected("pressed", cell_pressed.bind(pre_index)):
				i.disconnect("pressed", cell_pressed.bind(pre_index))
			i.connect("pressed", cell_pressed.bind(pre_index))
			pre_index += 1

func cell_pressed(index : int):
	if PlayerGlobal.inventory_cell[index] == -1 : 
		selected_index = -1
		return
	$Panel/Item_info/Item_name.text = PlayerGlobal.Inventory[index].NAME
	$Panel/Item_info/Curr_stored/Curr_stored_val.text = str(PlayerGlobal.Inventory[index].AMOUNT)
	selected_index = index
func _on_wood_pressed() -> void:
	PlayerGlobal.inventory_insert_item(PlayerGlobal.Items["wood"], 1)
	update_cells()

func _on_coal_pressed() -> void:
	PlayerGlobal.inventory_insert_item(PlayerGlobal.Items["coal"], 1)
	update_cells()

func _on_iron_pressed() -> void:
	PlayerGlobal.inventory_insert_item(PlayerGlobal.Items["raw_iron"], 1)
	update_cells()

func reset_cell():
	$Panel/Item_info/Item_name.text = ""
	$Panel/Item_info/Curr_stored/Curr_stored_val.text = ""
	for i in $Panel/Slots/Storage.get_children():
		i.text = ""
	PlayerGlobal.reset_inventory_values()

func _on_discard_btn_pressed() -> void:
	if selected_index == -1: return
	PlayerGlobal.inventory_delete_item(selected_index)
	reset_cell()
	update_cells()
