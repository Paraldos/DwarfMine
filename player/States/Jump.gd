extends State

@onready var ladder_timer: Timer = %LadderTimer

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
	if (Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down")) and charackter.ladder_scanner.get_overlapping_areas():
		if ladder_timer.is_stopped():
			state_machine._change_state("climbing")
	charackter._gravity(delta)

func _enter() -> void:
	super._enter()
	ladder_timer.start()
