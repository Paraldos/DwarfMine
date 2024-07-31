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
	weapon._on_upadte(Utils.inventory.weapon, ["Weapon", 0])
	armor._on_upadte(Utils.inventory.armor, ["Armor", 0])
	trinket._on_upadte(Utils.inventory.trinket, ["Trinket", 0])
	for child in bag.get_children():
		child.queue_free()
	for i in Utils.max_inventory_size:
		var new_btn = inventory_button.instantiate()
		new_btn._on_upadte(Utils.inventory.bag[i] if Utils.inventory.bag.size() > i else null, ["Bag", i])
		bag.add_child(new_btn)
		if i == 0:
			new_btn.grab_focus()

func _update_bag():
	for i in Utils.max_inventory_size:
		var btn = bag.get_child(i)
		btn._on_upadte(Utils.inventory.bag[i] if Utils.inventory.bag.size() > i else null)

func _physics_process(delta):
	if Input.is_action_just_pressed("ineventory"):
		queue_free()

func _on_tree_exiting():
	get_tree().paused = false
