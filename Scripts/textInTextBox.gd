extends Label
var textVal = 0
var maxText = 5
var messages = ["Hello and welcome to 'Thats Whack' please press the continue button to carry on with the experience.",
"In this experience we will be testing your ability to detect and report false information. ",
"Currently you are within the main menu where you are able to either go to your profile page or begin a range of scenarios.",
"Click here to see you profile.",
"Click here to begin the scenarios.",
"Thats all from me. Good luck searching."]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = messages[textVal]

func update_label_text():
	if(textVal < maxText):
		textVal = textVal + 1
	text = messages[textVal]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
