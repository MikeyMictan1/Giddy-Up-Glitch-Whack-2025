extends Node

class_name SaveManager

var is_in_game: bool = false
var is_paused: bool = false

signal game_state_changed(in_game: bool)
signal pause_state_changed(paused: bool)

func set_in_game(value: bool):
	is_in_game = value
	game_state_changed.emit(is_in_game)

func set_paused(value: bool):
	is_paused = value
	get_tree().paused = value
	pause_state_changed.emit(is_paused)

func toggle_pause():
	if is_in_game:
		set_paused(!is_paused)

func save_brevan(brevan: Brevan):
	var data = {
		"username": brevan.username,
		"bucks": brevan.bucks,
		"owned_outfits": brevan.owned_outfits,
		"current_outfit": brevan.current_outfit
		}
	var file = FileAccess.open("user://brevan_data.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(data, "\t"))
	file.close()

func load_brevan() -> Brevan:
	if not FileAccess.file_exists("user://brevan_data.json"):
		return null
	var file = FileAccess.open("user://brevan_data.json", FileAccess.READ)
	var data = JSON.parse_string(file.get_as_text())
	file.close()
	if typeof(data) != TYPE_DICTIONARY:
		return null
	var brevan = Brevan.new(data.username)
	brevan.bucks = data.get("bucks", 0)
	brevan.owned_outfits = data.get("owned_outfits", [])
	brevan.current_outfit = data.get("current_outfit", "")
	return brevan
	
func reset_brevan(brevan: Brevan):
	brevan.bucks = 0
	brevan.owned_outfits.clear()
	brevan.current_outfit = ""
	
	var dir = DirAccess.open("user://")
	if dir.file_exists("brevan_data.json"):
		dir.remove("brevan_data.json")
		
	print("Brevan data reset.")

	

	
		
