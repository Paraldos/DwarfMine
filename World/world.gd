extends Node2D

@onready var rooms = %Rooms
@onready var camera = $Camera
@onready var map = MapGenerator.map
var room_size = Vector2(144, 80)
var start_room = null
var player = null

func _ready():
	start_room = _spawn_room(MapGenerator.start_position)
	for y in map.size():
		for x in map[y].size():
			if map[y][x] != 0:
				var room = _spawn_room(Vector2(x, y))
				await get_tree().create_timer(0.05).timeout
				if map[y][x] == 2:
					room._spawn_player()
				if map[y][x] == 3:
					room._spawn_portal()
	Utils.mini_map__create.emit()

func _move_camera(new_pos : Vector2, tween_position = true):
	if tween_position:
		var tween = get_tree().create_tween()
		tween.tween_property(camera, "global_position", new_pos, 0.3)
	else:
		camera.global_position = new_pos
	Utils.mini_map__update.emit(new_pos)

func _spawn_room(room_position):
	var neighbors = MapGenerator._get_neighbours(room_position)
	var room = RoomLoader._get_room(neighbors.top, neighbors.right, neighbors.bottom, neighbors.left)
	var new_room = room.instantiate()
	new_room.global_position = Vector2(
		room_position.x * room_size.x, 
		room_position.y * room_size.y)
	new_room.world = self
	rooms.add_child(new_room)
	return new_room
