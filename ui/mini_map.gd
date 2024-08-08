extends PanelContainer

@onready var tile_map = %TileMap
@onready var player_position = $Node2D/PlayerPosition
var map = null

func _ready():
	Utils.build_mini_map.connect(_build_mini_map)
	Utils.update_mini_map.connect(_update_mini_map)

func _build_mini_map():
	map = MapGenerator.map
	for column in map.size():
		for row in map[column].size():
			var cell = Vector2(column, row)
			if map[row][column] != 0:
				tile_map.set_cells_terrain_connect(0, [cell], 0, 0, map[row][column] != 0)

func _update_mini_map(new_player_position):
	player_position.position.x = (new_player_position.x / Utils.room_size.x) * 5
	player_position.position.y = (new_player_position.y / Utils.room_size.y) * 5
