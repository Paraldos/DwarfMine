extends Node2D

@onready var player_position_marker: Marker2D = $PlayerPositionMarker
var world = null

func _on_area_2d_body_entered(body):
	world._move_camera(global_position)
