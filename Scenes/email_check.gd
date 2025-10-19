extends Node2D

@onready var trusted_author_site = $CanvasLayer/Screen/HelpDocContainer/trusted_authors
@onready var trusted_publisher_site = $CanvasLayer/Screen/HelpDocContainer/trusted_publishers
@onready var trusted_domain_site = $CanvasLayer/Screen/HelpDocContainer/trusted_domains
@onready var trusted_recent_events_site = $CanvasLayer/Screen/HelpDocContainer/trusted_recent_events

@onready var helpful_documents_screen = $CanvasLayer/Screen/HelpDocContainer/helpful_doc_panel

@onready var news_template: Panel = $CanvasLayer/EmailTemplate
@onready var buttons_enabled: Panel = $CanvasLayer/ButtonsEnabled
@onready var continue_button: Button = $CanvasLayer/ContinueButton
var current_email: int

@onready var beaver: Sprite2D = $CanvasLayer/Beaver
@onready var save_manager = SaveManager.new()
var brevan: Brevan

#user input bit
@onready var textInput = $"user input/Panel2/LineEdit"
@onready var userInputTab = $"user input"
var username
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# initialize from BrevanGlobal progress so it persists across sessions
	if BrevanGlobal:
		current_email = BrevanGlobal.email_progress_index
		news_template.email_id = current_email
	else:
		current_email = 0
		news_template.email_id = current_email
	continue_button.visible = false
	buttons_enabled.visible = false
	beaver.visible = false
	
	var loaded = save_manager.load_brevan()
	if loaded == null:
		brevan = Brevan.new("FAT_BEAVER")
	else:
		brevan = loaded


func _UserInput () -> void:
	username = textInput.text  # get the text the user entered
	news_template._userinput(username)


func _on_submit_button_pressed() -> void:
	var result = news_template.get_results()
	continue_button.visible = true
	buttons_enabled.visible = true
	if result == 6:
		beaver.make_happy()
	else:
		beaver.make_sad()
	
	if "outfit" in brevan.current_outfit:
		beaver.cur_beaver = outfit_num_to_name(brevan.current_outfit)
	else:
		beaver.cur_beaver = "base_beaver"
	beaver.visible = true

func _on_continue_button_pressed() -> void:
	# if we've finished 5 emails in the session, go to Results scene
	if BrevanGlobal and BrevanGlobal.email_session_completed >= 5:
		get_tree().change_scene_to_file("res://Scenes/email_results.tscn")
		return

	news_template.hide_results()
	continue_button.visible = false
	buttons_enabled.visible = false
	beaver.visible = false
	current_email += 1
	# persist progress in the autoload so sessions survive scene changes
	if BrevanGlobal:
		BrevanGlobal.email_progress_index = current_email
	news_template.email_id = current_email
	news_template.load_article()

func _on_trusted_author_button_pressed() -> void:
	helpful_documents_screen.visible = false
	trusted_author_site.visible = true

func _on_trusted_publisher_button_pressed() -> void:
	helpful_documents_screen.visible = false
	trusted_publisher_site.visible = true

func _on_trusted_domain_button_pressed() -> void:
	helpful_documents_screen.visible = false
	trusted_domain_site.visible = true

func _on_trusted_recent_events_button_pressed() -> void:
	helpful_documents_screen.visible = false
	trusted_recent_events_site.visible = true

func _on_back_button_pressed() -> void:
	helpful_documents_screen.visible = true
	trusted_author_site.visible = false
	trusted_publisher_site.visible = false
	trusted_domain_site.visible = false
	trusted_recent_events_site.visible = false

func _on_back_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainScene.tscn")


func _on_button_pressed() -> void:
	_UserInput()
	userInputTab.visible=false

func outfit_num_to_name(outfit):
	if outfit == "outfit1":
		return "brainrot"
	elif outfit == "outfit2":
		return "chappell"
	elif outfit == "outfit3":
		return "cowboy"
	elif outfit == "outfit4":
		return "louis"
	elif outfit == "outfit5":
		return "mariachi"
	elif outfit == "outfit6":
		return "suit"
	elif outfit == "base":
		return "base_beaver"
