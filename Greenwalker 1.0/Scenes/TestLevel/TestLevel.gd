extends Node2D

onready var enemies = $WorldYSort/Enemies
onready var enemy_ui_count = $UI/UI/EnemyCountUI/Label

var enemy_count : int = 0

func _ready():
	for enemy in enemies.get_child_count():
		enemies.get_child(enemy).connect("_died", self, "update_ui_count")
		enemy_count += 1
		
	enemy_ui_count.text = str(enemy_count)

func update_ui_count():
	enemy_count -= 1
	enemy_ui_count.text = str(enemy_count)
