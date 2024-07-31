extends Area2D

var velocity = 150
@onready var sprite_2d = $Sprite2D

func _ready():
	sprite_2d.flip_h = velocity <= 0

func _process(delta):
	position.x += velocity * delta
