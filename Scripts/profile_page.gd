extends Control

@onready var back: Button = $MainPanel/Buttons/Back

# assign these in the Inspector to the actual Label nodes on your scene
@export var success_label_path: NodePath
@export var bucks_label_path: NodePath
@export var attempts_label_path: NodePath
@export var highscore_label_path: NodePath

var success_label: Label = null
var bucks_label: Label = null
var attempts_label: Label = null
var highscore_label: Label = null

func _ready():
	bucks_label = get_node_or_null(bucks_label_path) as Label
	attempts_label = get_node_or_null(attempts_label_path) as Label
	highscore_label = get_node_or_null(highscore_label_path) as Label
	success_label = get_node_or_null(success_label_path) as Label
	update_ui()
	BrevanGlobal.connect("stats_changed", Callable(self, "update_ui"))

func _on_main_scene_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainScene.tscn")

func _on_customise_character_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/shop.tscn")

func update_ui() -> void:
	if bucks_label:
		bucks_label.text = str(BrevanGlobal.get_bucks())
	if attempts_label:
		attempts_label.text = str(BrevanGlobal.get_attempts())
	if highscore_label:
		highscore_label.text = str(BrevanGlobal.highscore)
	if success_label:
		success_label.text = str(BrevanGlobal.get_lifetime_percentage()) + "%"
