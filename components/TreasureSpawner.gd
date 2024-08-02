extends Node
class_name TreasureSpawner

enum TreasureSize { SMALL, MEDIUM, BIG }
@export var treasure_size: TreasureSize = TreasureSize.SMALL
var pickup = preload("res://World/Pickup/pickup.tscn")
var rng = RandomNumberGenerator.new()

func _spawn_treasure():
	rng.randomize()
	var treasure = []
	for i in treasure_size +1:
		_spawn_pickup()

func _spawn_pickup():
	var newPickup = pickup.instantiate()
	newPickup.global_position = get_parent().global_position
	newPickup.velocity.x = rng.randi_range(-150, 150)
	newPickup.velocity.y = rng.randi_range(-120, -80)
	call_deferred("_add_pickup_to_scene", newPickup)

func _add_pickup_to_scene(newPickup):
	get_tree().current_scene.add_child(newPickup)
