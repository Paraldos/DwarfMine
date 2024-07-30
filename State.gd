class_name State
extends Node

@export var animation_name: String
@export var move_speed: float = 400
var charackter : CharacterBody2D
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

func _enter() -> void:
	charackter.PlayerAnimation.play(animation_name)

func _exit() -> void:
	pass

func _process_frame(delta: float) -> State:
	return null
