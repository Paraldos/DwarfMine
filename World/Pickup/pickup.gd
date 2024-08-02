extends CharacterBody2D

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

func _on_interaction_area_interacted():
	if Utils._player_has_free_inventory_space():
		pass
