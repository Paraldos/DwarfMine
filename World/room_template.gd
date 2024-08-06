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
@onready var camera_2d = $Camera2D
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
	camera_2d.enabled = true
	z_index = 5

func _on_area_2d_body_exited(body):
	camera_2d.enabled = false
	z_index = 0
