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
	init_board()
	generate_pieces()
	
func generate_pieces() -> void:
	for count in range(BOARD.size()):
		if BOARD[count].havePiece:
			BOARD[count].piece = load("res://Prefabs/BoardTile.tscn").instance()
			
			add_child(BOARD[count].piece)
			
			if count < BOARD.size() / 2:
				BOARD[count].piece.set_tile_pos(BOARD[count].coordinate, BOARD[count].piece.red_piece_tex)
			else:
				BOARD[count].piece.set_tile_pos(BOARD[count].coordinate, BOARD[count].piece.gray_piece_tex)
	
func init_board() -> void:
	for count in range(BOARD.size()):
		if BOARD[count] == 1:
			BOARD[count] = {
				"piece": null,
				"coordinate": Vector2(count % BOARD_SIZE + CENTRE_COEF, count / BOARD_SIZE + CENTRE_COEF) * TILE_SIZE,
				"havePiece": true
			}
		else:
			BOARD[count] = {
				"piece": null,
				"coordinate": Vector2(count % BOARD_SIZE + CENTRE_COEF, count / BOARD_SIZE + CENTRE_COEF) * TILE_SIZE,
				"havePiece": false
			}

func move(piece, new_position) -> void:
	piece.set_position(new_position)
