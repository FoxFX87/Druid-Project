extends ColorRect

onready var texture = $CenterContainer/TextureRect

func _ready():
	var _text_signal = MainInstances.connect("_seed_set", self, "_set_texture")
	
func _set_texture(value):
	
	if value != null:
		
		match value:
			MainInstances.SEED.RED:
				texture.texture = PreloadedScenes.IMAGES["red seed"]
			MainInstances.SEED.BLUE:
				texture.texture = PreloadedScenes.IMAGES["blue seed"]
		
	else:
		texture.texture = null
