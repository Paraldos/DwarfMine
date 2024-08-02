extends Node

signal inventory_update
signal inventory_description_update
signal switch_set
var player = null
var inventory = {
	weapon_1 = null,
	weapon_2 = null,
	armor = null,
	trinket = null,
	bag = []
}
var selected_slot = null
var active_set = true

func _ready():
	for i in 12:
		inventory.bag.append(null)
	inventory.weapon_1 = LootGenerator._create_hammer()
	inventory.weapon_2 = LootGenerator._create_bow()
	inventory.armor = LootGenerator._create_armor()
	inventory.bag[0] = LootGenerator._create_ring()
	inventory.bag[1] = LootGenerator._create_amulet()
	inventory.bag[2] = LootGenerator._create_axe()
	inventory.bag[5] = LootGenerator._create_armor()

func _switch_two_item_slots(slot1, slot2):
	var item1 = _get_item(slot1)
	var item2 = _get_item(slot2)
	_put_item_into_slot(slot1, item2)
	_put_item_into_slot(slot2, item1)
	switch_set.emit()

func _get_player_dmg():
	var dmg = {value = 1, type = "Bashing"}
	if _get_current_weapon() != null:
		dmg.type = _get_current_weapon().dmg_type
		dmg.value += _get_current_weapon().dmg
	if inventory.armor != null:
		dmg.value += inventory.armor.dmg
	if inventory.trinket != null:
		dmg.value += inventory.trinket.dmg
	return dmg

func _get_current_weapon():
	if Utils.active_set:
		return inventory.weapon_1
	else:
		return inventory.weapon_2

func _get_current_armor():
	return inventory.armor

func _put_item_into_slot(slot, item):
	if slot[0] != "bag":
		inventory[ slot[0] ] = item;
	else:
		inventory[ slot[0] ][ slot[1] ] = item;

func _get_item(slot : Array):
	if slot[0] != "bag":
		return inventory[ slot[0] ];
	else:
		return inventory[ slot[0] ][ slot[1] ];

func _get_selected_item():
	if selected_slot == null:
		return null
	else:
		return _get_item(selected_slot)

func _switch_set():
	active_set = !active_set
	switch_set.emit()

func _player_has_free_inventory_space():
	for i in inventory.bag:
		if i == null:
			return true
	return false
