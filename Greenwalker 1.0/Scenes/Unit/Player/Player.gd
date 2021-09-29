extends Movable_Unit
class_name Player

const inputs = {
	"ui_right" : Vector2.RIGHT,
	"ui_left" : Vector2.LEFT,
	"ui_up" : Vector2.UP,
	"ui_down" : Vector2.DOWN,
}

enum STATE {MOVE}

onready var anim = $AnimationPlayer
onready var sprite = $Sprite

var current_state = STATE.MOVE

func _process(_delta):
	
	match current_state:
			
		STATE.MOVE:
			anim.play("Idle")
			_get_inputs()
		
func _get_inputs():
	
	if tween.is_active():
		return
	
	for dir in inputs.keys():
		if Input.is_action_pressed(dir):
			_update_sprite(inputs[dir])
			_move_to(inputs[dir])

func _move_to(dir : Vector2):
	
	anim.play("Move")
	set_process(false)
	
	if tween:
		var _move_tween = tween.interpolate_property(	self, "position", 
									self.position,
									self.position + (dir * tile_size),
									anim.current_animation_length, 
									Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		var _start_tween = tween.start()
	else:
		self.position += dir * tile_size
		
	yield(anim, "animation_finished")
	set_process(true)
	anim.play("Idle")

func _update_sprite(dir : Vector2):
	if dir.x != 0:
		sprite.scale.x = dir.x
