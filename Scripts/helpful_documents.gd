extends Node2D

@onready var trusted_author_site = $CanvasLayer/Screen/HelpDocContainer/trusted_authors
@onready var trusted_publisher_site = $CanvasLayer/Screen/HelpDocContainer/trusted_publishers
@onready var trusted_domain_site = $CanvasLayer/Screen/HelpDocContainer/trusted_domains
@onready var trusted_recent_events_site = $CanvasLayer/Screen/HelpDocContainer/trusted_recent_events

@onready var helpful_documents_screen = $CanvasLayer/Screen/HelpDocContainer/helpful_doc_panel

@onready var news_template: Panel = $CanvasLayer/NewsTemplate
@onready var buttons_enabled: Panel = $CanvasLayer/ButtonsEnabled
@onready var continue_button: Button = $CanvasLayer/ContinueButton
var current_article: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if BrevanGlobal:
		print("ARTICLE INDEX AT READY: " + str(BrevanGlobal.progress_index))
		current_article = BrevanGlobal.progress_index
		news_template.article_id = current_article
	else:
		current_article = 0
		news_template.article_id = current_article

	continue_button.visible = false
	buttons_enabled.visible = false


func _on_submit_button_pressed() -> void:
	news_template.get_results()
	continue_button.visible = true
	buttons_enabled.visible = true

func _on_continue_button_pressed() -> void:
	# if we've finished CHUNK_SIZE articles in the session, go to Results scene
	if BrevanGlobal and BrevanGlobal.session_completed >= 5:
		get_tree().change_scene_to_file("res://Scenes/results.tscn")

	news_template.hide_results()
	continue_button.visible = false
	buttons_enabled.visible = false
	current_article += 1

	# persist progress in the autoload so sessions survive scene changes
	if BrevanGlobal:
		BrevanGlobal.progress_index = current_article

	news_template.article_id = current_article
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
