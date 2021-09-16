extends Unit

onready var move_ray = $MoveRay

var move_vector

func _ready():
	position = position.snapped(Vector2.ONE * CELL_SIZE)
	position -= Vector2.ONE * CELL_SIZE/2
	
func update_ray(dir):
	move_ray.cast_to = dir * CELL_SIZE
	move_ray.force_raycast_update()
	
func push_to(dir):
	update_ray(dir)
	
	if not move_ray.is_colliding():
		position += dir * CELL_SIZE
