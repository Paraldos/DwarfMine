extends CanvasLayer

@onready var weapon_1 = %Weapon1
@onready var weapon_2 = %Weapon2
@onready var armor = %Armor
@onready var trinket = %Trinket
@onready var bag_container = %BagContainer
@onready var label_set_1 = %LabelSet1
@onready var label_set_2 = %LabelSet2
var inventory_button = preload("res://Menus/Inventory/inventory_button.tscn")

func _ready():
	get_tree().paused = true
	_init_inventory()
	_update_set_label()
	Utils.switch_set.connect(_update_set_label)

func _physics_process(delta):
	if Input.is_action_just_pressed("inventory"):
		queue_free()
	if Input.is_action_just_pressed("switch_set"):
		Utils._switch_set()

func _init_inventory():
	weapon_1._init_inventory_btn(["weapon_1", 0])
	weapon_2._init_inventory_btn(["weapon_2", 0])
	armor._init_inventory_btn(["armor", 0])
	trinket._init_inventory_btn(["trinket", 0])
	for child in bag_container.get_children():
		child.queue_free()
	for i in Utils.inventory.bag.size():
		var new_btn = inventory_button.instantiate()
		bag_container.add_child(new_btn)
		new_btn._init_inventory_btn(["bag", i])
		if i == 0:
			new_btn.grab_focus()

func _on_tree_exiting():
	get_tree().paused = false

func _update_set_label():
	label_set_1.modulate = Color('White') if Utils.active_set else Color("ffffff64")
	label_set_2.modulate = Color('ffffff64') if Utils.active_set else Color("White")
