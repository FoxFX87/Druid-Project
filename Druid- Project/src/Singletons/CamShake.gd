extends Node

var cam_shake_intensity = 0.0
var cam_shake_duration = 0.0

func _shake(shake_intensity, shake_duration):
	if shake_intensity > cam_shake_intensity and shake_duration > cam_shake_duration:
		cam_shake_intensity = shake_intensity
		cam_shake_duration = shake_duration
		
func _process(delta):
	var camera: Camera2D = get_tree().current_scene.get_node("Camera2D")
	
	if cam_shake_duration <= 0:
		camera.offset = Vector2.ZERO
		cam_shake_intensity = 0.0
		cam_shake_duration = 0.0
		return
		
	cam_shake_duration -= delta
	
	var _offset = Vector2.ZERO
	_offset = Vector2(randf(), randf()) * cam_shake_intensity
	camera.offset = _offset
