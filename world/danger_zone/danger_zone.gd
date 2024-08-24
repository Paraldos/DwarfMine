extends TextureRect

@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var point_light_2d: PointLight2D = $PointLight2D

func _ready() -> void:
	_init_shape()
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
