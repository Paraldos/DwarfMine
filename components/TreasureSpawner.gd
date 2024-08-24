extends Node
class_name TreasureSpawner

var pickup = preload("res://world/pickup/pickup.tscn")
var coin = preload("res://world/pickup/coin.tscn")
var rng = RandomNumberGenerator.new()

func _spawn_treasure():
	rng.randomize()
	var treasure = []
	if rng.randi_range(0, 100) < 60:
		_spawn_element(coin.instantiate())
	else:
		_spawn_element(pickup.instantiate())

func _spawn_element(new_element):
	new_element.global_position = get_parent().global_position
	new_element.velocity.x = rng.randi_range(-150, 150)
	new_element.velocity.y = rng.randi_range(-120, -80)
	get_tree().current_scene.add_child(new_element)

func _add_pickup_to_scene(new_element):
	get_tree().current_scene.add_child(new_element)
