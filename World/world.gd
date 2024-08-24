extends Node2D

@onready var rooms = %Rooms
@onready var camera = $Camera
@onready var map = MapGenerator.map
@onready var back: Node2D = %Back
@onready var middle: Node2D = %Middle
@onready var front: Node2D = %Front
var room_size = Vector2(144, 80)
var start_room = null
var player_template = preload("res://player/player.tscn")
var portal_template = preload("res://world/Objects/portal.tscn")

func _ready():
	Utils.world__add_element.connect(_on_add_element)
	start_room = _spawn_room(MapGenerator.start_position)
	for y in map.size():
		for x in map[y].size():
			if map[y][x] != 0:
				var room = await _spawn_room(Vector2(x, y))
				if map[y][x] == 2:
					_spawn_player(room)
				if map[y][x] == 3:
					_spawn_portal(room)
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

func _spawn_player(room):
	var player = player_template.instantiate()
	player.global_position = room.player_position_marker.global_position
	middle.add_child(player)

func _spawn_portal(room):
	var portal = portal_template.instantiate()
	portal.position = room.player_position_marker.global_position
	back.add_child(portal)

func _on_add_element(package, pos, z_index):
	var new_element = package.instantiate()
	new_element.global_position = pos
	if z_index == "front":
		front.add_child(new_element)
	elif z_index == "middle":
		middle.add_child(new_element)
	else:
		back.add_child(new_element)
