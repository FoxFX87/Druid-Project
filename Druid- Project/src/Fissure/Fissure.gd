extends Area2D

func _on_Fissure_area_entered(area):
	if area.is_in_group("Push"):
		set_collision_layer_bit(0, true)
