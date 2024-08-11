extends TextureRect

@onready var collision_shape_2d = $Area2D/CollisionShape2D

func _ready():
	collision_shape_2d.shape = collision_shape_2d.shape.duplicate()
	collision_shape_2d.position = size /2
	collision_shape_2d.shape.size.y = size.y
