extends CanvasLayer

func _on_button_pressed():
	await DungeonGenerator._generate_map()
