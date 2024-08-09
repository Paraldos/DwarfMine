extends Node
class_name Room

var type = 0
var cell = Vector2.ZERO
var neighbors = {
	top = {
		occupied = false,
		cell = Vector2.ZERO,
		door = false
	},
	right = {
		occupied = false,
		cell = Vector2.ZERO,
		door = false
	},
	bottom = {
		occupied = false,
		cell = Vector2.ZERO,
		door = false
	},
	left = {
		occupied = false,
		cell = Vector2.ZERO,
		door = false
	}
}

func _init(Type = 0, Cell = Vector2.ZERO, Map = []):
	type = Type
	cell = Cell
	_init_neighbors_cells()
	Utils.room__update_neighbours.connect(_on_room__update_neighbours)

func _init_neighbors_cells():
	neighbors.top.cell = cell + Vector2(0, -1)
	neighbors.right.cell = cell + Vector2(1, 0)
	neighbors.bottom.cell = cell + Vector2(0, 1)
	neighbors.left.cell = cell + Vector2(-1, 0)

func _get_next_room():
	var possible_directions = []
	#if cell.y > 0 and not neighbors.top:
	#    possible_directions.append(["top", neighbors_cells.top])
	if cell.y < MapGenerator.map_size.y - 1 and not neighbors.bottom.occupied:
		possible_directions.append(["bottom", neighbors.bottom.cell])
	if cell.x < MapGenerator.map_size.x - 1 and not neighbors.rightoccupied:
		for i in range(2):
			possible_directions.append(["right", neighbors.right.cell])
	if cell.x > 0 and not neighbors.leftoccupied:
		for i in range(2):
			possible_directions.append(["left", neighbors.left.cell])
	possible_directions.shuffle()
	neighbors[possible_directions[0][0]].occupied = true
	return possible_directions[0]

func _on_room__update_neighbours(map):
	# top / bottom
	if neighbors.top.cell.y >= 0 and neighbors.bottom.cell.y <= map.size():
		neighbors.top.occupied = map[neighbors.top.cell.y][neighbors.top.cell.x] != 0
		neighbors.bottom = map[neighbors.bottom.cell.y][neighbors.bottom.cell.x] != 0
	# left / right
	if neighbors.left.cell.x >= 0 and neighbors.right.cell.x <= map[0].size():
		neighbors.left.occupied = map[neighbors.left.cell.y][neighbors.left.cell.x] != 0
		neighbors.right.occupied = map[neighbors.right.cell.y][neighbors.right.cell.x] != 0
