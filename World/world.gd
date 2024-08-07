extends Node2D

@onready var rooms = %Rooms
@onready var camera = $Camera
var dungeon_layout = DungeonGenerator.map
var possible_rooms = [preload("res://World/room_template.tscn")]
var room_size = Vector2(144+8, 80+8)
var start_room = null

func _ready():
	start_room = _spawn_room(DungeonGenerator.start_room)
	for y in dungeon_layout.size():
		for x in dungeon_layout[y].size():
			if dungeon_layout[y][x] ==1:
				await _spawn_room(Vector2(x, y))
	_spawn_palyer()

func _move_camera(new_pos : Vector2):
	camera.global_position = new_pos

func _spawn_room(room_position):
	var new_room = possible_rooms[0].instantiate()
	new_room.position = Vector2(
		room_position.x * room_size.x, 
		room_position.y * room_size.y)
	rooms.add_child(new_room)
	return new_room

func _spawn_palyer():
	start_room._spawn_player()

