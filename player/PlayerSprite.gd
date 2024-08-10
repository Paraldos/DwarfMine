extends Node2D

signal attack_animation_finished
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree["parameters/playback"]
@onready var hitbox = %Hitbox
@onready var muzzle = %Muzzle

var facing_left = false

func _ready():
	animation_tree.active = true

func _change_animation(new_animation):
	for child in get_children():
		if child is Sprite2D:
			child.visible = child.name == new_animation
	state_machine.travel(new_animation)

func _set_direction(velocity, delta):
	_set_jump_direction(velocity)
	_set_climbining_velocity(velocity)
	_set_x_direction(velocity)
	return facing_left

func _set_jump_direction(velocity):
	animation_tree.set("parameters/Jump/blend_position", velocity.y / 50)

func _set_climbining_velocity(velocity):
	if state_machine.get_current_node() == "Climbing":
		animation_tree.active = velocity != Vector2.ZERO

func _set_x_direction(velocity):
	if velocity.x != 0:
		facing_left = velocity.x <= 0
	for child in get_children():
		if child is Sprite2D:
			child.flip_h = facing_left
	for child in [hitbox, muzzle]:
		child.scale.x = -1 if (facing_left) else 1


func _attack_finished():
	attack_animation_finished.emit()
