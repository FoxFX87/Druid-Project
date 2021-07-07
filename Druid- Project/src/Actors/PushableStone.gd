extends Area2D
class_name PushObject

const cell_size = 16

onready var sprite = $Sprite
onready var move_ray = $MoveRay
onready var dust_pos = $DustPosition
onready var audio = $StoneMovingSFX

var move_vector
var shake_intensity : float = 1.0
var shake_duration : float = 0.25
var current_shake_duration : float = 0.0

func _ready():
	position = position.snapped(Vector2.ONE * cell_size)
	position -= Vector2.ONE * cell_size/2

func _process(delta):
	if current_shake_duration <= 0:
		sprite.offset = Vector2.ZERO
		current_shake_duration = 0.0
		return
		
	current_shake_duration -= delta
	
	var _offset = Vector2.ZERO
	_offset = Vector2(randf(), randf()) * shake_intensity
	sprite.offset = _offset

func update_ray(dir):
	move_ray.cast_to = dir * cell_size
	move_ray.force_raycast_update()

func push_to(dir):
	shake()
	update_ray(dir)
	
	if not move_ray.is_colliding():
		audio.play(0.975)
		_create_dust()
		position += dir * cell_size

func shake():
	current_shake_duration = shake_duration

func _create_dust():
	var dust_location : Vector2 = dust_pos.global_position
	dust_location.x += rand_range(-4, 4)
	var d = PreloadedScenes.EFFECTS["dust"].instance()
	d.position = dust_location
	get_parent().add_child(d)
