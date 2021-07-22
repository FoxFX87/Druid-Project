extends Area2D
class_name Player

const CELL_SIZE = 16

enum STATE {MOVE, PUSH, PREPARE_ATTACK, ATTACK, PLANT}

var inputs = {
	"ui_right" : Vector2.RIGHT,
	"ui_left" : Vector2.LEFT,
	"ui_up" : Vector2.UP,
	"ui_down" : Vector2.DOWN,
}

export var tile_move_speed : float = 6.0

onready var sprite = $Sprite
onready var move_ray = $MoveRay
onready var dust_pos = $DustPosition
onready var tween_move = $TweenMove
onready var anim = $AnimationPlayer
onready var current_projectile = PreloadedScenes.PROJECTILES["neutral"]

var current_state
var move_vector : Vector2 setget _set_move_vector
var push_target : PushObject
var push_vector : Vector2 setget _set_push_vector
var current_seed = MainInstances.plant_seed

func _ready():
	MainInstances.player = self
	_start_grid_position()
	_transition_to_state(STATE.MOVE)
	
func _exit_tree():
	MainInstances.player = null

func _process(_delta):
	
	if move_vector.x != 0:
		sprite.scale.x = move_vector.x
	
	match current_state:
			
		STATE.MOVE:
			var _anim = anim.play("Move") if tween_move.is_active() else anim.play("Idle")
			
			if tween_move.is_active():
				return
			
			for dir in inputs.keys():
				if Input.is_action_pressed(dir):
					move_vector = inputs[dir]
					_set_sprite_flip(dir)
					_update_move_ray(dir)
					
					if not move_ray.is_colliding():
						_move_towards_direction(dir)
						
					if move_ray.is_colliding():
						var obj = move_ray.get_collider()
						if obj.is_in_group("Push"):
							push_target = obj
							push_vector = inputs[dir]
							_transition_to_state(STATE.PUSH)
				
			if Input.is_action_just_pressed("in_attack"):
				_transition_to_state(STATE.PREPARE_ATTACK)
				
			if current_seed != null:
				if Input.is_action_just_pressed("in change floor"):
					_transition_to_state(STATE.PLANT)
				
		STATE.PUSH:
			var _anim = anim.play("Push")
			
		STATE.PREPARE_ATTACK:
			var _anim = anim.play("Prepare Attack")
			
			if Input.is_action_just_pressed("in_attack"):
				_transition_to_state(STATE.MOVE)
				
			for dir in inputs.keys():
				if Input.is_action_just_pressed(dir):
					_update_move_ray(dir)
					move_vector = inputs[dir]
					
					_transition_to_state(STATE.ATTACK)
			
		STATE.ATTACK:
			var _anim = anim.play("Attack")
			
		STATE.PLANT:
			var _anim = anim.play("Plant")
	
func _set_move_vector(_vec : Vector2):
	move_vector = _vec
	
func _set_push_vector(_vec : Vector2):
	push_vector = _vec

func _transition_to_state(_state):
	if current_state != _state:
		current_state = _state

func _start_grid_position():
	position = position.snapped(Vector2.ONE * CELL_SIZE)
	position -= Vector2.ONE * CELL_SIZE/2

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

func _attack_in_direction():
	var p : Projectile = current_projectile.instance()
	p.direction = move_vector
	p.position = global_position + move_ray.cast_to/4
	get_parent().add_child(p)

func _push_block_toward():
	push_target.push_to(push_vector)
	var e = PreloadedScenes.EFFECTS["hit"].instance()
	e.position = (push_target.global_position + global_position)/2
	get_parent().add_child(e)

func _transition_to_start():
	_transition_to_state(STATE.MOVE)
	
func _create_dust():
	var dust_location : Vector2 = dust_pos.global_position
	dust_location.x += rand_range(-4, 4)
	var d = PreloadedScenes.EFFECTS["dust"].instance()
	d.position = dust_location
	get_parent().add_child(d)

func _on_TweenMove_tween_all_completed():
	_get_floor_name()

func _create_blast_effect():
	var e = PreloadedScenes.EFFECTS["blast"].instance()
	e.position = global_position + move_ray.cast_to * 0.1
	e.rotation_degrees = rad2deg(move_vector.angle()) + 90
	get_parent().add_child(e)

func _on_SeedEffect_floors_changed():
	_get_floor_name()
