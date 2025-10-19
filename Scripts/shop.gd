extends Control

var outfits = {
	"outfit1": {
		"price": 30,
		"image": "something.jpg"
	},
	"outfit2": {
		"price": 50,
		"image": "something.jpg"
	},
	"outfit3": {
		"price": 20,
		"image": "something.jpg"
	},
	"outfit4": {
		"price": 25,
		"image": "something.jpg"
	},
	"outfit5": {
		"price": 40,
		"image": "something.jpg"
	},
	"outfit6": {
		"price": 25,
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
@onready var buy_1: Button = $Panel/Buttons/buy1
@onready var buy_2: Button = $Panel/Buttons/buy2
@onready var buy_3: Button = $Panel/Buttons/buy3
@onready var buy_4: Button = $Panel/Buttons/buy4
@onready var buy_5: Button = $Panel/Buttons/buy5
@onready var buy_6: Button = $Panel/Buttons/buy6
@onready var beaver: Sprite2D = $Panel/Brevan/Beaver
@onready var wallet_amt: Label = $"top bar/WalletAmt"

func _ready():
	timer.wait_time = 2.0
	timer.one_shot = true
	timer.timeout.connect(_on_timer_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if brevan.current_outfit == "outfit1":
		beaver.cur_beaver = "brainrot"
	elif brevan.current_outfit == "outfit2":
		beaver.cur_beaver = "chappell"
	elif brevan.current_outfit == "outfit3":
		beaver.cur_beaver = "cowboy"
	elif brevan.current_outfit == "outfit4":
		beaver.cur_beaver = "louis"
	elif brevan.current_outfit == "outfit5":
		beaver.cur_beaver = "mariachi"
	elif brevan.current_outfit == "outfit6":
		beaver.cur_beaver = "suit"
	elif brevan.current_outfit == "base":
		beaver.cur_beaver = "base_beaver"
	
	wallet_amt.text = "Wallet: " + str(brevan.bucks) + " Bucks"
		
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
		
	if outfit_name == "outfit1":
		buy_1.text = "Press to Equip"
	elif outfit_name == "outfit2":
		buy_2.text = "Press to Equip"
	elif outfit_name == "outfit3":
		buy_3.text = "Press to Equip"
	elif outfit_name == "outfit4":
		buy_4.text = "Press to Equip"
	elif outfit_name == "outfit5":
		buy_5.text = "Press to Equip"
	elif outfit_name == "outfit6":
		buy_6.text = "Press to Equip"

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
	get_tree().change_scene_to_file("res://Scenes/profile_page.tscn")
	
func _on_reset_button_pressed() -> void:
	brevan.equip_outfit("base")
	
func _on_buy_1_pressed() -> void:
	if "outfit1" in brevan.owned_outfits:
		brevan.equip_outfit("outfit1")
	else:
		buy(brevan, "outfit1")

func _on_buy_2_pressed() -> void:
	if "outfit2" in brevan.owned_outfits:
		brevan.equip_outfit("outfit2")
	else:
		buy(brevan, "outfit2")

func _on_buy_3_pressed() -> void:
	if "outfit3" in brevan.owned_outfits:
		brevan.equip_outfit("outfit3")
	else:
		buy(brevan, "outfit3")

func _on_buy_4_pressed() -> void:
	if "outfit4" in brevan.owned_outfits:
		brevan.equip_outfit("outfit4")
	else:
		buy(brevan, "outfit4")

func _on_buy_5_pressed() -> void:
	if "outfit5" in brevan.owned_outfits:
		brevan.equip_outfit("outfit5")
	else:
		buy(brevan, "outfit5")

func _on_buy_6_pressed() -> void:
	if "outfit6" in brevan.owned_outfits:
		brevan.equip_outfit("outfit6")
	else:
		buy(brevan, "outfit6")
