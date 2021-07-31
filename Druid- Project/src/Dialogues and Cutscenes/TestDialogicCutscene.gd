extends Control

export (PackedScene) var next_stage

onready var trans = $TransitionScene

func _ready():
	pass

func _on_DialogNode_timeline_end(_timeline_name):
	if next_stage != null:
		trans.change_scene(next_stage)
