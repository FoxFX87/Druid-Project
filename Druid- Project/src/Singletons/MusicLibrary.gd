extends Node

var current_track = null
var previous_track = null

func _process(_delta):
	if previous_track != null:
		get_node(previous_track).stop()

func _play(track = null):
	if track:
		
		if current_track != track:
			previous_track = current_track
			current_track = track
			get_node(current_track).play()
		else:
			return
