extends CharacterBody2D

@onready var sprite_2d = %Sprite2D
@onready var interaction_area = $InteractionArea
var item = null
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	item = LootGenerator._get_randome_item()
	sprite_2d.texture = item.icon
	var material_copy = sprite_2d.material.duplicate()
	sprite_2d.material = material_copy
	sprite_2d.material.set_shader_parameter("color", item._get_item_color())

func _physics_process(delta):
	_gravity_and_friction(delta)
	move_and_slide()

func _gravity_and_friction(delta):
	velocity.x = lerp(velocity.x, 0.0, 0.1)
	velocity.y += gravity * delta

func _on_interaction_area_interacted():
	if InventoryController._player_has_free_inventory_space():
		InventoryController._add_item_to_inventory(item)
		queue_free()

func _on_interaction_area_in_focus():
	if InventoryController._player_has_free_inventory_space():
		interaction_area._change_message_and_color("Press Y to pick up")
	else:
		interaction_area._change_message_and_color("Inventory is full", Color("red"))
