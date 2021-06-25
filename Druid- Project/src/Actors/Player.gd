extends Area2D
class_name player

const CELL_SIZE = 16

enum STATE {IDLE, MOVE, PUSH, PREPARE_ATTACK, ATTACK}

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
onready var current_projectile = PreloadedScenes.PROJECTILES["neutral"]

var current_state

func _ready():
	_start_grid_position()
	_transition_to_state(STATE.IDLE)

func _process(_delta):
	_get_movement_inputs()

func _transition_to_state(_state):
	if current_state != _state:
		current_state = _state

func _start_grid_position():
	position = position.snapped(Vector2.ONE * CELL_SIZE)
	position -= Vector2.ONE * CELL_SIZE/2

func _get_movement_inputs():
	if tween_move.is_active():
		return
		
	for dir in inputs.keys():
		if Input.is_action_pressed(dir):
			_set_sprite_flip(dir)
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

func _set_sprite_flip(dir):
	if inputs[dir].x != 0:
		sprite.scale.x = inputs[dir].x

func _get_floor_name():
	for b in get_overlapping_bodies():
		if b is TileMap:
			var tile_pos = b.world_to_map(position)
			var tile_id = b.get_cellv(tile_pos)
			var tile_name = b.tile_set.tile_get_name(tile_id)
			match tile_name:
				"RedFloor":
					current_projectile = PreloadedScenes.PROJECTILES["red"]
					return
				"BlueFloor":
					current_projectile = PreloadedScenes.PROJECTILES["blue"]
					return
				"GreenFloor":
					current_projectile = PreloadedScenes.PROJECTILES["green"]
					return
	current_projectile = PreloadedScenes.PROJECTILES["neutral"]

func _attack_in_direction(dir):
	var p : Projectile = current_projectile.instance()
	p.direction = inputs[dir]
	p.position = global_position
	p.direction = Vector2.UP
	get_parent().add_child(p)

func _on_TweenMove_tween_all_completed():
	_get_floor_name()
