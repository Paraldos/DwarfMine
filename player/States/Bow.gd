extends State

@export var idle_state: State
@export var move_state: State
@export var muzzle: Marker2D
var arrow = preload("res://Projectiles/projectile.tscn")

func _enter():
	super._enter()

func _state_physics_process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if !charackter.is_on_floor():
		charackter.velocity.x = direction * charackter.SPEED
	else:
		charackter.velocity = Vector2.ZERO
	charackter._gravity(delta)

func _on_player_sprite_attack_animation_finished():
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		state_machine._change_state("move_state")
	else:
		state_machine._change_state("idle_state")

func _spawn_arrow():
	var new_arrow = arrow.instantiate()
	new_arrow.global_position = muzzle.global_position
	if charackter.facing_left:
		new_arrow.velocity *= -1
	get_tree().current_scene.add_child(new_arrow)
