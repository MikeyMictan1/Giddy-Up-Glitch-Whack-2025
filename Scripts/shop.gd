extends Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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

var brevan = Brevan.new("FAT_BEAVER")
@onready var error_bg: Panel = $Panel/ShopItems/ErrorBg
@onready var error_msg: Label = $Panel/ShopItems/ErrorBg/ErrorMsg
@onready var error_bg_2: Panel = $Panel/ShopItems/ErrorBg2
@onready var error_msg2: Label = $Panel/ShopItems/ErrorBg2/ErrorMsg
@onready var error_bg_3: Panel = $Panel/ShopItems/ErrorBg3
@onready var error_msg3: Label = $Panel/ShopItems/ErrorBg3/ErrorMsg
@onready var error_bg_4: Panel = $Panel/ShopItems/ErrorBg4
@onready var error_msg4: Label = $Panel/ShopItems/ErrorBg4/ErrorMsg
@onready var error_bg_5: Panel = $Panel/ShopItems/ErrorBg5
@onready var error_msg5: Label = $Panel/ShopItems/ErrorBg5/ErrorMsg
@onready var error_bg_6: Panel = $Panel/ShopItems/ErrorBg6
@onready var error_msg6: Label = $Panel/ShopItems/ErrorBg6/ErrorMsg
@onready var timer: Timer = $Panel/ShopItems/Timer

func _ready():
	timer.wait_time = 2.0
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)

func buy(brevan: Brevan, outfit_name: String):
	var cost = outfits[outfit_name].price
	if brevan.bucks < cost:
		if outfit_name == "outfit1":
			error_bg.visible = true
			error_msg.visible = true
		elif outfit_name == "outfit2":
			error_bg_2.visible = true
			error_msg2.visible = true
		elif outfit_name == "outfit3":
			error_bg_3.visible = true
			error_msg3.visible = true
		elif outfit_name == "outfit4":
			error_bg_4.visible = true
			error_msg4.visible = true
		elif outfit_name == "outfit5":
			error_bg_5.visible = true
			error_msg5.visible = true
		elif outfit_name == "outfit6":
			error_bg_6.visible = true
			error_msg6.visible = true
		timer.start()
		return
	brevan.bucks -= cost
	brevan.buy_outfit(outfit_name)

func _on_timer_timeout():
	error_bg.visible = false
	error_msg.visible = false
	error_bg_2.visible = false
	error_msg2.visible = false
	error_bg_3.visible = false
	error_msg3.visible = false
	error_bg_4.visible = false
	error_msg4.visible = false
	error_bg_5.visible = false
	error_msg5.visible = false
	error_bg_6.visible = false
	error_msg6.visible = false

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/MainScene.tscn")
	
func _on_buy_1_pressed() -> void:
	buy(brevan, "outfit1")

func _on_buy_2_pressed() -> void:
	buy(brevan, "outfit2")

func _on_buy_3_pressed() -> void:
	buy(brevan, "outfit3")

func _on_buy_4_pressed() -> void:
	buy(brevan, "outfit4")

func _on_buy_5_pressed() -> void:
	buy(brevan, "outfit5")

func _on_buy_6_pressed() -> void:
	buy(brevan, "outfit6")
