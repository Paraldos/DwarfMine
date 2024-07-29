extends Node2D

var arrow = preload("res://Projectiles/projectile.tscn")

func _attack(flip_h):
	var newArrow = arrow.instantiate()
	newArrow.global_position = global_position
	if flip_h:
		newArrow.speed *= -1
	get_tree().current_scene.add_child(newArrow)
