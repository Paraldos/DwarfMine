extends Node2D

@onready var sprite_2d = %Sprite2D
@onready var treasure_spawner = $TreasureSpawner

func _on_hurt_box_hit(dmg):
	if sprite_2d.frame == 0:
		_open()

func _on_interaction_area_interacted():
	_open()

func _open():
	sprite_2d.frame += 1
	treasure_spawner._spawn_treasure()
