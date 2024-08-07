extends Node2D

@onready var player_position_marker = %PlayerPositionMarker
var world = null

func _spawn_player():
	world.player.global_position = player_position_marker.global_position
	get_tree().current_scene.add_child(world.player)

func _on_area_2d_body_entered(body):
	world._move_camera(global_position)
