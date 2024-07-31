extends State

func _enter() -> void:
	super._enter()
	charackter.velocity.x = 0

func _state_physics_process(delta):
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		state_machine._change_state("move")
	if Input.is_action_just_pressed("jump") and charackter.is_on_floor():
		charackter.velocity.y = charackter.JUMP_POWER
		state_machine._change_state("jump")
	if Input.is_action_just_pressed("attack"):
		state_machine._change_state("attack")
	if not charackter.is_on_floor():
		state_machine._change_state("jump")
	charackter._gravity(delta)
