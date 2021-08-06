extends Node

func _play(sfx = null):
	if sfx:
		get_node(sfx).play()
	else:
		var c = randi() % get_child_count()
		get_child(c).play()
