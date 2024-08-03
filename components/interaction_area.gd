extends Area2D

signal interacted
signal in_focus
@export var cooldown = 0.0
@onready var label = $Label
var player_inside = false
var focus = false
var can_be_picked_up = false

func _ready():
	modulate = Color(1, 1, 1, 0)
	if cooldown > 0:
		_change_status(false)
		await get_tree().create_timer(cooldown).timeout
		_change_status(true)

func _physics_process(delta):
	if !player_inside: return
	if Utils.interactables[-1] == self:
		focus = true
		in_focus.emit()
	else:
		focus = false
		_tween_modulate(Color("#ffffff00"))

func _change_message_and_color(new_message = "Press Y to interact", new_color = Color("#ffffff")):
	label.text = new_message
	_tween_modulate(new_color)

func _input(event):
	if event.is_action_pressed("interact") and player_inside and focus:
		interacted.emit()

func _tween_modulate(target_color):
	var tween = create_tween()
	tween.tween_property(self, "modulate", target_color, 0.2)

func _change_status(new_status):
	monitoring = new_status

func _on_body_entered(body):
	Utils.interactables.push_back(self)
	player_inside = true

func _on_body_exited(body):
	Utils.interactables.erase(self)
	player_inside = false
	focus = false
	_tween_modulate(Color("#ffffff00"))
