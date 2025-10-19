extends Node

#class_name Brevan

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

# tutorial tracking
var game_tutorial_finished : bool = false
var menu_tutorial_finished : bool = false

# email sessions
var email_progress_index: int = 0
var email_session_score: int = 0
var email_session_bucks: int = 0
var email_session_completed: int = 0
var email_session_flawless_emails: int = 0
var email_session_percentage: float = 0.0



func _init(name: String = "Brevan", hs: int = 0, b: int = 0):
	username = name
	highscore = hs
	bucks = b

func _ready() -> void:

	# auto-save when stats change
	connect("stats_changed", Callable(self, "save_to_disk"))

	# load saved data when autoload starts
	load_from_disk()
	# optional: also save on application quit
	get_tree().connect("quit_requested", Callable(self, "save_to_disk"))

func reset_brevan() -> void:
	# reset persistent fields
	username = "Brevan"
	highscore = 0
	bucks = 0
	owned_outfits = []
	current_outfit = ""
	papers_completed = 0
	flawless_papers_completed = 0
	progress_index = 0

	# reset session fields
	session_score = 0
	session_bucks = 0
	session_completed = 0
	session_flawless_papers = 0
	session_percentage = 0.0

	# reset lifetime / tutorial tracking
	lifetime_correct = 0
	lifetime_questions = 0
	game_tutorial_finished = false
	menu_tutorial_finished = false

	# persist the reset immediately and reload so in-memory state matches disk
	save_to_disk()
	load_from_disk()

	# notify listeners once more after reset
	emit_signal("stats_changed")

func save_to_disk() -> void:
	var data := {
	"username": username,
	"highscore": highscore,
	"bucks": bucks,
	"owned_outfits": owned_outfits,
	"current_outfit": current_outfit,
	"papers_completed": papers_completed,
	"flawless_papers_completed": flawless_papers_completed,
	"progress_index": progress_index,
	"lifetime_correct": lifetime_correct,
	"lifetime_questions": lifetime_questions,
	"game_tutorial_finished": game_tutorial_finished,
	"menu_tutorial_finished": menu_tutorial_finished
	}
	# serialize
	print("ATTEMPTING TO SAVE BREVAN DATA...")
	var serializer = JSON.new()
	var json_text: String = ""
	if serializer.has_method("stringify"):
		json_text = serializer.stringify(data)  # Godot 4+
	elif serializer.has_method("print"):
		json_text = serializer.print(data)      # Godot 3.x
	else:
		push_error("No JSON serializer available on this engine version")
		return

	var virtual_path := "user://brevan_save.json"
	# show the real path so you can open it in Explorer/Finder
	var real_path := ProjectSettings.globalize_path(virtual_path)
	print("Saving Brevan data to: ", virtual_path, " -> ", real_path)

	# ensure directory exists if using subfolders (not needed for user://root)
	# var dir := DirAccess.open(ProjectSettings.globalize_path("user://saves"))
	# DirAccess.make_dir_recursive(ProjectSettings.globalize_path("user://saves"))

	var f := FileAccess.open(virtual_path, FileAccess.WRITE)
	if f == null:
		push_error("Failed to open save file for writing: " + virtual_path)
		return

	f.store_string(json_text)
	f.close()
	print("Brevan save successful:", real_path)

func load_from_disk() -> void:
	var path := "user://brevan_save.json"
	if not FileAccess.file_exists(path):
		return

	var s: String = FileAccess.get_file_as_string(path)
	if s == "":
		return

	var parsed = JSON.parse_string(s)
	# JSON.parse_string in your project returns a Dictionary or a parse-result struct;
	# handle the common Dictionary case first
	var data: Dictionary = {}
	if typeof(parsed) == TYPE_DICTIONARY:
		data = parsed

	elif typeof(parsed) == TYPE_OBJECT and parsed.has("result"):
		# JSON.parse_string returned a JSONParseResult-like object
		data = parsed.result
	else:
		return

	username = data.get("username", username)
	highscore = int(data.get("highscore", highscore))
	bucks = int(data.get("bucks", bucks))
	owned_outfits = data.get("owned_outfits", owned_outfits)
	current_outfit = data.get("current_outfit", current_outfit)
	papers_completed = int(data.get("papers_completed", papers_completed))
	flawless_papers_completed = int(data.get("flawless_papers_completed", flawless_papers_completed))
	progress_index = int(data.get("progress_index", progress_index))
	lifetime_correct = int(data.get("lifetime_correct", lifetime_correct))
	lifetime_questions = int(data.get("lifetime_questions", lifetime_questions))
	game_tutorial_finished = bool(data.get("game_tutorial_finished", game_tutorial_finished))
	menu_tutorial_finished = bool(data.get("menu_tutorial_finished", menu_tutorial_finished))

	# emit so any UI updates happen once load completes
	emit_signal("stats_changed")


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
	print("EMITTING THE SIGNAL AND HIGH SCORE UPDATED TO: " + str(highscore))
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





# EMAIL SESSION STUFF
func add_email_session_score(n: int) -> void:
	email_session_score += n
	emit_signal("stats_changed")

func add_email_session_bucks(n: int) -> void:
	email_session_bucks += n
	emit_signal("stats_changed")

func increment_email_session_completed() -> void:
	email_session_completed += 1
	emit_signal("stats_changed")

func add_email_session_flawless_emails() -> void:
	email_session_flawless_emails += 1
	emit_signal("stats_changed")

func email_reset_session() -> void:
	email_session_score = 0
	email_session_bucks = 0
	email_session_completed = 0
	email_session_flawless_emails = 0
	email_session_percentage = 0.0
	emit_signal("stats_changed")

func get_email_session_percentage() -> float:
	var pct: float = (float(email_session_score) / 30.0) * 100.0

	return round(pct * 100.0) / 100.0
