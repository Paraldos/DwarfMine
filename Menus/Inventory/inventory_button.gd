extends Button

@onready var inventory_shadow = $InventoryShadow
var texture_rect : TextureRect
var slot = ["bag", 0]
var item = null

# ==================================================== init
func _init_inventory_btn(new_slot):
	slot = new_slot
	_on_reset_button()

# ==================================================== ready
func _ready():
	InventoryController.inventory_update.connect(_on_reset_button)
	InventoryController.switch_set.connect(_on_switch_set)
	_change_color()

# ==================================================== input
func _physics_process(_delta):	
	if Input.is_action_just_pressed("switch_items"):
		if !has_focus():
			return
		elif !item:
			return
		elif !InventoryController._exchange_is_valid(slot):
			return
		elif item.type == "Weapon":
			var weapon_slot = ["weapon_1", 0] if InventoryController.active_set else ["weapon_2", 0]
			InventoryController._switch_two_item_slots(slot, weapon_slot)
		elif item.type == "Armor":
			InventoryController._switch_two_item_slots(slot, ["armor", 0])
		elif item.type == "Trinket":
			InventoryController._switch_two_item_slots(slot, ["trinket", 0])
		InventoryController.inventory_update.emit()
	if Input.is_action_just_pressed("ui_cancel"):
		if !InventoryController.selected_slot:
			return
		_on_cancel()

func _on_pressed():
	if !InventoryController._exchange_is_valid(slot):
		return
	if !InventoryController.selected_slot and item:
		InventoryController.selected_slot = slot
		disabled = true
		inventory_shadow._on()
	elif InventoryController.selected_slot == slot:
		_on_cancel()
	elif InventoryController.selected_slot:
		InventoryController._switch_two_item_slots(slot, InventoryController.selected_slot)
		_on_cancel()

# ==================================================== handlers
# ============== focus
func _on_focus_entered():
	InventoryController.inventory_new_focus.emit(slot)
	if InventoryController._get_selected_item():
		inventory_shadow._on()
	_change_color()

func _on_focus_exited():
	_change_color()
	inventory_shadow._off()

# ============== other signals
func _on_cancel():
	InventoryController.selected_slot = null
	InventoryController.inventory_update.emit()
	if has_focus():
		InventoryController.inventory_new_focus.emit(slot)

func _on_reset_button():
	disabled = false
	item = InventoryController._get_item(slot)
	_set_icon()
	_change_color()
	inventory_shadow._off()
	if has_focus():
		InventoryController.inventory_new_focus.emit(slot)

func _on_switch_set():
	_change_color()
	if has_focus():
		InventoryController.inventory_new_focus.emit(slot)

# ==================================================== helpers
func _change_color(color = null):
	if color:
		self_modulate = color
	elif has_focus() and !InventoryController._exchange_is_valid(slot):
		self_modulate = (Color("red"))
	elif item:
		self_modulate = item._get_item_color()
	else:
		self_modulate = Color("white")

func _set_icon():
	texture_rect = $TextureRect
	if item and item.icon:
		texture_rect.texture = item.icon
	else :
		texture_rect.texture = null
