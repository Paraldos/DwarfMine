extends CharacterBody2D

@export var SPEED = 80.0
@export var JUMP_POWER = -140.0
@onready var state_machine = $StateMachine
@onready var player_sprite = %PlayerSprite
@onready var player_direction = %PlayerDirection
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var facing_left = false

func _ready():
	Utils.player = self
	state_machine.init(self)

func _physics_process(delta):
	state_machine._state_physics_process(delta)
	facing_left = player_direction._set_direction(delta, velocity)
	move_and_slide()
	if Input.is_action_just_pressed("switch_set"):
		Utils._switch_set()

func _gravity(delta):
	velocity.y += gravity * delta
