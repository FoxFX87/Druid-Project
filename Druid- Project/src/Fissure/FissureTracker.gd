extends Node2D

# Tracks all fissures unsealed

signal _all_fissures_sealed
signal _get_fissure_count(value)
var fissure_count : int setget _set_fissure_count

func _ready():
	fissure_count = get_child_count()

func _process(_delta):
	for fissure in get_children():
		if fissure.visible == false:
			fissure_count -= 1

func _set_fissure_count(value : int):
	fissure_count = value
	emit_signal("_get_fissure_count", fissure_count)
	
	if fissure_count <= 0:
		emit_signal("_all_fissures_sealed")
