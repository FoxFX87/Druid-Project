extends Area2D

export (MainInstances.SEED) var current_seed

func _on_RedSeed_area_entered(_area):
	SfxLibrary._play("SeedCollected")
	MainInstances.plant_seed = current_seed
	queue_free()
