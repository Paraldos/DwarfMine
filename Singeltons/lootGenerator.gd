extends Node

func _create_axe(randomize = true):
	var item = Item.new("Axe", preload("res://assets/images/Axe.png"), "Weapon")
	item._set_dmg(10, 'Slashing')
	if randomize:
		item._randomize()
	return item

func _create_bow(randomize = true):
	var item = Item.new("Bow", preload("res://assets/images/Bow.png"), "Weapon")
	item._set_dmg(5, "Piercing")
	if randomize:
		item._randomize()
	return item

func _create_ring(randomize = true):
	var item = Item.new("Ring", preload("res://assets/images/Ring.png"), "Trinket")
	if randomize:
		item._randomize()
	return item

func _create_amulet(randomize = true):
	var item = Item.new("Amulet", preload("res://assets/images/Amulet.png"), "Trinket")
	if randomize:
		item._randomize()
	return item


func _create_armor(randomize = true):
	var item = Item.new("Armor", preload("res://assets/images/Armor.png"), "Armor")
	item._set_armour(5, 5, 5, 0, 0, 0)
	if randomize:
		item._randomize()
	return item
