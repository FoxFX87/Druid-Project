extends Node2D

var sealed_fissures : int

onready var fissures = $WorldYSort/Fissures

func _ready():
	
	for f in fissures.get_children():
		f.connect("_sealed", self, "_update_fissure_count")
		sealed_fissures += 1

	

func _update_fissure_count():
	sealed_fissures -= 1
	
	if sealed_fissures <= 0:
		print("GAME OVER")
