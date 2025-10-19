extends Panel

# Brevan info
const CHUNK_SIZE: int = 5
const POINTS_PER_CORRECT: int = 1
const BUCKS_PER_CORRECT: int = 1

# UI stuff
@onready var link: Button = $Link
@onready var headline: Button = $Article/Headline
@onready var publisher: Button = $Article/Publisher
@onready var date: Button = $Article/Date
@onready var author: Button = $Article/Author
@onready var text: Button = $Article/Text
@onready var image_button: Button = $Article/ImageButton
@onready var image: Sprite2D = $Article/ImageButton/Image

var user_results = [0,0,0,0,0,0,0]

@onready var report_panel: Panel = $Report
@onready var report_text: RichTextLabel = $Report/ReportText

# Brevan stats
var brevan: Brevan = null

# Resource stuff
@export var article_id: int
var articles = {}
var article

func load_from_json(file_path):
	var data = FileAccess.get_file_as_string(file_path)
	var parsed_data = JSON.parse_string(data)
	if parsed_data:
		articles = parsed_data
	else:
		print("Error!")

func get_article(id):
	var article_full_id = "Article" + str(id)
	if article_full_id in articles:
		return articles[article_full_id]
	else:
		return []

func load_article() -> void:
	article_id = BrevanGlobal.progress_index if BrevanGlobal else 0
	
	# Resets as 20 to make sure no crashes
	if article_id >= 20:
		article_id = 0
		BrevanGlobal.progress_index = 0
		
	load_from_json("res://Scripts/news.json")
	article = get_article(article_id)
	
	link.text = article["link"]
	link.button_pressed = false
	headline.text = article["headline"]
	headline.button_pressed = false
	publisher.text = article["publisher"]
	publisher.button_pressed = false
	author.text = article["author"]
	author.button_pressed = false
	date.text = article["date"]
	date.button_pressed = false
	image.texture = load("res://Assets/" + article["image_name"])
	image_button.button_pressed = false
	text.text = article["text"]
	text.button_pressed = false

func _ready() -> void:
	hide_results()
	report_text.bbcode_enabled = true
	load_article()

	brevan = BrevanGlobal as Brevan

func get_results():	
	# determine the window of items to grade this round
	var total = len(user_results)
	var start_idx = 0
	if brevan:	
		start_idx = brevan.progress_index
	var end_idx = min(start_idx + CHUNK_SIZE, total)
	var chunk_correct_count: int = 0
	var chunk_incorrect_count: int = 0

	var green_start = "[color=#00cc00]"
	var red_start = "[color=#cc0000]"
	var end_color = "[/color]"

	var output_rights = ""
	var output_wrongs = ""
	
	if user_results == article["results"]:
		if 0 in user_results:
			report_text.text = "Well done! This was a perfectly fine news-site!"
		else:
			report_text.text = "Well done! You found all of the whacky bits in this article!"
		report_panel.visible = true
		return true

	else:
		for j in range(start_idx, end_idx):
			if user_results[j] != article["results"][j]:
				chunk_incorrect_count += 1 # counts how many incorrect answers
				if user_results[j] == 0:
					output_wrongs += red_start + wrong_report_reasons_w[j] + end_color + "\n"
				else:
					output_wrongs += red_start + right_report_reasons_w[j] + end_color + "\n"
			else:
				chunk_correct_count += 1 # Counts how many correct answers
				if user_results[j] == 1:
					output_rights += green_start + wrong_report_reasons_r[j] + end_color + "\n"

				else:
					output_rights += green_start + right_report_reasons_r[j] + end_color + "\n"

	# compute article score (score for this single article)
	var article_score = chunk_correct_count * POINTS_PER_CORRECT
	var article_bucks = chunk_correct_count * BUCKS_PER_CORRECT

	if brevan:
		# accumulate into session (not persistent totals yet)
		brevan.add_session_score(article_score)
		brevan.add_session_bucks(article_bucks)
		brevan.increment_session_completed()

	# show report for this article
	if chunk_correct_count == (end_idx - start_idx) and (end_idx - start_idx) > 0:
		report_text.text = "Well done! You scored " + str(article_score) + " on this article."
	else:
		report_text.text = "[b]What you got right:[/b]\n" + output_rights + "\n[b]What you got wrong:[/b]\n" + output_wrongs + "\n\nYou scored " + str(article_score) + " on this article."

	report_panel.visible = true

	# if we've finished CHUNK_SIZE articles in the session, go to Results scene
	if brevan and brevan.session_completed >= CHUNK_SIZE:
		get_tree().change_scene_to_file("res://Scenes/results.tscn")

	return false

# [user, actual] = [1,1]
var wrong_report_reasons_r = [
	"- The link was indeed dodgy.",
	"- The headline was... definitely not true.",
	"- The publisher doesn't exist.",
	"- The author doesn't exist.",
	"- The article was published before the corresponding event - the date was wrong.",
	"- The image was weird.",
	"- The text was... definitely not true."
]

# [user, actual] = [0,0]
var right_report_reasons_r = [
	"- The link was from a trusted domain.",
	"- The headline was accurate.",
	"- The publisher was trusted.",
	"- The author was trusted.",
	"- There was no problems with the date.",
	"- There was no problems with the image.",
	"- The text aligned with the headline."
]

# [user, actual] = [0,1]
var wrong_report_reasons_w = [
	"- This link was quite dodgy... make sure to look at the trusted domains document!",
	"- The headline was quite exaggerated, or it was completely made up - make sure to check the recent events.",
	"- This publisher doesn't exist - check out the trusted publishers document.",
	"- This author isn't trusted - check out the trusted authors document.",
	"- The date in which this article was published doesn't align with the current events....",
	"- This image is AI generated! Or completely irrelevant to the article....",
	"- The text is very exaggerated...."
]

# [user, actual] = [1,0]
var right_report_reasons_w = [
	"- The link was actually okay - check out the trusted domains.",
	"- The headline was accurate.",
	"- The publisher does exist - check out the publishers document.",
	"- This author is trusted - check out the trusted authors document.",
	"- There's nothing wrong with this date.",
	"- Image is okay.",
	"- Everything in the text is fine."
]

func hide_results():
	report_panel.visible = false


func _on_link_toggled(toggled_on: bool) -> void:
	if toggled_on:
		user_results[0] = 1;
	else:
		user_results[0] = 0;

func _on_headline_toggled(toggled_on: bool) -> void:
	if toggled_on:
		user_results[1] = 1;
	else:
		user_results[1] = 0;

func _on_publisher_toggled(toggled_on: bool) -> void:
	if toggled_on:
		user_results[2] = 1;
	else:
		user_results[2] = 0;

func _on_author_toggled(toggled_on: bool) -> void:
	if toggled_on:
		user_results[3] = 1;
	else:
		user_results[3] = 0;

func _on_date_toggled(toggled_on: bool) -> void:
	if toggled_on:
		user_results[4] = 1;
	else:
		user_results[4] = 0;

func _on_image_button_toggled(toggled_on: bool) -> void:
	if toggled_on:
		user_results[5] = 1;
	else:
		user_results[5] = 0;

func _on_text_toggled(toggled_on: bool) -> void:
	if toggled_on:
		user_results[6] = 1;
	else:
		user_results[6] = 0;
