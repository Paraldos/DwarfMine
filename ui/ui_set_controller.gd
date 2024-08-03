extends Control

@onready var set_1 = $Set1
@onready var set_2 = $Set2
@onready var set_1_icon = $Set1/Set1Icon
@onready var set_2_icon = $Set2/Set2Icon

func _ready():
	_update()
	InventoryController.switch_set.connect(_update)

func _update():
	var wepaon_1 = InventoryController.inventory.weapon_1
	var weapon_2 = InventoryController.inventory.weapon_2
	set_1_icon.texture = wepaon_1.icon if wepaon_1 else null
	set_2_icon.texture = weapon_2.icon if weapon_2 else null
	set_1.z_index = 5 if InventoryController.active_set else 0
	set_2.z_index = 0 if InventoryController.active_set else 5
