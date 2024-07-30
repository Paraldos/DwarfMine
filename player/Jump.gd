extends State

@export var idle_state: State
@export var move_state: State
@export var jump_force: float = 130.0

func _enter():
	super._enter()
	charackter.velocity.y = -jump_force

func _physics_process(delta):
	charackter.velocity.y += gravity * delta
	var movement = Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right") * move_speed
	if movement != 0:
		charackter.player_animation.flip_h = movement < 0
	charackter.velocity.x = movement
	charackter.move_and_slide()
	if charackter.is_on_floor():
		if movement != 0:
			return move_state
		return idle_state
	return null
