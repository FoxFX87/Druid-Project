extends CanvasLayer

onready var anim = $TransitionAnimation
var next_path

func change_scene(path, delay : float = 0.5):
	next_path = path
	yield(get_tree().create_timer(delay), "timeout")
	anim.play("FadeIn")
	yield(anim, "animation_finished")

func _on_TransitionAnimation_animation_finished(_anim_name):
	assert(get_tree().change_scene_to(next_path) == OK)
