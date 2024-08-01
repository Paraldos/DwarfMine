extends VBoxContainer

var item = null
var is_valid = false

func _ready():
	Utils.inventory_description_update.connect(_on_inventory_description_update)

func _on_inventory_description_update(item : Item, is_valid):
	self.item = item
	self.is_valid = is_valid
	for child in get_children():
		child.queue_free()
	_add_title()
	_add_dmg()
	_add_armor()

func _add_title():
	if item != null:
		var newTitle = Label.new()
		newTitle.text = "%s (%s)" % [item.title, item.type]
		newTitle.modulate = item._get_item_color()
		add_child(newTitle)

func _add_dmg():
	if item != null and item.type == "Weapon":
		var newLabel = Label.new()
		newLabel.text = "Damage: %s (%s)" % [item.dmg, item.dmg_type]
		_add_dmg_differenz(newLabel)
		_add_selected_dmg_differenz(newLabel)
		add_child(newLabel)

func _add_dmg_differenz(newLabel):
	if !is_valid: return
	var current_weapon = Utils._get_current_weapon()
	var selected_weapon = Utils._get_selected_item()
	if !selected_weapon && current_weapon && item != current_weapon:
		var differenz = item.dmg - current_weapon.dmg
		newLabel.text += " (%s)" % [differenz]
		if differenz > 0:
			newLabel.modulate = Color("#00ff00")
		elif differenz < 0:
			newLabel.modulate = Color("#ff0000")

func _add_selected_dmg_differenz(newLabel):
	if !is_valid: return
	var current_weapon = Utils._get_current_weapon()
	var selected_weapon = Utils._get_selected_item()
	if selected_weapon && item != selected_weapon:
		var differenz = selected_weapon.dmg - item.dmg
		newLabel.text += " (%s)" % [differenz]
		if differenz > 0:
			newLabel.modulate = Color("#00ff00")
		elif differenz < 0:
			newLabel.modulate = Color("#ff0000")

func _add_armor():
	if item != null and item.type == "Armor":
		var current_armor = Utils._get_current_armor()
		var selected_armor = Utils._get_selected_item()
		_add_armor_title()
		var grid = _add_armor_grid()
		_add_armor_label(grid)

func _add_armor_title():
	var newLabel = Label.new()
	newLabel.text = "Armor:"
	add_child(newLabel)

func _add_armor_grid():
	var newGrid = GridContainer.new()
	var theme = Theme.new()
	theme.set_constant("v_separation", "GridContainer", 1)
	newGrid.theme = theme
	newGrid.columns = 2
	add_child(newGrid)
	return newGrid

func _add_armor_label(grid):
	for armor_type in item.armor:
		var newLabel = Label.new()
		newLabel.text = "%s %s" % [item.armor[armor_type], armor_type]
		grid.add_child(newLabel)
		_add_armor_diffenrenz(armor_type, newLabel)
		_add_selected_armor_differenz(armor_type, newLabel)

func _add_armor_diffenrenz(armor_type, newLabel):
	if !is_valid: return
	var current_armor = Utils._get_current_armor()
	var selected_armor = Utils._get_selected_item()
	if !selected_armor && current_armor && item != current_armor:
		var differenz = item.armor[armor_type] - current_armor.armor[armor_type]
		newLabel.text += " (%s)" % [differenz]
		if differenz > 0:
			newLabel.modulate = Color("#00ff00")
		elif differenz < 0:
			newLabel.modulate = Color("#ff0000")

func _add_selected_armor_differenz(armor_type, newLabel):
	if !is_valid: return
	var selected_armor = Utils._get_selected_item()
	if selected_armor && item != selected_armor:
		var differenz = selected_armor.armor[armor_type] - item.armor[armor_type]
		newLabel.text += " (%s)" % [differenz]
		if differenz > 0:
			newLabel.modulate = Color("#00ff00")
		elif differenz < 0:
			newLabel.modulate = Color("#ff0000")


