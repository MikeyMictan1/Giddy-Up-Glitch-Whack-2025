extends Control

@export var session_score_path: NodePath
@export var solve_path: NodePath
@export var perfect_path: NodePath
@export var bucks_label_path: NodePath
@export var highscore_label_path: NodePath
@onready var session_score_label: Label = get_node_or_null(session_score_path) as Label
@onready var solve_label: Label = get_node_or_null(solve_path) as Label
@onready var bucks_label: Label = get_node_or_null(bucks_label_path) as Label
@onready var highscore_label: Label = get_node_or_null(highscore_label_path) as Label
@onready var perfect_label: Label = get_node_or_null(perfect_path) as Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if BrevanGlobal:
		if session_score_label:
			session_score_label.text = str(BrevanGlobal.session_score)
		if solve_label:
			solve_label.text = str(BrevanGlobal.session_completed)
		if bucks_label:
			bucks_label.text = str(BrevanGlobal.session_bucks)
		if highscore_label:
			highscore_label.text = str(BrevanGlobal.highscore)
		if perfect_label:
			perfect_label.text = str(BrevanGlobal.flawless_papers_completed)

func _on_main_scene_pressed() -> void:
	if BrevanGlobal:
		# add session totals into persistent totals
		BrevanGlobal.add_score() # keep compatibility if you use add_score increments elsewhere


	# update highscore if session > current highscore
	if BrevanGlobal.session_score > BrevanGlobal.highscore:
		BrevanGlobal.highscore = BrevanGlobal.session_score
		BrevanGlobal.emit_signal("stats_changed")
		
	# reset session for next run
	BrevanGlobal.reset_session()

	get_tree().change_scene_to_file("res://Scenes/MainScene.tscn")
