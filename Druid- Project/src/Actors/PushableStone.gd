extends Area2D
class_name PushObject

const cell_size = 16

onready var move_ray = $MoveRay

var move_vector

func _ready():
	position = position.snapped(Vector2.ONE * cell_size)
	position -= Vector2.ONE * cell_size/2

func update_ray(dir):
	move_ray.cast_to = dir * cell_size
	move_ray.force_raycast_update()

func push_to(dir):
	
	update_ray(dir)
	
	if not move_ray.is_colliding():
		position += dir * cell_size
