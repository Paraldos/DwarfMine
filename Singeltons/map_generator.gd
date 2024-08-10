extends Node2D

var map_size = Vector2(6, 6)
var map = []
var rng = RandomNumberGenerator.new()
var start_position = Vector2()
var rooms = []
var max_number_of_rooms = 10

func _ready():
	rng.randomize()
	_generate_map()

func _generate_map():
	_empty_map()
	_define_start_position()
	_fill_dungeon_with_rooms()
	_print_map()

func _empty_map():
	map = []
	for y in range(map_size.y):
		var row = []
		for x in range(map_size.x):
			row.append(0)
		map.append(row)

func _define_start_position():
	_add_room(Vector2(map_size.x / 2, 0), 2)
	start_position = Vector2(map_size.x / 2, 0)

func _fill_dungeon_with_rooms():
	var current_cell = start_position
	while rooms.size() < max_number_of_rooms:
		current_cell = rooms[-1].cell
		var valid_directions = _get_valid_directions(current_cell)
		if valid_directions.size() == 0:
			return false
		else:
			valid_directions.shuffle()
			_add_room(valid_directions[0], 1)
	current_cell = rooms[-1].cell
	_change_room_type(current_cell, 3)

func _print_map():
	for i in map:
		print(i)
	print("Rooms: ", rooms.size())

# ========================================================== Helper functions
func _add_room(cell, type):
	map[cell.y][cell.x] = type
	rooms.append(Room.new(type, cell))

func _change_room_type(cell, type):
	map[cell.y][cell.x] = type
	for room in rooms:
		if room.cell == cell:
			room.type = type

func _get_valid_directions(current_pos):
	var valid_directions = []
	var neighbors = [
		current_pos + Vector2(1, 0),
		current_pos + Vector2(1, 0),
		current_pos + Vector2(0, 1),
		current_pos + Vector2(0, 1),
		current_pos + Vector2(-1, 0)
	]
	for neighbour in neighbors:
		if neighbour.x >= 0 and neighbour.x < map_size.x and neighbour.y >= 0 and neighbour.y < map_size.y:
			if map[neighbour.y][neighbour.x] == 0:
				valid_directions.append(neighbour)
	return valid_directions

func _get_neighbours(pos):
	var neighbours = {
		"top": Vector2(0, -1),
		"right": Vector2(1, 0),
		"bottom": Vector2(0, 1),
		"left": Vector2(-1, 0),
	}
	for neighbour in neighbours.keys():
		var neighbor_pos = pos + neighbours[neighbour]
		neighbours[neighbour] = false
		if neighbor_pos.y < 0 or neighbor_pos.y >= map.size():
			continue
		if neighbor_pos.x < 0 or neighbor_pos.x >= map[0].size():
			continue
		neighbours[neighbour] = map[neighbor_pos.y][neighbor_pos.x] != 0
	return neighbours
