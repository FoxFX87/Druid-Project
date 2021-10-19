extends Area2D
class_name Attack

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()

func _on_Attack_area_entered(area : Unit):
	
	if area.is_in_group("enemy"):
		area.stats.health -= 1
