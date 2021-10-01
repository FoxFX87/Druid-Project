extends Area2D
class_name Fissure

signal _sealed()

func _on_Fissure_area_entered(_area : Block):
	visible = false
	set_collision_layer_bit(0, true)
	emit_signal("_sealed")
	
	pass # Replace with function body.
