extends Node

class_name Brevan

var username: String
var highscore: int
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
var session_flawless_papers: int = 0
var session_percentage: float = 0.0

var lifetime_correct: int = 0
var lifetime_questions: int = 0


func _init(name: String = "Brevan", hs: int = 0, b: int = 0):
	username = name
	highscore = hs
	bucks = b
	
func add_bucks():
	bucks += 1
	emit_signal("stats_changed")

func get_bucks():
	return bucks

func get_attempts():
	return papers_completed

func get_flawless_papers():
	return flawless_papers_completed

func update_highscore():
	if session_score > highscore:
		highscore = session_score

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
	session_flawless_papers = 0
	session_percentage = 0.0
	emit_signal("stats_changed")

func get_session_score() -> int:
	return session_score

func get_session_bucks() -> int:
	return session_bucks

func get_session_percentage() -> float:
	var pct: float = (float(session_score) / 35.0) * 100.0

	return round(pct * 100.0) / 100.0

func get_lifetime_percentage() -> float:
	print("LIFETIME CORRECT: " + str(lifetime_correct))

	print("LIFETIME QUESTIONS: " + str(lifetime_questions))
	if lifetime_questions == 0:
		return 0.0
	var pct: float = (float(lifetime_correct) / float(lifetime_questions)) * 100.0
	return round(pct * 100.0) / 100.0

func add_session_flawless_papers() -> void:
	session_flawless_papers += 1
	emit_signal("stats_changed")
