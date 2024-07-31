extends Node

signal inventory_update
signal inventory_description_update
var player = null
var inventory = {
	weapon = null,
	armor = null,
	trinket = null,
	bag = []
}
var selected_slot = null

func _ready():
	for i in 20:
		inventory.bag.append(null)
	inventory.weapon = _create_axe()
	inventory.bag[1] = _create_bow()

func _add_item():
	inventory_update.emit()

func _remove_item():
	inventory_update.emit()

func _create_axe():
	return Item.new("Axe", preload("res://assets/images/Axe.png"), "Weapon")

func _create_bow():
	return Item.new("Bow", preload("res://assets/images/Bow.png"), "Weapon")

func _switch_two_item_slots(slot1, slot2):
	var item1 = _get_item(slot1)
	var item2 = _get_item(slot2)
	_put_item_into_slot(slot1, item2)
	_put_item_into_slot(slot2, item1)

func _put_item_into_slot(slot, item):
	if slot[0] != "bag":
		inventory[ slot[0] ] = item;
	else:
		inventory[ slot[0] ][ slot[1] ] = item;

func _get_item(slot : Array):
	if slot[0] != "bag":
		return inventory[ slot[0] ];
	else:
		return inventory[ slot[0] ][ slot[1] ];

func _get_selected_slot():
	return _get_item(selected_slot)

