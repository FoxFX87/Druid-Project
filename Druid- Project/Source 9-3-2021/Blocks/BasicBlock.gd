extends Unit

onready var move_ray = $MoveRay

var move_vector
var can_push : bool = true

func _ready():
	position = position.snapped(Vector2.ONE * CELL_SIZE)
	position -= Vector2.ONE * CELL_SIZE/2
	
func update_ray(dir):
	move_ray.cast_to = dir * CELL_SIZE
	move_ray.force_raycast_update()
	
func push_to(dir):
	update_ray(dir)
	
	if not move_ray.is_colliding():
		move_block(dir)
		can_push = true
	else:
		can_push = false

func move_block(dir):
	if not can_push:
		return
	
	var _dir = dir * CELL_SIZE
	
	$TweenMove.interpolate_property(self, "position",
									position, position + _dir,
									0.1, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	$TweenMove.start()
