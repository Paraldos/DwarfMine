extends Node2D
class_name FXSpawner

@export var effect : PackedScene

func _ready():
	self.tree_exiting.connect(_on_tree_exiting)

func _on_tree_exiting():
	_spawn()

func _spawn():
	var new_effect = effect.instantiate()
	new_effect.global_position = global_position
	get_tree().current_scene.call_deferred("add_child", new_effect)
	new_effect.emitting = true
