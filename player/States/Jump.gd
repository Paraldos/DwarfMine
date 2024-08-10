extends State

func _state_physics_process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	charackter.velocity.x = direction * charackter.SPEED
	if charackter.is_on_floor():
		if direction != 0:
			state_machine._change_state("move")
		else:
			state_machine._change_state("idle")
	if Input.is_action_just_pressed("attack"):
		state_machine._change_state("attack")
	if Input.is_action_just_pressed("ui_up") and charackter.ladder_scanner.get_overlapping_areas():
		state_machine._change_state("climbing")
	charackter._gravity(delta)
