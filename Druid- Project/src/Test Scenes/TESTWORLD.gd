extends Node2D

onready var fissures = $Fissures
onready var enemies = $Enemies
onready var ui = $UI
onready var trans = $TransitionScene

export (PackedScene) var next_stage

var unsealed_count 
var enemy_count

func _ready():
	
	unsealed_count = fissures.get_child_count()
	enemy_count = enemies.get_child_count()
	
	if unsealed_count != 0:
		ui._set_display_fissure(unsealed_count)
		for fissure in fissures.get_children():
			fissure.connect("_fissure_sealed", self, "_check_fissures")
	else:
		ui._destroy_fissure_ui()
		
	if enemy_count != 0:
		ui._set_display_enemies(enemy_count)
		for enemy in enemies.get_children():
			enemy.connect("_died", self, "_check_enemies")
	else:
		ui._destroy_enemy_ui()
		
		
func _check_fissures():
	unsealed_count -= 1
	ui._set_display_fissure(unsealed_count)
	_check_level_complete()

func _check_enemies():
	enemy_count -= 1
	ui._set_display_enemies(enemy_count)
	_check_level_complete()

func _check_level_complete():
	if unsealed_count == 0 and enemy_count == 0:
		ui._clear_objective_ui()
		if next_stage != null:
			trans.change_scene(next_stage)
			#var _new_stage = get_tree().change_scene_to(next_stage)
