extends Area2D

var target

onready var sprite = $Sprite

func _ready():
	target = MainInstances.player
	
func _process(_delta):
	
	if target:
		if target.position.x != position.x:
			sprite.flip_h = target.position.x < position.x

func _on_Fiend001_area_entered(area : Area2D):
	if area.is_in_group("Player"):
		_death()

func _death():
	target = null
	var p = PreloadedScenes.EFFECTS["poof"].instance()
	p.position = global_position
	get_parent().add_child(p)
	queue_free()
