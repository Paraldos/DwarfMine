extends Control

@onready var texture_rect = $TextureRect
var item = null
var slot

func _ready():
	item = Utils._get_selected_item()
	if item:
		texture_rect.texture = item.icon
