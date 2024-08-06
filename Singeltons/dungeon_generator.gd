extends Node2D

var map_size = Vector2(10, 10)
var amount_of_rooms = 10
var max_attempts = 1000
var map = []
var rng = RandomNumberGenerator.new()
var start_room = Vector2()
var rooms = []

func _ready():
	rng.randomize()
	await get_tree().process_frame
	_generate_map()

func _generate_map():
	_create_empty_map()
	_define_start_room()
	if _fill_dungeon_with_rooms():
		print("Map successfully generated.")
	else:
		print("Failed to place all rooms.")

func _create_empty_map():
	map = []
	for y in range(map_size.y):
		var row = []
		for x in range(map_size.x):
			row.append(0)
		map.append(row)

func _define_start_room():
	start_room = _get_randome_position()
	rooms.append(start_room)
	map[start_room.y][start_room.x] = 2

func _fill_dungeon_with_rooms():
	var placed_rooms = amount_of_rooms - 1
	var attempts = 0
	while placed_rooms > 1:
		attempts += 1
		rooms.shuffle()
		var room = rooms[0]
		var neighbors = [
			Vector2(room.x - 1, room.y),
			Vector2(room.x + 1, room.y),
			Vector2(room.x, room.y - 1),
			Vector2(room.x, room.y + 1)
		]
		for neighbor in neighbors:
			if neighbor.x < 0 or neighbor.x >= (map_size.x -1):
				continue
			if neighbor.y < 0 or neighbor.y >= (map_size.y -1):
				continue
			if map[neighbor.y][neighbor.x] == 0:
				map[neighbor.y][neighbor.x] = 1
				rooms.append(neighbor)
				placed_rooms -= 1
				attempts = 0
				print(placed_rooms)
	return placed_rooms == 0

func _print_map():
	for i in map:
		print(i)

# ========================================================== Helper functions
func _get_randome_position():
	var randi_x = rng.randi_range(0, (map_size.x - 1))
	var randi_y = rng.randi_range(0, (map_size.y - 1))
	return Vector2(randi_x, randi_y)
