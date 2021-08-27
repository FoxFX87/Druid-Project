extends Control

export (PackedScene) var next_stage

onready var trans = $TransitionScene
onready var start_button = $VBoxContainer/SelectionMenu/StartSection/StartButton

func _ready():
	start_button.grab_focus()
	MusicLibrary._play("TitleLoop")

func _on_StartButton_pressed():
	SfxLibrary._play("MenuAccept")
	trans.change_scene(next_stage)

func _on_ExitButton_pressed():
	get_tree().quit()

func _on_StartButton_focus_exited():
	SfxLibrary._play("MenuNavigateGroup")

func _on_OptionsButton_focus_exited():
	SfxLibrary._play("MenuNavigateGroup")

func _on_ExitButton_focus_exited():
	SfxLibrary._play("MenuNavigateGroup")
