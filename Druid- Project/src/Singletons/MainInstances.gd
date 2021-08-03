extends Node

var player = null
var camera : Camera2D = null
var plant_seed = null setget _set_seed, _get_seed

enum SEED {RED, BLUE}
signal _seed_set(value)

func _set_new_seed():
	plant_seed = SEED.RED

func _consume_seed():
	plant_seed = null

func _set_seed(value):
	plant_seed = value
	emit_signal("_seed_set", plant_seed)

func _get_seed():
	return plant_seed
