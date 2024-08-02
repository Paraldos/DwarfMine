extends CharacterBody2D

@export var worth = 10
@export var cooldown = 0.2
var item = null
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var collision_shape_2d = $CollisionShape2D
var pickable = false

func _ready():
	if cooldown > 0.0:
		await get_tree().create_timer(cooldown).timeout
		pickable = true
	else:
		pickable = true

func _physics_process(delta):
	if is_on_floor():
		pickable = true
	_gravity_and_friction(delta)
	move_and_slide()

func _gravity_and_friction(delta):
	velocity.x = lerp(velocity.x, 0.0, 0.1)
	velocity.y += gravity * delta

func _on_area_2d_body_entered(body):
	if body.name == "Player" and pickable:
		Utils.gold += worth
		queue_free()
