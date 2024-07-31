extends State

@export var jump_state: State
@export var move_state: State
@export var axe_state: State

func _enter() -> void:
	super._enter()
	charackter.velocity.x = 0

func _state_physics_process(delta):
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		state_machine._change_state(move_state)
	if Input.is_action_just_pressed("jump") and charackter.is_on_floor():
		charackter.velocity.y = charackter.JUMP_POWER
		state_machine._change_state(jump_state)
	if Input.is_action_just_pressed("attack"):
		state_machine._change_state(axe_state)
	if not charackter.is_on_floor():
		state_machine._change_state(jump_state)
	charackter._gravity(delta)
