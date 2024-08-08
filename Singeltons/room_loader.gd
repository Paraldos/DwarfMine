extends Node

var rooms = {
	"bottom": [
		preload("res://world/rooms/bottom.tscn"),
	],
	"bottom_left": [
		preload("res://world/rooms/bottom_left.tscn"),
	],
	"left": [
		preload("res://world/rooms/left.tscn"),
	],
	"right": [
		preload("res://world/rooms/right.tscn"),
	],
	"right_bottom": [
		preload("res://world/rooms/right_bottom.tscn"),
	],
	"right_left": [
		preload("res://world/rooms/right_left.tscn"),
	],
	"top": [
		preload("res://world/rooms/top.tscn"),
	],
	"top_bottom": [
		preload("res://world/rooms/top_bottom.tscn"),
	],
	"top_bottom_left": [
		preload("res://world/rooms/top_bottom_left.tscn"),
	],
	"top_left": [
		preload("res://world/rooms/top_left.tscn"),
	],
	"top_right": [
		preload("res://world/rooms/top_right.tscn"),
	],
	"top_right_bottom": [
		preload("res://world/rooms/top_right_bottom.tscn"),
	],
	"top_right_left": [
		preload("res://world/rooms/top_right_left.tscn"),
	],
	"top_right_bottom_left": [
		preload("res://world/rooms/top_right_bottom_left.tscn"),
	],
}

func _get_room(top = false, right = false, bottom = false, left = false):
	var room_name = ""
	if top:
		room_name += "top"
	if right:
		if room_name != "":
			room_name += "_"
		room_name += "right"
	if bottom:
		if room_name != "":
			room_name += "_"
		room_name += "bottom"
	if left:
		if room_name != "":
			room_name += "_"
		room_name += "left"
	return rooms[room_name]
