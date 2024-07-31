extends Node

func _create_axe():
	return Item.new("Axe", preload("res://assets/images/Axe.png"), "Weapon")

func _create_bow():
	return Item.new("Bow", preload("res://assets/images/Bow.png"), "Weapon")