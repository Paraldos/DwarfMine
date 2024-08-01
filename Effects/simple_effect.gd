extends CPUParticles2D

func _ready():
	emitting = true
	self.finished.connect(_on_finished)

func _on_finished():
	queue_free()
