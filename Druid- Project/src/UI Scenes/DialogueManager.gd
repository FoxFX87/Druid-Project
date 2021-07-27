extends Control

export var dialogue_path = ""
export (float) var text_speed = 0.05

var dialogue

# command : popup.popup()
onready var popup = $Popup
onready var char_name = $Popup/CharacterName
onready var dialogue_label = $Popup/DialogueLabel
onready var timer = $Popup/Timer

func _ready():
	timer.wait_time = text_speed
	dialogue = getDialog()
	assert(dialogue, "Dialog not found")
	
func _process(_delta):
	pass

func getDialog() -> Array:
	var file = File.new()
	assert(file.file_exists(dialogue_path), "File path not found")
	file.open(dialogue_path, File.READ)
	var json = file.get_as_text()
	
	var output = parse_json(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []
