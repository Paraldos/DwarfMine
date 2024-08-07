extends CanvasLayer

@onready var loading_label = %LoadingLabel
var progress = []
var scene_load_status = 0

#func _ready():
	#ResourceLoader.load_threaded_request("res://World/world.tscn")

#func _process(delta):
	#scene_load_status = ResourceLoader.load_threaded_get_status("res://World/world.tscn", progress)
	#loading_label.text = str(floor(progress[0]*100)) + "%"
	#if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		#var newScene = ResourceLoader.load_threaded_get("res://World/world.tscn")
		#get_tree().change_scene_to_packed(newScene)
