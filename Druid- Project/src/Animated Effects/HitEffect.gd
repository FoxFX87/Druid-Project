extends Node2D

func _on_EffectAnimation_animation_finished(_anim_name):
	queue_free()