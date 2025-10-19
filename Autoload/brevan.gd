extends Node

class_name Brevan

var username: String
var score: int
var highscore: int
var attempts: int
var bucks: int
var owned_outfits: Array = []
var current_outfit: String = ""
var papers_completed : int = 0
var flawless_papers_completed : int = 0
var progress_index: int = 0

# Session tracking
var session_score: int = 0
var session_bucks: int = 0
var session_completed: int = 0


func _init(name: String = "Brevan", s: int = 0, hs: int = 0, a: int = 0, b: int = 0):
	username = name
	score = s
	highscore = hs
	attempts = a
	bucks = b

func add_flawless_paper():
	flawless_papers_completed += 1
	emit_signal("stats_changed")

func add_paper():
	papers_completed += 1
	emit_signal("stats_changed")

func add_score():
	score += 1
	emit_signal("stats_changed")
	
func add_bucks():
	bucks += 1
	emit_signal("stats_changed")
	
func add_attempts():
	attempts += 1
	emit_signal("stats_changed")

func get_score():
	return score

func get_bucks():
	return bucks

func get_attempts():
	return attempts

func get_papers():
	return papers_completed

func get_flawless_papers():
	return flawless_papers_completed

func update_highscore():
	if score > highscore:
		highscore = score
	
	score = 0
	emit_signal("stats_changed")

func buy_outfit(o: String):
	owned_outfits.append(o)
	emit_signal("stats_changed")
	
func equip_outfit(outfit: String):
	current_outfit = outfit
	emit_signal("stats_changed")

func advance_progress(n: int, total_items: int) -> void:
	if total_items <= 0:
		progress_index = 0
	else:
		progress_index = (progress_index + n) % total_items
	emit_signal("stats_changed")

# session helpers
func add_session_score(n: int) -> void:
	session_score += n
	emit_signal("stats_changed")

func add_session_bucks(n: int) -> void:
	session_bucks += n
	emit_signal("stats_changed")

func increment_session_completed() -> void:
	session_completed += 1
	emit_signal("stats_changed")

func reset_session() -> void:
	session_score = 0
	session_bucks = 0
	session_completed = 0
	emit_signal("stats_changed")

func get_session_score() -> int:
	return session_score

func get_session_bucks() -> int:
	return session_bucks
