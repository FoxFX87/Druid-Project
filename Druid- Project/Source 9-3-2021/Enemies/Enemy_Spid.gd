extends "res://Source 9-3-2021/Enemies/Enemy.gd"

enum STATE {MOVE, IDLE}

var current_state
var move_vector : Vector2

onready var sprite = $Sprite
onready var tween = $TweenMove
onready var anim = $AnimationPlayer
onready var timer = $Timer
onready var leftray = $DetectionRays/LeftRay
onready var rightray = $DetectionRays/RightRay

func _ready():
	position = position.snapped(Vector2.ONE * CELL_SIZE)
	position -= Vector2.ONE * CELL_SIZE/2
	_transition_to_state(STATE.IDLE)
	
func _process(_delta):
	
	_update_sprite_direction()
	
	match current_state:
		
		STATE.IDLE:
			anim.play("Idle")
			_update_move_ray()
			
		STATE.MOVE:
			_move()
			pass

func _transition_to_state(_state):
	if current_state != _state:
		current_state = _state
		
func _update_move_ray():
	if leftray.is_colliding() and rightray.is_colliding():
		return
	elif not leftray.is_colliding() and rightray.is_colliding():
		move_vector.x = -1
	elif leftray.is_colliding() and not rightray.is_colliding():
		move_vector.x = 1
		
func _transition_to_idle():
	_transition_to_state(STATE.IDLE)
	timer.start()

func _update_sprite_direction():
	if move_vector.x != 0:
		sprite.scale.x = move_vector.x

func _on_Timer_timeout():
	if not (leftray.is_colliding() and rightray.is_colliding()):
		_transition_to_state(STATE.MOVE)
	else:
		_transition_to_idle()

func _move():
	anim.play("Move")
	set_process(false)
	var direction = move_vector * CELL_SIZE
	tween.interpolate_property(	self, "position",
								position, position + direction,
								anim.current_animation_length,
								Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()
	yield(anim, "animation_finished")
	set_process(true)
	_transition_to_idle()

