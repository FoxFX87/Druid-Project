extends CanvasLayer

onready var fissure_label = $Control/ObjectiveRect/VBoxContainer/FissureLabel
onready var enemy_label = $Control/ObjectiveRect/VBoxContainer/EnemyLabel
onready var objective_anim = $Control/ObjectiveRect/ObjectiveAnimation

func _set_display_fissure(value : int):
	fissure_label.text = "Fissures Sealed : " + str(value)

func _set_display_enemies(value : int):
	enemy_label.text = "Enemies Left : " + str(value)

func _clear_objective_ui():
	objective_anim.play("PopAway")
