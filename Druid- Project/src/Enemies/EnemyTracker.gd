extends Node2D
# Tracks all enemies under as a child node and emits a signal
# if all children are done

signal _all_enemies_defeated
var enemy_count : int setget _set_enemy_count

func _ready():
	enemy_count = get_child_count()

func _process(_delta):
	enemy_count = get_child_count()

func _set_enemy_count(value : int):
	enemy_count = value
	
	if enemy_count == 0:
		print("done")
		emit_signal("_all_enemies_defeated")
