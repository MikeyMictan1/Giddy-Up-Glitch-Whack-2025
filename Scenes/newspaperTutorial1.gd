extends CanvasLayer
var textVal = 0
var maxText = 9
var messages = ["Hello again Brevan here, i see you have started your first situation allow me to show you the ropes on how this is going to work. ",
"As you can see you have been given a newspaper article and it is your job to tell whether or not it is fake. ",
"Eventually, you will be able to hover over each section of the article and select whether or not you believe it is false. ",
"Your job is to select which parts of the article (if any) are misleading or false.",
"You may be asking, how do I check if the information is correct or not?",
"Luckily for you, we have given a few trusted sources with the information required to verify these articles. Sadly they have been disbaled for now. ",
"However there are other ways in which the article can be wrong such as article content and headlines not being the same. ",
"This article is a perfect example of this. As you can see the statistic in the header and description, so the article must be false.",
"Therefore to submit your answer you should click on both the header and the description and finally press submit",
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
