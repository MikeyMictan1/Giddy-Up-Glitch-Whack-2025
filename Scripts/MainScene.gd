extends Node2D

# hello hello
var tutorialDone = false


func _stopTut():
	tutorialDone = true

func _ready():
	BrevanGlobal.save_to_disk()
	BrevanGlobal.load_from_disk()
	# Set game state when entering the game scene
	GameManager.set_in_game(true)

func _exit_tree():
	# Reset game state when leaving the game scene
	GameManager.set_in_game(false)
	GameManager.set_paused(false)


func _on_begin_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/HelpfulDocuments.tscn")


func _on_profile_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/profile_page.tscn")


func _on_reset_button_pressed() -> void:
	BrevanGlobal.reset_brevan()
	get_tree().reload_current_scene()
