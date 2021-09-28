extends Area2D
class_name Unit

var tile_size = Global.CELL_SIZE

func _ready():
	self.position = self.position.snapped(Vector2.ONE * tile_size)
	self.position -= Vector2.ONE * tile_size/2
