class_name State
extends Node

@onready var state_machine = get_parent()
var charackter : CharacterBody2D
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var next_sate: State = null

func _enter() -> void:
	charackter.player_sprite._change_animation(name)

func exit() -> void:
	pass

func input(event):
	pass

func _state_physics_process(delta):
	pass
