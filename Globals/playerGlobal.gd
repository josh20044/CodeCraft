extends Node

var inventory_cell : Array[int] = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]

var Items : Dictionary = {
	"wood" : {
		NAME = "Wood",
		ID = 0,
		AMOUNT = 0,
		INDEX = -1
	},
	"raw_iron" : {
		NAME = "Raw iron",
		ID = 1,
		AMOUNT = 0,
		INDEX = -1
	},
	"coal" : {
		NAME = "Coal",
		ID = 2,
		AMOUNT = 0,
		INDEX = -1
	}
}

var Inventory : Dictionary = {}

func _ready() -> void:
	inventory_insert_item(Items["wood"], 5)

func _process(delta: float) -> void:
	pass

func is_inventory_full() -> bool:
	return inventory_cell.all(func(e): return e != -1)

func is_inventory_empty() -> bool:
	return inventory_cell.all(func(e): return e == -1)

func inventory_insert_item(item : Dictionary, amount : int):
	if is_inventory_full(): return
	for i in range(inventory_cell.size()):
		if inventory_cell[i] == item.ID:
			Inventory[i].AMOUNT += amount
			return
		elif inventory_cell[i] == -1:
			inventory_cell[i] = item.ID
			item.AMOUNT = amount
			item.INDEX = i
			Inventory[i] = item
			return

func inventory_delete_item(index : int):
	inventory_cell[index] = -1
	Inventory.erase(index)

func reset_inventory_values():
	var new_inventory : Dictionary
	var new_inventory_cell : Array[int] = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
	
	var inv_index = 0
	var cell_index = 0
	
	for i in range(inventory_cell.size()):
		if inventory_cell[i] != -1:
			new_inventory_cell[cell_index] = inventory_cell[i]
			cell_index += 1
	
	for i in Inventory:
		new_inventory[inv_index] = Inventory[i]
		inv_index += 1
	
	inventory_cell.clear()
	Inventory.clear()
	
	inventory_cell = new_inventory_cell
	Inventory = new_inventory
		
	
	
