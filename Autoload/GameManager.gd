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
		"equipped_outfit": brevan.equipped_outfit
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
	var brevan = Brevan.new(data.username, data.bucks)
	brevan.owned_outfits = data.owned_outfits
	brevan.equipped_outfit = data.equipped_outfit
	return brevan

	

	
		
