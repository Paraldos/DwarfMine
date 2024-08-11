extends CharacterBody2D

@export var SPEED = 80.0
@export var JUMP_POWER = -140.0
@onready var state_machine = $StateMachine
@onready var player_sprite = %PlayerSprite
@onready var ladder_scanner = $LadderScanner
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var facing_left = false

func _ready():
	Utils.player = self
	state_machine.init(self)

func _physics_process(delta):
	state_machine._state_physics_process(delta)
	facing_left = player_sprite._set_direction(velocity, state_machine.current_state.name)
	move_and_slide()
	if Input.is_action_just_pressed("switch_set"):
		InventoryController._switch_set()

func _gravity(delta):
	velocity.y += gravity * delta
