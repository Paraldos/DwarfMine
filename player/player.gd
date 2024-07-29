extends CharacterBody2D

const SPEED = 80.0
const JUMP_VELOCITY = -130.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var player_animation = $PlayerAnimation
var direction = Input.get_axis("ui_left", "ui_right")
var status = "Idle"

func _physics_process(delta):
	direction = Input.get_axis("ui_left", "ui_right")
	status = "Idle"
	_jump(delta)
	_attack()
	_movement()
	_animation()
	move_and_slide()

func _attack():
	if status != "Idle":
		return
	if Input.is_action_just_pressed("ui_attack"):
		status = "Bow"

func _jump(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		status = "Jump"
		if direction:
			velocity.x = direction * SPEED
	if Input.is_action_just_pressed("ui_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		status = "Jump"

func _movement():
	if status != "Idle":
		return
	if direction:
		velocity.x = direction * SPEED
		status = "Run"
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func _animation():
	player_animation._change_animation(status, velocity)
