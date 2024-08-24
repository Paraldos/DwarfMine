extends TextureRect

var scatter_elements = [
	preload("res://world/Scatter/mushroom.tscn"),
	preload("res://world/Scatter/plant.tscn"),
]
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	texture = null
	rng.randomize()
	for i in floor(size.x / 8):
		if rng.randi_range(0, 100) > 65:
			_spawn_random_element(i)

func _spawn_random_element(i):
	var package = scatter_elements[rng.randi_range(0, scatter_elements.size() -1)]
	var pos = global_position + Vector2(i * 8, 8)
	var z_position = "front" if rng.randi_range(0, 100) > 50 else "back"
	Utils.world__add_element.emit(package, pos, z_position)
