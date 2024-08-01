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
