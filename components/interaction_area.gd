extends Area2D

signal interacted
@export var displayed_text = "Interact"
@onready var label = $Label
@onready var animation_player = $AnimationPlayer
var enabled = true
var player_inside = false

func _ready():
	label.text = "Press Y to " + displayed_text
	label.modulate = Color("#ffffff00")

func _disable():
	enabled = false
	if label.modulate != Color("#ffffff00"):
		animation_player.play_backwards("fade_in")

func _input(event):
	if event.is_action_pressed("interact") and enabled and player_inside:
		interacted.emit()

func _on_body_entered(body):
	if enabled:
		animation_player.play("fade_in")
		player_inside = true

func _on_body_exited(body):
	if enabled:
		animation_player.play_backwards("fade_in")
		player_inside = false
