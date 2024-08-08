extends CanvasLayer

func _on_button_pressed():
	await MapGenerator._generate_map()
