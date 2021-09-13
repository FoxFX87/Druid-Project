extends Unit

enum STATE {MOVE, PUSH, PREPARE_ATTACK, ATTACK, PLANT}

var inputs = {
	"ui_right" : Vector2.RIGHT,
	"ui_left" : Vector2.LEFT,
	"ui_up" : Vector2.UP,
	"ui_down" : Vector2.DOWN,
}

var current_state
var move_vector : Vector2 
var push_target : PushObject
var push_vector : Vector2 

onready var sprite = $Sprite
onready var move_ray = $MoveRay
onready var tween = $TweenMove
onready var anim = $AnimationPlayer

func _ready():
	MainInstances.player = self
	position = position.snapped(Vector2.ONE * CELL_SIZE)
	position -= Vector2.ONE * CELL_SIZE/2
	_transition_to_state(STATE.MOVE)
	
func _process(_delta):
	
	match current_state:
		STATE.MOVE:
			anim.play("Idle")
			
			if tween.is_active():
				return
			
			for dir in inputs.keys():
				if Input.is_action_pressed(dir):
					move_vector = inputs[dir]
					_update_sprite_direction()
					_update_move_ray(dir)
					
					if not move_ray.is_colliding():
						move_to(dir)
			
			if Input.is_action_just_pressed("in_attack"):
				_transition_to_state(STATE.PREPARE_ATTACK)
				
		STATE.ATTACK:
			pass
			
		STATE.PREPARE_ATTACK:
			anim.play("Prepare Attack")
			
			if Input.is_action_just_pressed("in_attack"):
				_transition_to_state(STATE.MOVE)
				
		STATE.PUSH:
			pass
	
func move_to(_dir):
	anim.play("Move")
	set_process(false)
	var direction = inputs[_dir] * CELL_SIZE
	
	tween.interpolate_property(	self, "position",
								position, position + direction,
								anim.current_animation_length,
								Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	yield(anim, "animation_finished")
	set_process(true)
	anim.play("Idle")
	
func _transition_to_state(_state):
	if current_state != _state:
		current_state = _state
		
func _update_sprite_direction():
	if move_vector.x != 0:
		sprite.scale.x = move_vector.x

func _update_move_ray(dir):
	var vector_pos = inputs[dir] * CELL_SIZE
	move_ray.cast_to = vector_pos
	move_ray.force_raycast_update()
