extends Node
class_name OpenInventory

var inventory = preload("res://Menus/Inventory/inventory.tscn")

func _physics_process(delta):
	if Input.is_action_just_pressed("inventory"):
		var new_inventory_screen = inventory.instantiate()
		get_tree().current_scene.add_child(new_inventory_screen)
