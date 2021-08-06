extends Area2D
class_name Fissure

signal _fissure_sealed

#onready var sfx = $SealedSFX

func _on_Fissure_area_entered(area):
	if area.is_in_group("Push"):
		set_collision_layer_bit(0, true)
		visible = false
		emit_signal("_fissure_sealed")
		#sfx.play(0.2)
		
		var c = PreloadedScenes.EFFECTS["fissure collapse"].instance()
		c.position = global_position
		c.rotation_degrees = rand_range(0.0, 359.0)
		get_parent().add_child(c)
		
		var p = PreloadedScenes.EFFECTS["poof"].instance()
		p.position = global_position
		get_parent().add_child(p)
		p.z_index = c.z_index
