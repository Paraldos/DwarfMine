extends Node
class_name StateMachine

@export var starting_state = "idle"
@export var current_state : State
@export var idle_state: State
@export var move_state: State
@export var jump_state: State
@export var axe_state: State
@export var hammer_state: State
@export var bow_state: State
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

func _change_state(new_state: String):
	if current_state:
		current_state.exit()
	match new_state:
		"idle":
			current_state = idle_state
		"move":
			current_state = move_state
		"jump":
			current_state = jump_state
		"attack":
			var weapon_title = Utils._get_current_weapon().title
			if "Axe" in weapon_title:
				current_state = axe_state
			elif "Bow" in weapon_title:
				current_state = bow_state
			elif "Hammer" in weapon_title:
				current_state = hammer_state
	current_state._enter()
