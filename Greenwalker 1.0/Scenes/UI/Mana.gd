extends Control

onready var mana_container = $GridContainer
onready var player_unit : Player = MainInstances._main_player

func _ready():
	player_unit = MainInstances._main_player
	player_unit.stats.connect("_health_changed", self, "update_mana_display")
	update_mana_display(player_unit.stats.health)

func update_mana_display(value : int):
	for i in mana_container.get_child_count():
		mana_container.get_child(i).visible = value > i
