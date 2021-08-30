extends CanvasLayer

export (float) var text_speed = 0.05

var dialog

func _ready():
	$Timer.wait_time = text_speed
	
