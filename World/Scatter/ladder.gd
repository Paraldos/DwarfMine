extends TextureRect

@onready var collision_shape_ladder: CollisionShape2D = %CollisionShapeLadder
@onready var collision_shape_body: CollisionShape2D = %CollisionShapeBody

func _ready():
	collision_shape_ladder.shape = collision_shape_ladder.shape.duplicate()
	collision_shape_ladder.position = size /2
	collision_shape_ladder.shape.size.y = size.y
	Utils.ladder__disable_top.connect(_on_ladder__disable_top)

func _on_ladder__disable_top(new_status):
	collision_shape_body.disabled = new_status
