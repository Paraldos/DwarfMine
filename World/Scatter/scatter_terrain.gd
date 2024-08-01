extends Node2D

var rng = RandomNumberGenerator.new()
@onready var sprite_2d = $Sprite2D

func _ready():
	rng.randomize()
	sprite_2d.frame = rng.randi_range(0, sprite_2d.hframes -1)
	sprite_2d.flip_h = rng.randi_range(0, 1) > 0;
