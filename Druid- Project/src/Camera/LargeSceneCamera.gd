extends Camera2D

const SCREEN_SIZE := Vector2(320, 180)
var target

func _ready():
	set_as_toplevel( true )
	target = MainInstances.player

func _process(_delta):
	var _pos = target.global_position
	var _x = floor(_pos.x / SCREEN_SIZE.x) * SCREEN_SIZE.x
	var _y = floor(_pos.y / SCREEN_SIZE.y) * SCREEN_SIZE.y
	global_position = Vector2(_x, _y)
