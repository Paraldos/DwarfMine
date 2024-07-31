extends Sprite2D

signal attack_animation_finished
signal spawn_arrow
@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree["parameters/playback"]
@onready var attack_bow = $AttackBow

func _ready():
	animation_tree.active = true

func _change_animation(new_animation):
	state_machine.travel(new_animation)

func _change_direction(velocity):
	if velocity.x != 0:
		flip_h = velocity.x <= 0
	animation_tree.set("parameters/Jump/blend_position", velocity.y / 50)

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == "Axe" or anim_name == "Bow":
		attack_animation_finished.emit()
