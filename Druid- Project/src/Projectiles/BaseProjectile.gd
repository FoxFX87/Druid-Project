extends Area2D
class_name Projectile

enum TYPE {CLEAR, RED, BLUE}

export (int) var speed = 200
export (TYPE) var attack_type = TYPE.CLEAR
var direction : Vector2 setget _set_direction

onready var part = $ProjectileParticle/AnimationPlayer

func _process(delta):
	position += speed * direction * delta
	
func _set_direction(dir : Vector2):
	direction = dir

func _play_sfx():
	SfxLibrary._play("SpellImpact002")

func _destroy():
	speed = 0
	part.play("Fade")
	yield(part,"animation_finished")
	queue_free()

func _on_BaseProjectile_area_entered(_area):
	_destroy()

func _on_BaseProjectile_body_entered(_body):
	_destroy()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
