extends Control

@onready var back: Button = $MainPanel/Buttons/Back

func _ready():
	pass

func _on_main_scene_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainScene.tscn")

func _on_customise_character_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/CharacterCustomisation.tscn")
