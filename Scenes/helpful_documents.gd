extends Node2D

@onready var trusted_author_site = $CanvasLayer/Screen/HelpDocContainer/trusted_authors
@onready var trusted_publisher_site = $CanvasLayer/Screen/HelpDocContainer/trusted_publishers
@onready var trusted_domain_site = $CanvasLayer/Screen/HelpDocContainer/trusted_domains
@onready var trusted_recent_events_site = $CanvasLayer/Screen/HelpDocContainer/trusted_recent_events

@onready var helpful_documents_screen = $CanvasLayer/Screen/HelpDocContainer/helpful_doc_panel

@onready var news_template: Panel = $CanvasLayer/NewsTemplate
@onready var continue_button: Button = $CanvasLayer/ContinueButton
var current_article: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if current_article:
		news_template.article_id = current_article
	else:
		current_article = 0
		news_template.article_id = current_article

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_submit_button_pressed() -> void:
	news_template.get_results()
	continue_button.visible = true

func _on_continue_button_pressed() -> void:
	news_template.hide_results()
	continue_button.visible = false
	current_article += 1
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
