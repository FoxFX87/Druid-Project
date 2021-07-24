extends Area2D

func _on_RedSeed_area_entered(_area):
	MainInstances.plant_seed = MainInstances.SEED.RED
	queue_free()
