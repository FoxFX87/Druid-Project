extends ColorRect

onready var texture = $CenterContainer/TextureRect

func _ready():
	var _text_signal = MainInstances.connect("_seed_set", self, "_set_texture")
	
func _set_texture(value):
	
	if value != null:
		texture.texture = PreloadedScenes.IMAGES["red seed"]
		print("Image set")
	else:
		texture.texture = null
