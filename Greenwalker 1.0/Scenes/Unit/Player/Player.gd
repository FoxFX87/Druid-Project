extends Movable_Unit
class_name Player

const inputs = {
	"ui_right" : Vector2.RIGHT,
	"ui_left" : Vector2.LEFT,
	"ui_up" : Vector2.UP,
	"ui_down" : Vector2.DOWN,
}

enum STATE {MOVE, PUSH}

onready var anim = $AnimationPlayer
onready var sprite = $Sprite

var current_state = STATE.MOVE
var input_delay : float = 0.0
var push_target : Unit = null
var push_direction : Vector2

func _process(delta):
	
	input_delay += delta
	input_delay = clamp(input_delay, 0, Global.MOVE_DELAY)
	
	match current_state:
			
		STATE.MOVE:
			anim.play("Idle")
			_get_inputs()
		STATE.PUSH:
			anim.play("Push")
			pass
		
func _get_inputs():
	
	if tween.is_active():
		return
	
	for dir in inputs.keys():
		if Input.is_action_pressed(dir) and input_delay >= Global.MOVE_DELAY:
			_update_sprite(inputs[dir])
			_move_to(inputs[dir])
			input_delay = 0.0

func _can_move_to(dir : Vector2) -> bool:
	
	if not self.move_ray:
		return false
	self.move_ray.cast_to = dir * tile_size
	self.move_ray.force_raycast_update()
	var collider = move_ray.get_collider()
	
	if not collider:
		return true
		
	elif collider.has_method("_can_move_to"):
		push_target = collider
		push_direction = dir
		_transition_to_state(STATE.PUSH)
		return false
	else:
		return false
	
func _move_to(dir : Vector2):
	
	if self._can_move_to(dir):
		anim.play("Move")
		set_process(false)
		._move_to_anim(dir, anim)
		yield(anim, "animation_finished")
		set_process(true)
		anim.play("Idle")
	
func _update_sprite(dir : Vector2):
	if dir.x != 0:
		sprite.scale.x = dir.x

func _push_object_to():
	if push_target.has_method("_can_move_to"):
		if push_target._can_move_to(push_direction):
			push_target._move_to(push_direction)

func _transition_to_state(_state):
	if current_state != _state:
		current_state = _state
		
func _transition_to_move():
	push_target = null
	push_direction = Vector2.ZERO
	_transition_to_state(STATE.MOVE)
