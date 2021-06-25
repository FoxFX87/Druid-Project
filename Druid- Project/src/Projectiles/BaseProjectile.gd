extends Area2D

export (int) var speed = 200
var direction : Vector2 setget _set_direction

func _process(delta):
	position += speed * direction * delta
	
func _set_direction(dir : Vector2):
	direction = dir

func _on_BaseProjectile_area_entered(_area):
	queue_free()

func _on_BaseProjectile_body_entered(_body):
	queue_free()
