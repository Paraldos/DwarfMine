extends State

@export var idle_state: State
@export var jump_state: State
@export var axe_state: State
@onready var coyote_timer = %CoyoteTimer
var was_on_floor = true

func _state_physics_process(delta):
	var direction = Input.get_axis("ui_left", "ui_right")
	charackter.velocity.x = direction * charackter.SPEED
	if direction == 0:
		state_machine._change_state(idle_state)
	if Input.is_action_just_pressed("jump") and (charackter.is_on_floor() or !coyote_timer.is_stopped()):
		charackter.velocity.y = charackter.JUMP_POWER
		state_machine._change_state(jump_state)
	if Input.is_action_just_pressed("attack"):
		state_machine._change_state(axe_state)
	if !charackter.is_on_floor():
		if was_on_floor:
			was_on_floor = false
			coyote_timer.start()
		if coyote_timer.is_stopped():
			state_machine._change_state(jump_state)
	was_on_floor = charackter.is_on_floor()
	charackter._gravity(delta)
