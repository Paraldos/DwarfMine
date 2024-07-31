extends State

@export var idle_state: State
@export var move_state: State
@export var axe_state: State

func _state_physics_process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	charackter.velocity.x = direction * charackter.SPEED
	if charackter.is_on_floor():
		if direction != 0:
			state_machine._change_state(move_state)
		else:
			state_machine._change_state(idle_state)
	if Input.is_action_just_pressed("attack"):
		state_machine._change_state(axe_state)
	charackter._gravity(delta)
