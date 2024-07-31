extends CanvasLayer

func _ready():
	get_tree().paused = true

func _physics_process(delta):
	if Input.is_action_just_pressed("ineventory"):
		queue_free()

func _on_tree_exiting():
	get_tree().paused = false
