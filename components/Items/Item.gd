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
var item_quality : int

func _init(Title, Icon, Type = ""):
	rng.randomize()
	title = Title
	icon = Icon
	type = Type

func _set_dmg(dmg, dmg_type):
	self.dmg = dmg
	self.dmg_type = dmg_type

func _get_item_color():
	if item_quality == ItemQuality.NORMAL:
		return Color("#9e9e9e")
	elif item_quality == ItemQuality.RARE:
		return Color("#738ffe")
	else:
		return Color("#ffee58")

func _randomize():
	var quality_rng = rng.randi_range(0, 100)
	if quality_rng < 50:
		item_quality = ItemQuality.NORMAL
	elif quality_rng < 80:
		item_quality = ItemQuality.RARE
	else:
		item_quality = ItemQuality.MAGIC
