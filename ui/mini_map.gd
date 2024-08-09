extends PanelContainer

@onready var tile_map = %TileMap
@onready var player_position = $Node2D/PlayerPosition
var map = null

func _ready():
	Utils.mini_map__create.connect(_on_mini_map__create)
	Utils.mini_map__update.connect(_on_mini_map__update)

func _on_mini_map__create():
	await get_tree().create_timer(0.1, false).timeout
	map = MapGenerator.map
	for column in map.size():
		for row in map[column].size():
			var cell = Vector2(column, row)
			if map[row][column] != 0:
				tile_map.set_cells_terrain_connect(0, [cell], 0, 0, true)
			else:
				tile_map.set_cells_terrain_connect(0, [cell], 0, -1, true)

func _on_mini_map__update(new_player_position):
	player_position.position.x = (new_player_position.x / Utils.room_size.x) * 8
	player_position.position.y = (new_player_position.y / Utils.room_size.y) * 8
