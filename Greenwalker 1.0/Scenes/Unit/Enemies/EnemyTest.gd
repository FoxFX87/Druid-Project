extends Enemy

signal _died()

export (int, 1, 5) var damage = 1

onready var stats = $Stats
onready var target : Unit = MainInstances._main_player

func _process(_delta):
	$Sprite.flip_h = true if target.position.x < position.x else false

func _on_Stats__died():
	queue_free()
	emit_signal("_died")
	pass # Replace with function body.
