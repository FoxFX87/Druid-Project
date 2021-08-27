extends Node

func _play(sfx = null):
	if get_node(sfx) is AudioStreamPlayer:
		get_node(sfx).play()
	else:
		var c = randi() % get_node(sfx).get_child_count()
		get_node(sfx).get_child(c).play()
