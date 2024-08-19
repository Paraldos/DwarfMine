extends State

@onready var coyote_timer = %CoyoteTimer
var was_on_floor = true

func _state_physics_process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	charackter.velocity.x = direction * charackter.SPEED
	if direction == 0:
		state_machine._change_state("idle")
	if (Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down")) and charackter.ladder_scanner.get_overlapping_areas():
		state_machine._change_state("climbing")
	if Input.is_action_just_pressed("jump") and (charackter.is_on_floor() or !coyote_timer.is_stopped()):
		charackter.velocity.y = charackter.JUMP_POWER
		state_machine._change_state("jump")
	if Input.is_action_just_pressed("attack"):
		state_machine._change_state("attack")
	if !charackter.is_on_floor():
		if was_on_floor:
			was_on_floor = false
			coyote_timer.start()
		if coyote_timer.is_stopped():
			state_machine._change_state("jump")
	was_on_floor = charackter.is_on_floor()
	if !charackter.ladder_scanner.get_overlapping_areas():
		charackter._gravity(delta)
