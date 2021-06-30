extends Area2D

onready var audio : AudioStreamPlayer = $PickupSFX

func _on_WolfSpirit_area_entered(_area):
	if visible:
		visible = false
		audio.play()
		yield(audio, "finished")
		queue_free()
