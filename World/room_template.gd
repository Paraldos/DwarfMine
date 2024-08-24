extends Node2D

@onready var player_position_marker: Marker2D = $PlayerPositionMarker
@onready var back: Node2D = $Back
@onready var middle: Node2D = $Middle
@onready var front: Node2D = $Front
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
	portal.position = player_position_marker.position
	back.add_child(portal)

func _on_area_2d_body_entered(body):
	world._move_camera(global_position)
