extends Area2D
class_name HurtBox

signal hit(dmg)

func _ready():
	connect("area_entered", _on_HurtBox_area_entered)

func _on_HurtBox_area_entered(hitbox : Hitbox):
	hit.emit(hitbox.dmg)