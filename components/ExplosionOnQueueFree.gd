extends Node
class_name ExplosionOnQueueFree

@export var effect : PackedScene

func _on_tree_exiting():
	var new_effect = effect.instantiate()
	new_effect.global_position = get_parent().global_position
	get_tree().current_scene.call_deferred("add_child", new_effect)
	new_effect.emitting = true
