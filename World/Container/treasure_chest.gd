extends Node2D

enum TreasureSize { SMALL, MEDIUM, BIG }
@export var treasure_size: TreasureSize = TreasureSize.SMALL
@onready var sprite_2d = %Sprite2D
@onready var treasure_spawner = $TreasureSpawner
@onready var interaction_area = $InteractionArea
@onready var collision_shape_hurtbox = %CollisionShapeHurtbox
@onready var fx_spawner = $FXSpawner

func _ready():
	treasure_spawner.treasure_size = treasure_size

func _on_hurt_box_hit(dmg):
	if sprite_2d.frame == 0:
		call_deferred("_deferred_open")

func _on_interaction_area_interacted():
	call_deferred("_deferred_open")

func _deferred_open():
	collision_shape_hurtbox.disabled = true
	sprite_2d.frame += 1
	interaction_area._change_status(false)
	treasure_spawner._spawn_treasure()
	fx_spawner._spawn()

func _on_interaction_area_in_focus():
	interaction_area._change_message_and_color("Click Y to open chest")
