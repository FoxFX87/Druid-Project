extends Control

export (PackedScene) var next_stage

onready var trans = $TransitionScene

func _ready():
	var dialog = Dialogic.start('TESTTimeline', false)
	add_child(dialog)
	dialog.connect("timeline_end", self, "_to_next_scene")

func _to_next_scene(_timeline_name):
	if next_stage != null:
		MusicLibrary._play("MainLoop")
		trans.change_scene(next_stage)
