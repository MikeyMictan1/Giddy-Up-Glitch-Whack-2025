extends Panel

# Session/scoring config (mirror news_template)
const CHUNK_SIZE: int = 5
const POINTS_PER_CORRECT: int = 1
const BUCKS_PER_CORRECT: int = 1

# UI stuff
@onready var Address: Button = $Address
@onready var title: Button = $Article/title
@onready var dear: Button = $Article/DearStatement
@onready var footer: Button = $Article/footer
@onready var footerText: Label = $Article/footer/Label
@onready var body: Button = $Article/body
@onready var bodyText: Label = $Article/body/Label
@onready var from: Button = $Article/From
@onready var fromText: Label = $Article/From/Label

var user_results = [0,0,0,0,0,0]

@onready var report_panel: Panel = $Report
@onready var report_text: RichTextLabel = $Report/ReportText

var username = ""

func _userinput (player_name : String)-> void:
	print("checking smthn")
	username = player_name
	var temp = email["Dear"]
	print (temp)
	
	if (temp == "Dear" ):
		dear.text = dear.text + " " + player_name
		print("thing")
		print(player_name + " is name")
	elif (temp == "Dear " ):
		dear.text = dear.text + player_name
		print(player_name + " is name")
	else:
		dear.text = email["Dear"]
	

#understand this later

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
	# Use global progress for which email to load
	email_id = BrevanGlobal.email_progress_index if BrevanGlobal else 0

	# Resets as 6 to make sure no crashes
	if email_id >= 6:
		email_id = 0
		BrevanGlobal.email_progress_index = 0

	load_from_json("res://Scripts/emails.json")
	email = get_article(email_id)
	
	Address.text = email["Address"]
	Address.button_pressed = false
	title.text = email["Title"]
	title.button_pressed = false
	dear.text = email["Dear"]
	_userinput(username)
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

func get_results():
	# determine the window of items to grade this round
	var total = len(user_results)
	var start_idx = 0
	if BrevanGlobal:
		start_idx = BrevanGlobal.progress_index
	var end_idx = min(start_idx + CHUNK_SIZE, total)
	var chunk_correct_count: int = 0
	var chunk_incorrect_count: int = 0

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
			chunk_correct_count += 1
			if user_results[j] == 1:
				output_rights += green_start + wrong_report_reasons_r[j] + end_color + "\n"
			else:
				output_rights += green_start + right_report_reasons_r[j] + end_color + "\n"

	# compute score for this email (6 checks)
	var article_score = chunk_correct_count * POINTS_PER_CORRECT
	var article_bucks = chunk_correct_count * BUCKS_PER_CORRECT

	if BrevanGlobal:
		# flawless email (all 6 correct)
		if article_score == 6:
			BrevanGlobal.add_email_session_flawless_emails()
		# accumulate into session totals
		BrevanGlobal.add_email_session_score(article_score)
		BrevanGlobal.add_email_session_bucks(article_bucks)
		BrevanGlobal.increment_email_session_completed()

	# show per-email report with totals
	report_text.bbcode_text = "[b]What you got right:[/b]\n" + output_rights + "\n[b]What you got wrong:[/b]\n" + output_wrongs + "\nYou scored " + str(article_score) + "/6 on this email!\n\n" + str(BrevanGlobal.email_session_completed) + " out of 5 emails completed"
	report_panel.visible = true

	return article_score

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
