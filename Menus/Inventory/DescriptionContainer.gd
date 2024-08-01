extends VBoxContainer

func _ready():
	Utils.inventory_description_update.connect(_on_inventory_description_update)

func _on_inventory_description_update(item : Item):
	for child in get_children():
		child.queue_free()
	_add_title(item)
	_add_dmg(item)
	_add_armor(item)

func _add_title(item):
	if item != null:
		var newTitle = Label.new()
		newTitle.text = "%s (%s)" % [item.title, item.type]
		newTitle.modulate = item._get_item_color()
		add_child(newTitle)

func _add_dmg(item):
	if item != null and item.type == "Weapon":
		var newDmg = Label.new()
		newDmg.text = "Damage: %s (%s)" % [item.dmg, item.dmg_type]
		add_child(newDmg)
		if !Utils.selected_slot && item != Utils._get_current_weapon():
			var differenz = item.dmg - Utils._get_current_weapon().dmg
			newDmg.text += " (%s)" % [differenz]
			if differenz > 0:
				newDmg.modulate = Color("#00ff00")
			elif differenz < 0:
				newDmg.modulate = Color("#ff0000")

func _add_armor(item):
	if item != null and item.type == "Armor":
		# label
		var newArmor = Label.new()
		newArmor.text = "Armor:"
		add_child(newArmor)
		# grid
		var grid = GridContainer.new()
		var theme = Theme.new()
		theme.set_constant("v_separation", "GridContainer", 1)
		grid.theme = theme  # Set the theme property instead of theme_override
		grid.columns = 2
		add_child(grid)
		# armor types
		for armor in item.armor:
			var newArmorType = Label.new()
			newArmorType.text = "%s %s" % [item.armor[armor], armor]
			grid.add_child(newArmorType)
			# compare
			if !Utils.selected_slot && item != Utils._get_item(["armor"]):
				var differenz = item.armor[armor] - Utils._get_item(["armor"]).armor[armor]
				newArmorType.text += " (%s)" % [differenz]
				if differenz > 0:
					newArmorType.modulate = Color("#00ff00")
				elif differenz < 0:
					newArmorType.modulate = Color("#ff0000")
