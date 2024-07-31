extends VBoxContainer

func _ready():
	Utils.inventory_description_update.connect(_on_inventory_description_update)

func _on_inventory_description_update(item : Item):
	for child in get_children():
		child.queue_free()
	if item != null:
		var newTitle = Label.new()
		newTitle.text = item.title
		add_child(newTitle)
