extends Area2D

signal _died

var target

export (Projectile.TYPE) var vulnerability 

onready var sprite = $Sprite
onready var anim = $AnimationPlayer

func _ready():
	target = MainInstances.player
	
func _process(_delta):
	
	if target:
		if target.position.x != position.x:
			sprite.flip_h = target.position.x < position.x
			
func _death():
	SfxLibrary._play("SpellImpact")
	target = null
	var p = PreloadedScenes.EFFECTS["poof"].instance()
	p.position = global_position
	get_parent().add_child(p)
	emit_signal("_died")
	queue_free()

func _on_Fiend002_area_entered(area : Projectile):
	if area.attack_type == vulnerability:
		_death()
	else:
		anim.play("React")
