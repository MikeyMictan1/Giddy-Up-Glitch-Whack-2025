extends Panel

# UI stu
@onready var Address: Button = $Address
@onready var title: Button = $Article/title
@onready var dear: Button = $"Article/Dear Statement"
@onready var footer: Button = $Article/footer
@onready var footerText: Label = $Article/footer/Label
@onready var body: Button = $Article/body
@onready var bodyText: Label = $Article/body/Label
@onready var from: Button = $Article/From
@onready var fromText: Label = $Article/From/Label

var username
func _userinput (name : String)-> void:
	print("checking smthn")
	username = name
	var temp = dear.text
	
	if (temp == "Dear" ):
		dear.text = dear.text + " " + name
		print("thing")
		print(name + " is name")
	elif (temp == "Dear " ):
		dear.text = dear.text + name
		print(name + " is name")
	else:
		dear.text = email["Dear"]
	
	
var user_results = [0,0,0,0,0,0]

@onready var report_panel: Panel = $Report
@onready var report_text: RichTextLabel = $Report/ReportText
#understand this later

# Brevan stats
var brevan: Brevan = null

# Resource stuff
@export var email_id: int
var emails = {}
var email

func load_from_json(file_path):
	var data = FileAccess.get_file_as_string(file_path)
	var parsed_data = JSON.parse_string(data)
	if parsed_data:
		emails = parsed_data
	else:
		print("Error!")

func get_article(id):
	var article_full_id = "email" + str(id)
	if article_full_id in emails:
		return emails[article_full_id]
	else:
		return []

func load_article() -> void:
	load_from_json("res://Scripts/emails.json")
	email = get_article(email_id)
	
	Address.text = email["Address"]
	Address.button_pressed = false
	title.text = email["Title"]
	title.button_pressed = false
	dear.text = email["Dear"]
	_userinput("")
	dear.button_pressed = false
	bodyText.text = email["Body"]
	body.button_pressed = false
	footerText.text = email["Footer"]
	footer.button_pressed = false
	fromText.text = email["From"]
	from.button_pressed = false


func _ready() -> void:
	hide_results()
	report_text.bbcode_enabled = true
	load_article()

	brevan = BrevanGlobal as Brevan

func get_results():	
	
	if user_results == email["results"]:
		if 0 in user_results:
			report_text.text = "Well done! This was a perfectly fine Email!"
		else:
			report_text.text = "Well done! You found all of the whacky bits in this Email!"
		report_panel.visible = true
		return true
	else:
		var green_start = "[color=#00cc00]"
		var red_start = "[color=#cc0000]"
		var end_color = "[/color]"

		var output_rights = ""
		var output_wrongs = ""
		for j in range(len(user_results)):
			if user_results[j] != email["results"][j]:
				if user_results[j] == 0:
					output_wrongs += red_start + wrong_report_reasons_w[j] + end_color + "\n"
				else:
					output_wrongs += red_start + right_report_reasons_w[j] + end_color + "\n"
			else:
				if user_results[j] == 1:
					output_rights += green_start + wrong_report_reasons_r[j] + end_color + "\n"
					brevan.add_score()
					brevan.add_bucks()
				else:
					output_rights += green_start + right_report_reasons_r[j] + end_color + "\n"
					brevan.add_score()
					brevan.add_bucks()
		report_text.text = "[b]What you got right:[/b]\n" + output_rights + "\n[b]What you got wrong:[/b]\n" + output_wrongs
		report_panel.visible = true
		print("Brevan points: ", str(brevan.get_score()))
		return false

# [user, actual] = [1,1]
var wrong_report_reasons_r = [
	"- The Address did seem foreign.",
	"- The title did indeed seem quite suspiscious.",
	"- This email did not seem to be from who we originally thought it was.",
	"- The body of the email seemed suspiscious.",
	"- The email did seem to have a suspiscous attachemt or link.",
	"- The email did not seem to be from a member of the company.",

]

# [user, actual] = [0,0]
var right_report_reasons_r = [
	"- The Address seemed to be from a trusted sender.",
	"- Title does not seem suspiscious.",
	"- Email seems to be sending to you specifically.",
	"- Email body does not seem suspiscious.",
	"- There does not seem to be anything suspiscious in the footer.",
	"- Email is from a member of your team."
]

# [user, actual] = [0,1]
var wrong_report_reasons_w = [
	"- The email address was not safe... make sure to look at the trusted email domains document!",
	"- The title was not apporpriate for a company Email, or it was not send by a member of the company - make sure to check companies policy on emails.",
	"- This email was not made for you specifically and therefore could be a scam.",
	"- This email's body does not follow the companies policy on email content - check out the companies ",
	"- This email contains a potentially harmful link or language.",
	"- This Email was not from a member of your team - Check the team member document to know who is part of your company."
]

# [user, actual] = [1,0]
var right_report_reasons_w = [
	"- The sender was actually authorised - check out the trusted domains.",
	"- Title was not suspisious.",
	"- This email was indeed aimed towards you specifically.",
	"- This emails body is indeed okay and complies with company guidelines.",
	"- There were no maliscuous links/ attachments withing this document.",
	"- This email was in fact from one of your team members and therefore not suspiscious."

]

func hide_results():
	report_panel.visible = false




	










func _on_from_toggled(toggled_on: bool) -> void:
	if toggled_on:
		user_results[5] = 1;
	else:
		user_results[5] = 0;


func _on_address_toggled(toggled_on: bool) -> void:
	if toggled_on:
		user_results[0] = 1;
	else:
		user_results[0] = 0;


func _on_title_toggled(toggled_on: bool) -> void:
	if toggled_on:
		user_results[1] = 1;
	else:
		user_results[1] = 0;


func _on_dear_statement_toggled(toggled_on: bool) -> void:
	if toggled_on:
		user_results[2] = 1;
	else:
		user_results[2] = 0;


func _on_body_toggled(toggled_on: bool) -> void:
	if toggled_on:
		user_results[3] = 1;
	else:
		user_results[3] = 0;


func _on_footer_toggled(toggled_on: bool) -> void:
	if toggled_on:
		user_results[4] = 1;
	else:
		user_results[4] = 0;
