extends Area2D

export (MainInstances.SEED) var current_seed

func _on_RedSeed_area_entered(_area):
	MainInstances.plant_seed = current_seed
	queue_free()
