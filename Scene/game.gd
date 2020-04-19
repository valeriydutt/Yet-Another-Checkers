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

var selected_tile = null

# Coefficient to center our pieces within tiles 
const CENTRE_COEF  = (1 - PIECE_SIZE / TILE_SIZE) / 2

func _ready():
	init_tiles()
	generate_pieces()
	#move(BOARD[23].piece, BOARD[30].coordinate)
	select_tile(Vector2(32, 15))

func generate_pieces() -> void:
	for count in range(BOARD.size()):
		if BOARD[count].havePiece:
			BOARD[count].piece = load("res://Prefabs/BoardTile.tscn").instance()
			
			if count < BOARD.size() / 2:
				BOARD[count].piece.set_tile_pos(BOARD[count].coordinate, BOARD[count].piece.red_piece_tex)
			else:
				BOARD[count].piece.set_tile_pos(BOARD[count].coordinate, BOARD[count].piece.gray_piece_tex)
			
			add_child(BOARD[count].piece)

func init_tiles() -> void:
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

func move_possible(piece, new_position) -> bool:
	# Check if current tile has a piece
	if piece == null:
		return false
	
	# Check if new tile has a piece
	if(BOARD[(new_position.x - 2) / 32 + ((new_position.y - 2) / 32) * 8].havePiece == true):
		return false
	
	# Check if move is to one tile diagonally 
	if (abs(new_position.x - piece.get_tile_pos().x) == TILE_SIZE &&
			abs(new_position.y - piece.get_tile_pos().y) == TILE_SIZE):
		return true
		
	return false

func select_tile(tile_coordinates):
	for i in range(BOARD.size()):
		if (BOARD[i].coordinate.x - 2 <= tile_coordinates.x && BOARD[i].coordinate.x + 30 > tile_coordinates.x &&
			BOARD[i].coordinate.y - 2 <= tile_coordinates.y && BOARD[i].coordinate.y + 30 > tile_coordinates.y):
				return BOARD[i]
	return null

func _input(event):
	if event is InputEventMouseButton && event.is_pressed():
		if selected_tile != null:
			if(move_possible(selected_tile.piece, select_tile(event.position).coordinate)):
				selected_tile.havePiece = false;
				selected_tile.piece.set_position(select_tile(event.position).coordinate)
				select_tile(event.position).havePiece = true;
				select_tile(event.position).piece = selected_tile.piece;
			
			selected_tile = null;
		else:
			selected_tile = select_tile(event.position)
