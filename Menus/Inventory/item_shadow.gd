extends Control

@onready var texture_rect = $TextureRect
var item = null

func _ready():
	if item:
		texture_rect.texture = item.icon
