extends Button

@onready var inventory_shadow = $InventoryShadow
var texture_rect : TextureRect
var slot = ["bag", 0]
var item = null
var valid = true

# ==================================================== ready
func _new_item(slot):
	self.slot = slot
	_on_reset_button()

func _ready():
	Utils.inventory_update.connect(_on_reset_button)
	_change_color()

func _physics_process(delta):
	if Input.is_action_just_pressed("switch_items") && has_focus() && item:
		if ["weapon", "armor", "trinket"].has(item.type.to_lower()):
			Utils._switch_two_item_slots(slot, [item.type.to_lower(), 0])
			Utils.inventory_update.emit()
			Utils.inventory_description_update.emit(item)

# ==================================================== focus
func _on_focus_entered():
	Utils.inventory_description_update.emit(item)
	if Utils.selected_slot:
		inventory_shadow._on()
		if ["Weapon", "Armor", "Trinket"].has(name) and name != Utils._get_selected_item().type:
			valid = false
			_change_color()

func _on_focus_exited():
	valid = true
	_change_color()
	inventory_shadow._off()

# ==================================================== input
func _on_pressed():
	if !valid:
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
func _on_cancel():
	Utils.selected_slot = null
	Utils.inventory_update.emit()

func _on_reset_button():
	valid = true
	disabled = false
	item = Utils._get_item(slot)
	_set_icon()
	_change_color()
	inventory_shadow._off()

func _change_color(color = null):
	if color:
		self_modulate = color
	elif Utils.selected_slot and !valid:
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
