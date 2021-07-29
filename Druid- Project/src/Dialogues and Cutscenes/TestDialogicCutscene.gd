extends Node2D

func _ready():
	pass

func _on_DialogNode_timeline_end(_timeline_name):
	var _next_scene = get_tree().change_scene("res://src/Test Scenes/Stages/StageOne.tscn")
	pass # Replace with function body.
