extends Label
var textVal = 0
var maxText = 5
var messages = ["Hello and welcome to 'Thats Whack' please press the continue button to carry on with the experience.",
"In this experience we will be testing your ability to detect and report false information. ",
"Currently you are within the main menu where you are able to either go to your profile page or begin a range of scenarios.",
"Click here to see you profile.",
"Click here to begin the scenarios.",
"Thats all from me. Good luck searching."]
@onready var profile = $"../../../Highlight Profile"
@onready var begin = $"../../../Highlight Begin"
@onready var whole  = $"../.."
@onready var block = $"../../../Panel"
@onready var brev1 = $"../../../Brevan"
@onready var brev2 = $"../../../Brevan/TextureRect"
@onready var button = $"../Button"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "Brevan the Beaver: " + messages[textVal]
	profile.hide()
	begin.hide()

func update_label_text():
	profile.hide()
	begin.hide()
	if(textVal < maxText):
		textVal = textVal + 1
		
		if (textVal == 3):
			profile.show()
		if(textVal == 4):
			begin.show()
	else:
		whole.hide()
		block.visible= false
		brev1.hide()
		brev2.hide()
	text =  "Brevan the Beaver: " + messages[textVal]
	if(textVal == maxText):
		button.text =  "Close" 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
