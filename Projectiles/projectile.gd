extends Area2D

var speed = 150
@onready var sprite_2d = $Sprite2D

func _ready():
	sprite_2d.flip_h = speed <= 0

func _process(delta):
	position.x += speed * delta
