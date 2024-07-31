extends Node

signal inventory_update
signal inventory_description_update
var player = null
var max_inventory_size = 20
var inventory = {
	weapon = _create_axe(),
	armor = null,
	trinket = null,
	bag = [_create_axe()]
}
var selected_item = null

func _add_item():
	inventory_update.emit()

func _remove_item():
	inventory_update.emit()

func _create_axe():
	return Item.new("Axe", preload("res://assets/images/Axe.png"), "Weapon")
