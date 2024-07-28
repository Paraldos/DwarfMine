extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -200.0
@onready var animation_player = $AnimationPlayer
@onready var sprite_2d = $Sprite2D
@onready var weapons = $Weapons

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	weapons.look_at(get_global_mouse_position())

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		animation_player.play("Walk")
		velocity.x = direction * SPEED
		if velocity.x > 0:
			sprite_2d.flip_h = false
		else:
			sprite_2d.flip_h = true
	else:
		animation_player.play("Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
