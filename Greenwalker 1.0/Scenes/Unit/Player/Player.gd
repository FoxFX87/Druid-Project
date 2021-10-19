extends Movable_Unit
class_name Player

const inputs = {
	"ui_right" : Vector2.RIGHT,
	"ui_left" : Vector2.LEFT,
	"ui_up" : Vector2.UP,
	"ui_down" : Vector2.DOWN,
}

enum STATE {MOVE, CAST, ATTACK}

onready var anim = $AnimationPlayer
onready var sprite = $Sprite
onready var stats = $Stats

var current_state = STATE.MOVE
var input_delay : float = 0.0
var attack_target : Unit = null
var has_mana : bool = true

func _ready():
	MainInstances._main_player = self
	
func _exit_tree():
	MainInstances._main_player = null

func _process(delta):
	
	input_delay += delta
	input_delay = clamp(input_delay, 0, Global.MOVE_DELAY)
	
	match current_state:
			
		STATE.MOVE:
			anim.play("Idle")
			_get_inputs()
		STATE.CAST:
			anim.play("Cast")
		STATE.ATTACK:
			anim.play("Attack")
		
func _get_inputs():
	
	if tween.is_active():
		return
	
	for dir in inputs.keys():
		if Input.is_action_pressed(dir) and input_delay >= Global.MOVE_DELAY:
			_update_sprite(inputs[dir])
			_move_to(inputs[dir])
			input_delay = 0.0
			
	if Input.is_action_just_pressed("in_cast"):
		_transition_to_state(STATE.CAST)

func _can_move_to(dir : Vector2) -> bool:
	
	if not self.move_ray:
		return false
	self.move_ray.cast_to = dir * tile_size
	self.move_ray.force_raycast_update()
	var collider = move_ray.get_collider()
	
	if not collider:
		return true
	elif collider.is_in_group("enemy"):
		attack_target = collider
		_transition_to_state(STATE.ATTACK)
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

func _transition_to_state(_state):
	if current_state != _state:
		current_state = _state
		
func _transition_to_move():
	attack_target = null
	_transition_to_state(STATE.MOVE)

func _create_attack():
	var _inst = Instances.ATTACKGRAVEL
	var _pos = attack_target.global_position
	var _attack = Instances._instance_scene_to_main(_inst, _pos)
	_attack.scale.x = sprite.scale.x
	stats.health -= 1
	

func _on_Stats__died():
	
	if has_mana:
		has_mana = false
	else:
		yield(anim, "animation_finished")
		queue_free()
