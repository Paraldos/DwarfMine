extends Control

@onready var border_rect = $BorderRect
@onready var icon_rect = $IconRect
@onready var animation_player = $AnimationPlayer

func _on():
	var item = InventoryController._get_selected_item()
	if item:
		icon_rect.texture = item.icon
		border_rect.self_modulate = item._get_item_color()
		animation_player.play("fade")

func _off():
	if modulate != Color("#ffffff00"):
		animation_player.play_backwards("fade")
