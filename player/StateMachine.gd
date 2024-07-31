extends Node
class_name StateMachine

@export var starting_state: State
@export var current_state : State
@onready var state_label = %StateLabel
var states = []

func init(charackter):
	for child in get_children():
		if child is State:
			states.append(child)
			child.charackter = charackter
	_change_state(starting_state)

func _state_physics_process(delta):
	state_label.text = "State: " + current_state.name
	current_state._state_physics_process(delta)

func _change_state(new_state: State):
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state._enter()
