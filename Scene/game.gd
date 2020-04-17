extends Node2D
class_name Board

const BOARD_DIMENSIONS = [  0, 1, 0, 1, 0, 1, 0, 1,
							1, 0, 1, 0, 1, 0, 1, 0,
							0, 1, 0, 1, 0, 1, 0, 1,
							0, 0, 0, 0, 0, 0, 0, 0,
							0, 0, 0, 0, 0, 0, 0, 0, 
							1, 0, 1, 0, 1, 0, 1, 0,
							0, 1, 0, 1, 0, 1, 0, 1,
							1, 0, 1, 0, 1, 0, 1, 0  ]

func _ready():
	generate_tiles()
	
func generate_tiles() -> void:
	var col = 0
	var row = 0

	for sizeCount in range(BOARD_DIMENSIONS.size()):
		var new_tile = load("res://Prefabs/BoardTile.tscn").instance()
		if BOARD_DIMENSIONS[sizeCount] == 1:
			var tile_position = (Vector2(sizeCount % 8 + 0.0625, sizeCount / 8 + 0.0625)) * 32
			add_child(new_tile)
			if sizeCount < 32:
				new_tile.set_tile_pos(tile_position, new_tile.red_piece_tex)
			else:
				new_tile.set_tile_pos(tile_position, new_tile.gray_piece_tex)
	
