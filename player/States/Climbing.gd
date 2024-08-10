extends State

func _state_physics_process(delta):
	var x_direction = Input.get_axis("ui_left", "ui_right")
	var y_direction = Input.get_axis("ui_up", "ui_down")
	charackter.velocity.x = (x_direction * charackter.SPEED) * 0.5
	charackter.velocity.y = y_direction * charackter.SPEED
	if Input.is_action_just_pressed("jump"):
		charackter.velocity.y = charackter.JUMP_POWER
		state_machine._change_state("jump")
	if not charackter.ladder_scanner.get_overlapping_areas():
		if charackter.is_on_floor():
			if x_direction != 0:
				state_machine._change_state("move")
			else:
				state_machine._change_state("idle")
		else:
			charackter.velocity.y = 0
			state_machine._change_state("jump")
