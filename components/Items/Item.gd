extends Node
class_name Item

enum ItemQuality {
	NORMAL,
	RARE,
	MAGIC
}
var rng = RandomNumberGenerator.new()
var title : String
var icon : Texture
var type : String
var dmg : int 
var dmg_type : String
var amount : int
var max_amount : int
var item_quality = ItemQuality.NORMAL
var armor = {
	Piercing = 0,
	Slashing = 0,
	Bashing = 0,
	Fire = 0,
	Ice = 0,
	Lightning = 0
}

func _init(Title, Icon, Type = ""):
	rng.randomize()
	title = Title
	icon = Icon
	type = Type

func _set_dmg(dmg, dmg_type):
	self.dmg = dmg + rng.randi_range(-2, 2)
	self.dmg_type = dmg_type

func _set_armour(piercing, slashing, bashing, fire, ice, lightning):
	armor.Piercing = piercing + rng.randi_range(0, 2)
	armor.Slashing = slashing + rng.randi_range(0, 2)
	armor.Bashing = bashing + rng.randi_range(0, 2)
	armor.Fire = fire + rng.randi_range(0, 2)
	armor.Ice = ice + rng.randi_range(0, 2)
	armor.Lightning = lightning + rng.randi_range(0, 2)

func _get_item_color():
	if item_quality == ItemQuality.NORMAL:
		return Color("#9e9e9e")
	elif item_quality == ItemQuality.RARE:
		return Color("#738ffe")
	else:
		return Color("#ffee58")

func _randomize():
	var quality_rng = rng.randi_range(0, 100)
	if quality_rng < 70:
		title = "Normal  " + title
		item_quality = ItemQuality.NORMAL
	elif quality_rng < 90:
		title = "Rare  " + title
		item_quality = ItemQuality.RARE
	else:
		title = "Magic  " + title
		item_quality = ItemQuality.MAGIC
