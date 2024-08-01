extends Control

@onready var set_1 = $Set1
@onready var set_2 = $Set2
@onready var set_1_icon = $Set1/Set1Icon
@onready var set_2_icon = $Set2/Set2Icon

func _ready():
	_update()
	Utils.switch_set.connect(_update)

func _update():
	var wepaon_1 = Utils.inventory.weapon_1
	var weapon_2 = Utils.inventory.weapon_2
	set_1_icon.texture = wepaon_1.icon
	set_2_icon.texture = weapon_2.icon
	set_1.z_index = 5 if Utils.active_set else 0
	set_2.z_index = 0 if Utils.active_set else 5
