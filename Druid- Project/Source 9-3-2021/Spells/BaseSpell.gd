extends Area2D

enum DAMAGE_TYPE {GRAVEL, WATER, WIND}

export (int) var speed = 200
export (DAMAGE_TYPE) var attack_type = DAMAGE_TYPE.GRAVEL

var direction : Vector2 setget _set_direction

func _set_direction(dir : Vector2):
	direction = dir
	
func _process(delta):
	position += speed * direction * delta
	
func _destroy():
	queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	_destroy()
	pass # Replace with function body.

func _on_Spell_area_entered(_area):
	
	match attack_type:
		
		DAMAGE_TYPE.WIND:
			pass
		DAMAGE_TYPE.GRAVEL:
			if _area.is_in_group("Push"):
				_area.push_to(direction)
		DAMAGE_TYPE.WATER:
			pass

	_destroy()

func _on_Spell_body_entered(_body):
	_destroy()
	pass # Replace with function body.
