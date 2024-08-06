extends Node

func _get_randome_item():
	var possible_items = [
		_create_axe,
		_create_hammer,
		_create_bow,
		_create_ring,
		_create_amulet,
		_create_armor
	]
	return possible_items[randi() % possible_items.size()].call()

func _create_axe(rand = true):
	var item = Item.new("Axe", preload("res://assets/images/Axe.png"), "Weapon")
	item._set_dmg(10, 'Slashing')
	if rand:
		item._rand()
	return item

func _create_hammer(rand = true):
	var item = Item.new("Hammer", preload("res://assets/images/Hammer.png"), "Weapon")
	item._set_dmg(10, 'Bashing')
	if rand:
		item._rand()
	return item

func _create_bow(rand = true):
	var item = Item.new("Bow", preload("res://assets/images/Bow.png"), "Weapon")
	item._set_dmg(8, "Piercing")
	if rand:
		item._rand()
	return item

func _create_ring(rand = true):
	var item = Item.new("Ring", preload("res://assets/images/Ring.png"), "Trinket")
	if rand:
		item._rand()
	return item

func _create_amulet(rand = true):
	var item = Item.new("Amulet", preload("res://assets/images/Amulet.png"), "Trinket")
	if rand:
		item._rand()
	return item


func _create_armor(rand = true):
	var item = Item.new("Armor", preload("res://assets/images/Armor.png"), "Armor")
	item._set_armour(5, 5, 5, 0, 0, 0)
	if rand:
		item._rand()
	return item
