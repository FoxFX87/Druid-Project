extends Node

# Contains lists of scenes an object can instance
onready var ATTACKWIND 		=  preload("res://Scenes/Attacks/WindAttack.tscn")
onready var ATTACKGRAVEL 	=  preload("res://Scenes/Attacks/GravelAttack.tscn")
onready var ATTACKWATER 	=  preload("res://Scenes/Attacks/WaterAttack.tscn")

# Specialized function to instance scenes
func _instance_scene_to_main(scene, position : Vector2):
	var _main = get_tree().current_scene
	var _instance = scene.instance()
	_main.add_child(_instance)
	_instance.global_position = position
	return _instance
