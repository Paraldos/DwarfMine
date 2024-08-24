extends TextureRect

@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var point_light_2d: PointLight2D = $PointLight2D
const SPIKES = preload("res://assets/images/Spikes.png")
const LAVA = preload("res://world/danger_zone/lava.tres")
const ACID = preload("res://world/danger_zone/acid.tres")
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	_init_image()
	_init_shape()
	_init_light()

func _init_image():
	match rng.randi_range(0, 2):
		0:
			texture = SPIKES
			point_light_2d.queue_free()
		1:
			texture = LAVA
			point_light_2d.color = Color("ff001f")
		2:
			texture = ACID
			point_light_2d.color = Color("00cc00")

func _init_shape():
	collision_shape_2d.shape = RectangleShape2D.new()
	collision_shape_2d.shape.size = size
	collision_shape_2d.shape.size.y -= 2
	collision_shape_2d.position.x = size.x / 2
	collision_shape_2d.position.y += 1

func _init_light():
	point_light_2d.position = size / 2
	point_light_2d.scale.x = size.x / 8
