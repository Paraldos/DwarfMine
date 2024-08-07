extends Node

var rooms = {
    "top": [],
    "right": [],
    "bottom": [],
    "left": [],
    "top_right": [],
    "top_bottom": [],
    "top_left": [],
    "right_bottom": [],
    "right_left": [],
    "bottom_left": [],
    "top_right_bottom": [],
    "top_right_left": [],
    "top_bottom_left": [],
    "right_bottom_left": [],
    "top_right_bottom_left": []
}

func _get_room(top, right, bottom, left):
	return rooms[str(top) + str(right) + str(bottom) + str(left)]