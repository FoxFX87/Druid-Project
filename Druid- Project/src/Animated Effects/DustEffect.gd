extends Node2D

var velocity = Vector2(rand_range(20, -20), rand_range(-10, -40))

func _process(delta):
	position += velocity * delta
