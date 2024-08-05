extends Node

var map_size : Vector2
var amount_of_rooms : int
var map = []
var rooms = []
var rng = RandomNumberGenerator.new()
var start_room : Vector2

func _ready():
	rng.randomize()
	_generate_map(Vector2(10, 10), 20)

func _generate_map(map_size = Vector2(10, 10), amount_of_rooms = 10):
	self.map_size = map_size
	self.amount_of_rooms = amount_of_rooms
	_create_empty_map()
	_define_start_room()
	_fill_dungeon_with_rooms()
	_print_map()

func _create_empty_map():
	map = []
	for i in map_size.y:
		var row = []
		map.append(row)
		for j in map_size.x:
			row.append(0)

func _define_start_room():
	start_room = _get_randome_position()
	map[start_room.y][start_room.x] = 2

func _fill_dungeon_with_rooms():
	var placed_rooms = amount_of_rooms -1
	while placed_rooms > 0:
		var randome_position = _get_randome_position()
		if map[randome_position.y][randome_position.x] == 1:
			continue
		if _check_if_position_is_valid(randome_position):
			map[randome_position.y][randome_position.x] = 1
			placed_rooms -= 1

func _print_map():
	for i in map:
		print(i)

# ========================================================== Helper functions
func _get_randome_position():
	var randi_x = rng.randi_range(0, map_size.x -1)
	var randi_y = rng.randi_range(0, map_size.y -1)
	return Vector2(randi_x, randi_y)

func _check_if_position_is_valid(position):
	if position == start_room:
		return false
	var neighboors = [
		Vector2(position.x - 1, position.y),
		Vector2(position.x + 1, position.y),
		Vector2(position.x, position.y - 1),
		Vector2(position.x, position.y + 1)
	]
	for neighboor in neighboors:
		if neighboor.x < 0 or neighboor.x >= map_size.x -1:
			continue
		if neighboor.y < 0 or neighboor.y >= map_size.y -1:
			continue
		if map[neighboor.y][neighboor.x] != 0:
			return true
	return false
