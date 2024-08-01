extends CanvasLayer

@onready var weapon = $Control/MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/Equipped/HBoxContainer/Weapon
@onready var armor = $Control/MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/Equipped/HBoxContainer2/Armor
@onready var trinket = $Control/MarginContainer/VBoxContainer/HBoxContainer/PanelContainer/Equipped/HBoxContainer3/Trinket
@onready var bag = %Bag
@onready var description_container = %DescriptionContainer
var inventory_button = preload("res://Menus/Inventory/inventory_button.tscn")

func _ready():
	get_tree().paused = true
	_init_inventory()

func _init_inventory():
	weapon._new_item(["weapon", 0])
	armor._new_item(["armor", 0])
	trinket._new_item(["trinket", 0])
	for child in bag.get_children():
		child.queue_free()
	for i in Utils.inventory.bag.size():
		var new_btn = inventory_button.instantiate()
		bag.add_child(new_btn)
		new_btn._new_item(["bag", i])
		if i == 0:
			new_btn.grab_focus()

func _physics_process(delta):
	if Input.is_action_just_pressed("inventory"):
		queue_free()

func _on_tree_exiting():
	get_tree().paused = false
