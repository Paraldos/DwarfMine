extends Node

@onready var player_sprite = %PlayerSprite
@onready var hitbox = %Hitbox
@onready var muzzle = %Muzzle
var facing_left = false

func _set_direction(delta, velocity):
	if velocity.x != 0:
		facing_left = velocity.x <= 0
	player_sprite.flip_h = facing_left
	player_sprite._set_direction(velocity)
	for child in [hitbox, muzzle]:
		child.scale.x = -1 if (facing_left) else 1
	return facing_left
