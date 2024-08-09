extends Node

signal build_mini_map
signal update_mini_map(player_position)
signal room__update_neighbours(map)

var room_size = Vector2(144, 80)
var player = null
var interactables = []
var directions = [
	Vector2(0, 1),
	Vector2(-1, 0),
	Vector2(0, -1),
	Vector2(1, 0),
]
