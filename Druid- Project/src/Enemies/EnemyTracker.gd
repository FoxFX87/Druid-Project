extends Node2D
# Tracks all enemies under as a child node and emits a signal
# if all children are done

signal _all_enemies_defeated
var enemy_count : int 

func _ready():
	enemy_count = get_child_count()

func _process(_delta):
	enemy_count = get_child_count()
	
	if enemy_count <= 0:
		emit_signal("_all_enemies_defeated")
