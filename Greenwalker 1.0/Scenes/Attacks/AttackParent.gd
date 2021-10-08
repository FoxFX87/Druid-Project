extends Area2D
class_name Attack

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
