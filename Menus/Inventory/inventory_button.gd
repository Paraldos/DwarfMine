extends Button

@onready var inventory_shadow = $InventoryShadow
var texture_rect : TextureRect
var slot = ["bag", 0]
var item = null

# ==================================================== ready
func _ready():
	Utils.inventory_update.connect(_on_reset_button)
	Utils.switch_set.connect(_on_reset_button)
	_change_color()

func _physics_process(delta):
	if Input.is_action_just_pressed("switch_items") && has_focus() && item:
		if item.type == "Weapon":
			var weapon_slot = ["weapon_1", 0] if Utils.active_set else ["weapon_2", 0]
			Utils._switch_two_item_slots(slot, weapon_slot)
		if item.type == "Armor":
			Utils._switch_two_item_slots(slot, ["armor", 0])
		if item.type == "Trinket":
			Utils._switch_two_item_slots(slot, ["trinket", 0])
		Utils.inventory_update.emit()
		Utils.inventory_description_update.emit(item, _exchange_is_valid())

# ==================================================== focus
func _on_focus_entered():
	Utils.inventory_description_update.emit(item, _exchange_is_valid())
	if Utils.selected_slot:
		inventory_shadow._on()
	_change_color()

func _on_focus_exited():
	_change_color()
	inventory_shadow._off()

# ==================================================== input
func _on_pressed():
	if !_exchange_is_valid():
		return
	if !Utils.selected_slot and item:
		Utils.selected_slot = slot
		disabled = true
		inventory_shadow._on()
	elif Utils.selected_slot == slot:
		_on_cancel()
	elif Utils.selected_slot:
		Utils._switch_two_item_slots(slot, Utils.selected_slot)
		_on_cancel()

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		_on_cancel()

# ==================================================== helper
func _init_inventory_btn(new_slot):
	slot = new_slot
	_on_reset_button()

func _exchange_is_valid():
	if !has_focus():
		return true
	elif !Utils.selected_slot:
		return true
	elif slot[0] == Utils._get_selected_item().type.to_lower():
		return true
	elif (slot[0] == "weapon_1" or slot[0] == "weapon_2") and Utils._get_selected_item().type == "Weapon":
		return true
	elif slot[0] == "bag" and !item:
		return true
	elif slot[0] == "bag" and Utils.selected_slot[0] == "bag":
		return true
	elif item && item.type == Utils._get_selected_item().type:
		return true
	else:
		return false

func _on_cancel():
	Utils.selected_slot = null
	Utils.inventory_update.emit()
	Utils.inventory_description_update.emit(item, _exchange_is_valid())

func _on_reset_button():
	disabled = false
	item = Utils._get_item(slot)
	_set_icon()
	_change_color()
	inventory_shadow._off()

func _change_color(color = null):
	if color:
		self_modulate = color
	elif Utils.selected_slot and !_exchange_is_valid():
		self_modulate = (Color("red"))
	elif item:
		self_modulate =(item._get_item_color())
	else:
		self_modulate = (Color("white"))

func _set_icon():
	texture_rect = $TextureRect
	if item and item.icon:
		texture_rect.texture = item.icon
	else :
		texture_rect.texture = null
