extends Node2D

@export var map_size = Vector2(10, 10) # Größe der Karte (10x10 Einheiten)
@export var amount_of_rooms = 10 # Anzahl der Räume
@export var max_attempts = 1000 # Maximale Anzahl von Versuchen, um Räume zu platzieren
var map = []
var rng = RandomNumberGenerator.new()
var start_room = Vector2()

func _ready():
	rng.randomize()
	_generate_map()

func _generate_map():
	_create_empty_map()
	_define_start_room()
	if _fill_dungeon_with_rooms():
		print("Map successfully generated.")
	else:
		print("Failed to place all rooms within the maximum number of attempts.")

func _create_empty_map():
	map = []
	for i in range(int(map_size.y)):
		var row = []
		for j in range(int(map_size.x)):
			row.append(0)
		map.append(row)

func _define_start_room():
	start_room = _get_randome_position()
	map[start_room.y][start_room.x] = 2

func _fill_dungeon_with_rooms():
	var placed_rooms = amount_of_rooms - 1
	var attempts = 0
	while placed_rooms > 0 and attempts < max_attempts:
		var randome_position = _get_randome_position()
		if map[randome_position.y][randome_position.x] == 1:
			attempts += 1
			continue
		if _check_if_position_is_valid(randome_position):
			map[randome_position.y][randome_position.x] = 1
			placed_rooms -= 1
			attempts = 0 # Reset attempts after a successful placement
		else:
			attempts += 1
	return placed_rooms == 0

func _print_map():
	for i in map:
		print(i)

# ========================================================== Helper functions
func _get_randome_position():
	var randi_x = rng.randi_range(0, int(map_size.x) - 1)
	var randi_y = rng.randi_range(0, int(map_size.y) - 1)
	return Vector2(randi_x, randi_y)

func _check_if_position_is_valid(position):
	var neighbors = [
		Vector2(position.x - 1, position.y),
		Vector2(position.x + 1, position.y),
		Vector2(position.x, position.y - 1),
		Vector2(position.x, position.y + 1)
	]
	for neighbor in neighbors:
		if neighbor.x >= 0 and neighbor.x < int(map_size.x) and neighbor.y >= 0 and neighbor.y < int(map_size.y):
			if map[int(neighbor.y)][int(neighbor.x)] == 1:
				return true
	return false

func _get_valid_neighboor(position):
	var neighbors = [
		Vector2(position.x - 1, position.y),
		Vector2(position.x + 1, position.y),
		Vector2(position.x, position.y - 1),
		Vector2(position.x, position.y + 1)
	]
	for neighbor in neighbors:
		if neighbor.x < 0 or neighbor.x >= int(map_size.x):
			continue
		if neighbor.y < 0 or neighbor.y >= int(map_size.y):
			continue
		if map[int(neighbor.y)][int(neighbor.x)] == 1:
			return Vector2(neighbor.x, neighbor.y)
	return null
