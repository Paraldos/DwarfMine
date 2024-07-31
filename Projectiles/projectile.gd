extends Hitbox

@export var phases_through_objects = false
@onready var sprite_2d = $Sprite2D
var velocity = 150

func _ready():
	sprite_2d.flip_h = velocity <= 0

func _process(delta):
	position.x += velocity * delta

func _on_area_entered(area):
	if !phases_through_objects:
		queue_free()

func _on_body_entered(body):
	if !phases_through_objects:
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
