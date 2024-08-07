extends Node2D

var directions = [
	Vector2(0, 1),
	Vector2(-1, 0),
	Vector2(0, -1),
	Vector2(1, 0),
]
var unused_direcionts = []
var map_size = Vector2(10, 10)
var map = []
var rng = RandomNumberGenerator.new()
var start_room = Vector2()
var rooms = []
var lengt_of_corridors = 4
var branches = 3
var placed_rooms = 0

func _ready():
	rng.randomize()
	await get_tree().process_frame
	_generate_map()

func _generate_map():
	_empty_map()
	_define_start_room()
	for branch in branches:
		_fill_dungeon_with_rooms()
	_clean_up_map()
	_print_map()

func _empty_map():
	map = []
	for y in range(map_size.y):
		var row = []
		for x in range(map_size.x):
			row.append(0)
		map.append(row)

func _define_start_room():
	start_room = Vector2(map_size.x / 2, map_size.y / 2)
	rooms.append(start_room)
	map[start_room.y][start_room.x] = 2


func _fill_dungeon_with_rooms():
	var favorit_direction = _get_favorite_direction()
	rooms.shuffle()
	var current_room = rooms[0]
	for i in lengt_of_corridors:
		var valid_neighbours = _get_valid_neighbour(current_room)
		if valid_neighbours.size() == 0:
			return false
		else:
			var next_room : Vector2
			if valid_neighbours.has(current_room + favorit_direction):
				next_room = current_room + favorit_direction
			else:
				next_room = valid_neighbours[rng.randi_range(0, valid_neighbours.size() - 1)]
			map[next_room.y][next_room.x] = 1
			rooms.append(next_room)
			current_room = next_room
			placed_rooms += 1

func _clean_up_map():
	# Remove empty rows
	for i in map_size.y:
		var row = map_size.y -1 - i
		var row_is_not_empty = map[row].has(1) or map[row].has(2)
		if !row_is_not_empty:
			map.pop_at(row)
	# Remove empty columns
	for i in map_size.x:
		var column = map_size.x -1 - i
		var column_is_empty = true
		for row in map.size():
			if map[row][column] != 0:
				column_is_empty = false
		if column_is_empty:
			for row in map.size():
				map[row].pop_at(column)

func _print_map():
	for i in map:
		print(i)
	print(placed_rooms)

# ========================================================== Helper functions
func _get_favorite_direction():
	if unused_direcionts.size() == 0:
		unused_direcionts = directions
	unused_direcionts.shuffle()
	return unused_direcionts[0]

func _get_valid_neighbour(current_room):
	var neighbours = []
	var x = current_room.x
	var y = current_room.y
	var neighbors = [
		Vector2(x - 1, y),
		Vector2(x + 1, y),
		Vector2(x, y - 1),
		Vector2(x, y + 1)
	]
	for neighbour in neighbors:
		if neighbour.x >= 0 and neighbour.x < map_size.x and neighbour.y >= 0 and neighbour.y < map_size.y:
			if map[neighbour.y][neighbour.x] == 0:
				neighbours.append(neighbour)
	return neighbours
