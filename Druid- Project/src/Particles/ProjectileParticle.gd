extends Node2D

func _on_AnimationPlayer_animation_started(anim_name):
	if anim_name == "Fade":
		SfxLibrary._play("SpellImpact002")
