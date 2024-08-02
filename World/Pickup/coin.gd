extends CharacterBody2D

@export var worth = 10
var item = null
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	pass

func _physics_process(delta):
	_gravity_and_friction(delta)
	move_and_slide()

func _gravity_and_friction(delta):
	velocity.x = lerp(velocity.x, 0.0, 0.1)
	velocity.y += gravity * delta

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		Utils.gold += worth
		queue_free()
