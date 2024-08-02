extends Sprite2D

signal attack_animation_finished
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree["parameters/playback"]

func _ready():
	animation_tree.active = true

func _change_animation(new_animation):
	state_machine.travel(new_animation)

func _set_direction(velocity):
	animation_tree.set("parameters/Jump/blend_position", velocity.y / 50)

func _attack_finished():
	attack_animation_finished.emit()
