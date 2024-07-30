extends CharacterBody2D

const SPEED = 80.0
const JUMP_VELOCITY = -130.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var player_animation = $PlayerAnimation
var direction = Input.get_axis("ui_left", "ui_right")
var current_weapon = "Axe"
var state = "Idle"

func _physics_process(delta):
	pass
	#direction = Input.get_axis("ui_left", "ui_right")
	#state = "Idle"
	#_jump(delta)
	#_attack()
	#_movement()
	#_animation()
	#_friction(delta)
	#move_and_slide()

func _jump(delta):
	if Input.is_action_just_pressed("ui_jump") or not is_on_floor():
		state = "Jump"
	if not is_on_floor():
		if direction:
			velocity.x = direction * SPEED
	if Input.is_action_just_pressed("ui_jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

func _attack():
	if state == "Jump": return
	if player_animation.state_machine.get_current_node() == "Attack" or Input.is_action_pressed("ui_attack"):
		state = "Attack"

func _movement():
	if state != "Idle": return
	if direction:
		velocity.x = direction * SPEED
		state = "Run"

func _friction(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	if  direction == 0:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func _animation():
	player_animation._change_animation(state, velocity)
