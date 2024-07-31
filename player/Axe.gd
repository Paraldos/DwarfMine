extends State

func _enter():
	super._enter()

func _state_physics_process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	if !charackter.is_on_floor():
		charackter.velocity.x = direction * charackter.SPEED
	else:
		charackter.velocity = Vector2.ZERO
	charackter._gravity(delta)

func _on_player_animation_attack_animation_finished():
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		state_machine._change_state("move")
	else:
		state_machine._change_state("idle")
