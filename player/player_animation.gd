extends Sprite2D

@onready var animation_player = $AnimationPlayer
@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree["parameters/playback"]
@onready var attack_bow = $AttackBow

func _ready():
	animation_tree.active = true
	_change_weapon(get_parent().current_weapon)

func _change_animation(new_state, direction):
	_change_x_direction(direction.x)
	_change_y_direction(direction.y)
	if state_machine.get_current_node() == new_state:
		return
	else:
		state_machine.travel(new_state)

func _change_x_direction(x_dir):
	if x_dir == 0: return
	flip_h = x_dir <= 0

func _change_y_direction(y_dir):
	if y_dir == 0: return
	animation_tree.set("parameters/Jump/blend_position", y_dir / 50)

func _change_weapon(new_weapon):
	if new_weapon == "Bow":
		animation_tree.set("parameters/Attack/blend_position", 1)
	else:
		animation_tree.set("parameters/Attack/blend_position", -1)

func _emit_attack_signal():
	attack_bow._attack(flip_h)
