extends Node
class_name PlayerStateMachine

@export var current_state : State
@onready var states = get_children()
@onready var charackter = get_parent()

func _ready():
	for state in states:
		state.charackter = charackter
