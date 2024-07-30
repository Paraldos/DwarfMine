extends State

@export var jump_state: State
@export var move_state: State

func _enter() -> void:
	super._enter()
	charackter.velocity.x = 0

func _input(event):
	if Input.is_action_just_pressed("ui_jump") and charackter.is_on_floor():
		return jump_state
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		return move_state
	return null

func _physics_process(delta):
	charackter.velocity.y += charackter.gravity * delta
	charackter.move_and_slide()
	if !charackter.is_on_floor():
		return jump_state
	return null
