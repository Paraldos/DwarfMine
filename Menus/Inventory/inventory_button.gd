extends Button

var item_shadow = preload("res://Menus/Inventory/item_shadow.tscn")
var slot = ["bag", 0]
var item = null

# ==================================================== ready
func _ready():
	Utils.inventory_update.connect(_on_inventory_update)

# ==================================================== focus
func _on_focus_entered():
	Utils.inventory_description_update.emit(item)
	if Utils.selected_slot:
		_create_shadow()

func _on_focus_exited():
	_remove_shadow()

# ==================================================== input
func _on_pressed():
	if !Utils.selected_slot and item:
		Utils.selected_slot = slot
		disabled = true
		_create_shadow()
	elif Utils.selected_slot:
		Utils._switch_two_item_slots(slot, Utils.selected_slot)
		Utils.selected_slot = null
		Utils.inventory_update.emit()

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		Utils.selected_slot = null
		_on_inventory_update()

# ==================================================== helper
func _new_item(slot):
	self.slot = slot
	_on_inventory_update()

func _on_inventory_update():
	item = Utils._get_item(slot)
	if item and item.icon:
		icon = item.icon
	else:
		icon = null
	disabled = false
	_remove_shadow()

func _create_shadow():
	var shadow = item_shadow.instantiate()
	add_child(shadow)

func _remove_shadow():
	for child in get_children():
		child.queue_free()
