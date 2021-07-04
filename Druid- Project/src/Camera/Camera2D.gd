extends Camera2D

var cam_shake_intensity = 0.0
var cam_shake_duration = 0.0

func _shake(shake_intensity, shake_duration):
	if shake_intensity > cam_shake_intensity and shake_duration > cam_shake_duration:
		cam_shake_intensity = shake_intensity
		cam_shake_duration = shake_duration
		
func _process(delta):
	
	if cam_shake_duration <= 0:
		offset = Vector2.ZERO
		cam_shake_intensity = 0.0
		cam_shake_duration = 0.0
		return
		
	cam_shake_duration -= delta
	
	var _offset = Vector2.ZERO
	_offset = Vector2(randf(), randf()) * cam_shake_intensity
	offset = _offset
