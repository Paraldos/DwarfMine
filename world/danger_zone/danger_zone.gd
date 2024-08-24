extends TextureRect

@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var point_light_2d: PointLight2D = $PointLight2D
const SPIKES = preload("res://assets/images/Spikes.png")
const LIQUID = preload("res://world/danger_zone/liquid.tres")
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	_init_image()
	_init_shape()

func _init_image():
	texture = null
	match rng.randi_range(0, 2):
		0:
			texture = SPIKES
			modulate = Color("ffffff")
			point_light_2d.queue_free()
		1:
			texture = LIQUID
			modulate = Color("ff6f00")
			point_light_2d.color = Color("ff6f00")
			_init_light()
		2:
			texture = LIQUID
			modulate = Color("42bd41")
			point_light_2d.color = Color("42bd41")
			_init_light()

func _init_shape():
	collision_shape_2d.shape = RectangleShape2D.new()
	collision_shape_2d.shape.size = size
	collision_shape_2d.shape.size.y -= 2
	collision_shape_2d.position.x = size.x / 2
	collision_shape_2d.position.y += 1

func _init_light():
	point_light_2d.position = size / 2
	point_light_2d.scale.x = size.x / 8
