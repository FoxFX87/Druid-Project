extends Unit
class_name Movable_Unit

var tween_duration = Global.TWEEN_DURATION

onready var move_ray : RayCast2D = $RayCast2D
onready var tween : Tween = $Tween

func _can_move_to(dir : Vector2) -> bool:
	
	if not self.move_ray:
		return false
	self.move_ray.cast_to = dir * tile_size
	self.move_ray.force_raycast_update()
	
	return not self.move_ray.is_colliding()
	
func _move_to(dir : Vector2):
	
	if tween:
		var _move_tween = tween.interpolate_property(	self, "position", 
									self.position,
									self.position + (dir * tile_size),
									tween_duration, Tween.TRANS_LINEAR,
									Tween.EASE_IN_OUT)
		var _start_tween = tween.start()
	else:
		self.position += dir * tile_size
		
func _move_to_anim(dir : Vector2, anim : AnimationPlayer):
	
	if tween:
		var _move_tween = tween.interpolate_property(	self, "position", 
									self.position,
									self.position + (dir * tile_size),
									anim.current_animation_length, 
									Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		var _start_tween = tween.start()
	else:
		self.position += dir * tile_size
