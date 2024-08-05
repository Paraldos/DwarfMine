extends Node

var map_size : Vector2
var room_count : int
var map = []
var rooms = []
var rng = RandomNumberGenerator.new()
var start_room : Vector2

func _ready():
	rng.randomize()
	_generate_map(Vector2(10, 10), 20)

func _generate_map(map_size = Vector2(10, 10), room_count = 10):
	self.map_size = map_size
	self.room_count = room_count
	_create_empty_map()
	_define_start_room()
	_print_map()

func _create_empty_map():
	map = []
	for i in map_size.y:
		var row = []
		map.append(row)
		for j in map_size.x:
			row.append(0)

func _define_start_room():
	var start_x = rng.randi_range(0, map_size.x)
	var start_y = rng.randi_range(0, map_size.y)
	map[start_y][start_x] = 1
	start_room = Vector2(start_x, start_y)

func _print_map():
	for i in map:
		print(i)
