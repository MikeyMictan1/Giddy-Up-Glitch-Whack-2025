extends Node2D

@onready var trusted_author_site = $CanvasLayer/Screen/HelpDocContainer/trusted_authors
@onready var trusted_publisher_site = $CanvasLayer/Screen/HelpDocContainer/trusted_publishers
@onready var trusted_domain_site = $CanvasLayer/Screen/HelpDocContainer/trusted_domains
@onready var trusted_recent_events_site = $CanvasLayer/Screen/HelpDocContainer/trusted_recent_events

@onready var helpful_documents_screen = $CanvasLayer/Screen/HelpDocContainer/helpful_doc_panel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_trusted_author_button_pressed() -> void:
	helpful_documents_screen.visible = false
	trusted_author_site.visible = true

func _on_trusted_publisher_button_pressed() -> void:
	pass # Replace with function body.


func _on_trusted_domain_button_pressed() -> void:
	pass # Replace with function body.


func _on_trusted_recent_events_button_pressed() -> void:
	pass # Replace with function body.
