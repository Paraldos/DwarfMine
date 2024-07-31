extends Button

var item = null
var item_shadow = preload("res://Menus/Inventory/item_shadow.tscn")
var slot = ["", ""]

func _on_upadte(new_item = null, slot = ["", ""]):
	print(slot)
	item = new_item
	if item != null:
		icon = item.icon

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		disabled = false
		Utils.selected_item = null
		_remove_shadow()

func _on_focus_entered():
	Utils.inventory_description_update.emit(item)
	if Utils.selected_item:
		_create_shadow()

func _on_focus_exited():
	_remove_shadow()

func _on_pressed():
	if item != null and Utils.selected_item == null:
		Utils.selected_item = item
		disabled = true
		_create_shadow()
	if Utils.selected_item:
		pass

func _create_shadow():
	var shadow = item_shadow.instantiate()
	shadow.item = Utils.selected_item
	add_child(shadow)

func _remove_shadow():
	for child in get_children():
		child.queue_free()
