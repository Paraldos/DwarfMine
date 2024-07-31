extends CharacterBody2D

@export var SPEED = 80.0
@export var JUMP_POWER = -140.0
@onready var player_animation = $PlayerAnimation
@onready var state_machine = $StateMachine
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var facing_left = false

func _ready():
	state_machine.init(self)

func _physics_process(delta):
	state_machine._state_physics_process(delta)
	player_animation._change_direction(velocity)
	facing_left = player_animation.flip_h
	move_and_slide()

func _change_animation(animation_name):
	player_animation._change_animation(animation_name)

func _gravity(delta):
	velocity.y += gravity * delta
