extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/CharacterCustomisation.tscn")
	
func _on_buy_1_pressed() -> void:
	pass # Replace with function body.

func _on_buy_2_pressed() -> void:
	pass # Replace with function body.

func _on_buy_3_pressed() -> void:
	pass # Replace with function body.

func _on_buy_4_pressed() -> void:
	pass # Replace with function body.

func _on_buy_5_pressed() -> void:
	pass # Replace with function body.

func _on_buy_6_pressed() -> void:
	pass # Replace with function body.
	
var outfits = {
	"outfit1": {
		"price": 50,
		"image": "something.jpg"
	},
	"outfit2": {
		"price": 50,
		"image": "something.jpg"
	},
	"outfit3": {
		"price": 50,
		"image": "something.jpg"
	},
	"outfit4": {
		"price": 50,
		"image": "something.jpg"
	},
	"outfit5": {
		"price": 50,
		"image": "something.jpg"
	},
	"outfit6": {
		"price": 50,
		"image": "something.jpg"
	},
	
}

func buy(brevan: Brevan, outfit_name: String):
	var cost = outfits[outfit_name].price
	if brevan.bucks < cost:
		print("you spent all your money on pizz")
		return
	brevan.bucks -= cost
	brevan.buy_outfit(outfit_name)
