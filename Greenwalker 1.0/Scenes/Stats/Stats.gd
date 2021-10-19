extends Node
class_name Stats

export (int, 1, 10) var max_health

var health = max_health setget _set_health

signal _health_changed(value)
signal _died()

func _ready():
	health = max_health

func _set_health(value):
	
	health = clamp(value, 0, max_health)
	emit_signal("_health_changed", health)
	
	if health <= 0:
		emit_signal("_died")

