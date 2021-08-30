extends Node2D

func _process(_delta):
	if Input.is_action_pressed("ui_cancel"):
		if $TextLayer/EscapeMessage.modulate.a > 0.5:
			get_tree().quit()
