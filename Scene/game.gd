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
	move(BOARD[23].piece, BOARD[30].coordinate)

func generate_pieces() -> void:
	for count in range(BOARD.size()):
		if BOARD[count].havePiece:
			BOARD[count].piece = load("res://Prefabs/BoardTile.tscn").instance()
			
			if count < BOARD.size() / 2:
				BOARD[count].piece.set_tile_pos(BOARD[count].coordinate, BOARD[count].piece.red_piece_tex)
			else:
				BOARD[count].piece.set_tile_pos(BOARD[count].coordinate, BOARD[count].piece.gray_piece_tex)
			
			add_child(BOARD[count].piece)

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
	# Check if there is a piece
	if piece == null:
		return
	# Check if tile has a piece
	if(BOARD[(new_position.x - 2) / 32 + ((new_position.y - 2) / 32) * 8].havePiece == true):
		return
	# Check if move is possible
	if (abs(new_position.x - piece.get_tile_pos().x) == TILE_SIZE &&
			new_position.y - piece.get_tile_pos().y == TILE_SIZE): 
		piece.set_position(new_position)
		

