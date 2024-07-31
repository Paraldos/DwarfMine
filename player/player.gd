extends CharacterBody2D

@export var SPEED = 80.0
@export var JUMP_POWER = -140.0
@onready var state_machine = $StateMachine
@onready var hitbox = %Hitbox
@onready var player_sprite = %PlayerSprite
@onready var muzzle = $Muzzle
var inventory = preload("res://Menus/Inventory/inventory.tscn")
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var facing_left = false

func _ready():
	Utils.player = self
	state_machine.init(self)

func _physics_process(delta):
	state_machine._state_physics_process(delta)
	_set_direction(velocity)
	move_and_slide()
	if Input.is_action_just_pressed("inventory"):
		var new_inventory_screen = inventory.instantiate()
		get_tree().current_scene.add_child(new_inventory_screen)

func _set_direction(velocity):
	if velocity.x != 0:
		facing_left = velocity.x <= 0
	player_sprite.flip_h = facing_left
	player_sprite._set_direction(velocity)
	for child in [hitbox, muzzle]:
		child.scale.x = -1 if (facing_left) else 1

func _change_animation(animation_name):
	player_sprite._change_animation(animation_name)

func _gravity(delta):
	velocity.y += gravity * delta
