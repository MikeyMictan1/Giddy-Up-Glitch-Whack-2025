extends Node2D

# hello hello
var tutorialDone = false
@onready var beaver: Sprite2D = $CanvasLayer2/Beaver
@onready var save_manager = SaveManager.new()
var brevan: Brevan


func _stopTut():
	tutorialDone = true

func _ready():
	# Set game state when entering the game scene
	GameManager.set_in_game(true)
	
	var loaded = save_manager.load_brevan()
	if loaded == null:
		brevan = Brevan.new("FAT_BEAVER")
	else:
		brevan = loaded
	
	if brevan.current_outfit == "outfit1":
		beaver.cur_beaver = "brainrot"
	elif brevan.current_outfit == "outfit2":
		beaver.cur_beaver = "chappell"
	elif brevan.current_outfit == "outfit3":
		beaver.cur_beaver = "cowboy"
	elif brevan.current_outfit == "outfit4":
		beaver.cur_beaver = "louis"
	elif brevan.current_outfit == "outfit5":
		beaver.cur_beaver = "mariachi"
	elif brevan.current_outfit == "outfit6":
		beaver.cur_beaver = "suit"
	elif brevan.current_outfit == "base":
		beaver.cur_beaver = "base_beaver"
	
	if BrevanGlobal.menu_tutorial_finished == true:
		beaver.visible = true

func _exit_tree():
	# Reset game state when leaving the game scene
	GameManager.set_in_game(false)
	GameManager.set_paused(false)


func _on_begin_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/HelpfulDocuments.tscn")


func _on_profile_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/profile_page.tscn")
