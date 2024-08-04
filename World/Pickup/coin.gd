extends CharacterBody2D

@export var worth = 10
@export var cooldown = 0.2
@onready var area_2d = $Area2D
var item = null
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	if cooldown > 0.0:
		await get_tree().create_timer(cooldown).timeout
		area_2d.monitoring = true
	else:
		area_2d.monitoring = true

func _physics_process(delta):
	if is_on_floor():
		area_2d.monitoring = true
	_gravity_and_friction(delta)
	move_and_slide()

func _gravity_and_friction(delta):
	velocity.x = lerp(velocity.x, 0.0, 0.1)
	velocity.y += gravity * delta

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		InventoryController.gold += worth
		queue_free()
