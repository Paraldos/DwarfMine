extends Node2D

@export var openings = {
	top: false,
	right: false,
	bottom: false,
	left: false,
}
@onready var top = %Top
@onready var right = %Right
@onready var bottom = %Bottom
@onready var left = %Left
@onready var player_position = %PlayerPosition
var player_template = preload("res://player/player.tscn")

func _ready():
	_set_borders()

func _spawn_player():
	var player = player_template.instantiate()
	player.global_position = player_position.global_position
	get_tree().current_scene.add_child(player)

func _set_borders():
	top.disabled = openings.top
	right.disabled = openings.right
	left.disabled = openings.left
	bottom.disabled = openings.bottom

func _on_area_2d_body_entered(body):
	get_parent().get_parent()._move_camera(global_position)
	z_index = 5

func _on_area_2d_body_exited(body):
	z_index = 0
