extends Node2D

@onready var player_position_marker = %PlayerPositionMarker
var world = null
var player_template = preload("res://player/player.tscn")
var portal_template = preload("res://world/Objects/portal.tscn")

func _spawn_player():
	var player = player_template.instantiate()
	player.global_position = player_position_marker.global_position
	world.player = player
	get_tree().current_scene.add_child(player)

func _spawn_portal():
	var portal = portal_template.instantiate()
	portal.global_position = player_position_marker.global_position
	get_tree().current_scene.add_child(portal)

func _on_area_2d_body_entered(body):
	world._move_camera(global_position)
