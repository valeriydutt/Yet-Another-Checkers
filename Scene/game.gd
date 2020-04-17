extends Node2D
class_name Board

const BOARD = [ 0, 1, 0, 1, 0, 1, 0, 1,
				1, 0, 1, 0, 1, 0, 1, 0,
				0, 1, 0, 1, 0, 1, 0, 1,
				0, 0, 0, 0, 0, 0, 0, 0,
				0, 0, 0, 0, 0, 0, 0, 0, 
				1, 0, 1, 0, 1, 0, 1, 0,
				0, 1, 0, 1, 0, 1, 0, 1,
				1, 0, 1, 0, 1, 0, 1, 0 ]

# both width and height are the same
const TILE_SIZE = 32.0
const PIECE_SIZE = 28.0
const BOARD_SIZE = 8

# Coefficient to center our pieces within tiles 
const CENTRE_COEF  = (1 - PIECE_SIZE / TILE_SIZE) / 2

func _ready():
	generate_tiles()
	
func generate_tiles() -> void:
	for count in range(BOARD.size()):
		
		var new_tile = load("res://Prefabs/BoardTile.tscn").instance()
		
		if BOARD[count] == 1:
			var tile_position = Vector2(count % BOARD_SIZE + CENTRE_COEF, count / BOARD_SIZE + CENTRE_COEF) * TILE_SIZE
			add_child(new_tile)
			
			if count < BOARD.size() / 2:
				new_tile.set_tile_pos(tile_position, new_tile.red_piece_tex)
			else:
				new_tile.set_tile_pos(tile_position, new_tile.gray_piece_tex)
	
