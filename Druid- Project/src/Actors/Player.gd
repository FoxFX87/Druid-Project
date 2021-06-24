extends Area2D
class_name player

const CELL_SIZE = 16

var inputs = {
	"ui_right" : Vector2.RIGHT,
	"ui_left" : Vector2.LEFT,
	"ui_up" : Vector2.UP,
	"ui_down" : Vector2.DOWN,
}

export var tile_move_speed : float = 4.0

onready var sprite = $Sprite
onready var move_ray = $MoveRay
onready var tween_move = $TweenMove

func _ready():
	_start_grid_position()

func _process(_delta):
	_get_movement_inputs()

func _start_grid_position():
	position = position.snapped(Vector2.ONE * CELL_SIZE)
	position -= Vector2.ONE * CELL_SIZE/2

func _get_movement_inputs():
	if tween_move.is_active():
		return
		
	for dir in inputs.keys():
		if Input.is_action_pressed(dir):
			_set_sprite(dir)
			_update_move_ray(dir)
			
			if not move_ray.is_colliding():
				_move_towards_direction(dir)
	
func _update_move_ray(dir):
	var vector_pos = inputs[dir] * CELL_SIZE
	move_ray.cast_to = vector_pos
	move_ray.force_raycast_update()

func _move_towards_direction(dir):
	_tween_movement(inputs[dir] * CELL_SIZE)
	
func _tween_movement(dir):
	tween_move.interpolate_property(self, "position", 
								position, 
								position + dir, 1.0/tile_move_speed, 
								Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween_move.start()

func _set_sprite(dir):
	if inputs[dir].x != 0:
		sprite.scale.x = inputs[dir].x
