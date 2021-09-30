extends Block

func _can_move_to(dir : Vector2) -> bool:
	
	if not self.move_ray:
		return false
		
	if dir in [Vector2.RIGHT, Vector2.LEFT]:
		return false
	
	self.move_ray.cast_to = dir * tile_size
	self.move_ray.force_raycast_update()
	
	return not self.move_ray.is_colliding()
