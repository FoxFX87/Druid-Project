extends Node

func _play(track = null):
	if track:
		get_node(track).play()
