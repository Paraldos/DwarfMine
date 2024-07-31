extends Node
class_name Item

var title = "Item"
var icon = null
var type = ""
var amount = 1
var max_amount = 1

func _init(Title, Icon, Type = "", Amount = 1, MaxAmount = 1):
	title = Title
	icon = Icon
	type = Type
	amount = Amount
	max_amount = MaxAmount
