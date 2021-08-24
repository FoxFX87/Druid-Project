extends Node

var current_track = null

func _play(track = null):
	if track:
		
		if current_track != track:
			current_track = track
			get_node(track).play()
		else:
			return
