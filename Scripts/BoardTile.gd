extends Node2D
class_name BoardTile

# Emitted when Piece is removed from this tile
signal remove_piece
# Emitted when a new Piece is added to this tile
signal add_piece

# sprites for red and gray pieces
const gray_piece_tex = preload("res://gameAssets/gray_piece.png")
const red_piece_tex = preload("res://gameAssets/red_piece.png")

# Data Structure for Piece node that this tile is holding
var piece = {
	"exists": false,
	"piece": null # class piece
}

func _ready():
	pass

func get_tile_pos() -> Vector2:
	return position

func set_tile_pos(new_position: Vector2, sprite_texture: Texture) -> void:
	get_node("Piece").set_texture(sprite_texture);
	position = new_position
	
func remove_piece() -> void:
	piece["exists"] = false
	piece["piece"] = null
	
	emit_signal("remove_piece")
	
func set_piece(piece) -> void:
	piece["exists"] = true
	piece["piece"] = piece
	
	emit_signal("add_piece")
