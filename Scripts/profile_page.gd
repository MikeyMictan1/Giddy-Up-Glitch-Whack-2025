extends Control

@onready var back: Button = $MainPanel/Buttons/Back
const MAIN_SCENE = preload("uid://ccarxryw6scdg")

func _ready():
	back.pressed.connect(_button_pressed)

func _button_pressed():
	get_tree().change_scene_to(MAIN_SCENE)
	
	
