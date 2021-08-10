extends Area2D

signal _died

var target

onready var sprite = $Sprite

func _ready():
	target = MainInstances.player
	
func _process(_delta):
	
	if target:
		if target.position.x != position.x:
			sprite.flip_h = target.position.x < position.x

func _on_Fiend001_area_entered(_area : Area2D):
	_death()
#	if area.is_in_group("Player"):
#		_death()

func _death():
	SfxLibrary._play("SpellImpact001")
	target = null
	var p = PreloadedScenes.EFFECTS["poof"].instance()
	p.position = global_position
	get_parent().add_child(p)
	emit_signal("_died")
	queue_free()
