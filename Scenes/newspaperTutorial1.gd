extends CanvasLayer
var textVal = 0
var maxText = 9
var messages = ["Brevan here again, I see you have started your first situation! Let me to show you the ropes. ",
"You have been given a newspaper article and it is your job to find if it is reliable.",
"You will be able to 'Flag' sections you believe are suspicious by clicking them. (e.g. Headline, Author, Publisher)",
"Your must select these parts of the article (if any) that are misleading or false.",
"You may be asking, how do I verify some of the information e.g. the Author?",
"We have given you a few trusted sources with the information required to verify these articles. ",
"However, there are other ways an article can be wrong such as article content and headlines not matching up. ",
"This article is a perfect example. The statistic in the header doesn't match the description, so the article must be false.",
"To submit your answer you should click on the header, description, and finally press submit!",
] 
@onready var text1 = $MarginContainer/Panel/Label
@onready var brevBox = $Brevan
@onready var brev = $Brevan/Beaver
@onready var block =$blocker
@onready var textbox  = $MarginContainer
@onready var button = $MarginContainer/Panel/Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if BrevanGlobal.game_tutorial_finished:
		textbox.visible = false
		brevBox.visible= false
		block.visible = false
		brev.visible= false
	else:
		text1.text = "Brevan the Beaver: " + messages[textVal]

func update_label_text():
	if(textVal < maxText - 1):
		if (textVal == 5):
			brevBox.visible= false
			brev.visible= false
		if (textVal == 6):
			brevBox.visible= true
			brev.visible= true
		text1.text =  "Brevan the Beaver: " + messages[textVal]
	else:
		block.visible= false
	textVal = textVal + 1
	if(textVal == maxText - 1):
		button.text =  "Close"
	if(textVal == maxText):
		BrevanGlobal.game_tutorial_finished = true
		
		textbox.visible = false
		brevBox.visible= false
		block.visible = false
		brev.visible= false

func _on_button_pressed() -> void:
	update_label_text()
	pass # Replace with function body.
