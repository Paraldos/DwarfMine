extends CharacterBody2D

const SPEED = 80.0
const JUMP_VELOCITY = -150.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var player_animation = $PlayerAnimation

func _physics_process(delta):
	_jump(delta)
	_movement()
	_animation()
	move_and_slide()

func _jump(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

func _movement():
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func _animation():
	if !is_on_floor():
		player_animation._change_animation("Jump", velocity)
	elif velocity.x != 0:
		player_animation._change_animation("Run", velocity)
	else:
		player_animation._change_animation("Idle", velocity)
