extends Panel

# UI stuff
@onready var link: Button = $Link
@onready var headline: Button = $Article/Headline
@onready var publisher: Button = $Article/Publisher
@onready var date: Button = $Article/Date
@onready var author: Button = $Article/Author
@onready var text: Button = $Article/Text
@onready var image: Sprite2D = $Article/ImageButton/Image

var buttons = [link, headline, publisher, author, date, image, text]

@onready var report_text: RichTextLabel = $Report/ReportText

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
	print(articles)
	var article_full_id = "Article" + str(id)
	if article_full_id in articles:
		return articles[article_full_id]
	else:
		return []

func _ready() -> void:
	load_from_json("res://Scripts/news.json")
	# SET TO ZERO FOR TESTING
	article = get_article(0)
	print(article)
	link.text = article["link"]
	headline.text = article["headline"]
	publisher.text = article["publisher"]
	author.text = article["author"]
	date.text = article["date"]
	image.texture = load("res://Assets/" + article["image_name"])
	text.text = article["text"]

func get_results():
	var user_results = [0,0,0,0,0,0,0]
	var i = 0;
	for button: Button in buttons:
		if button.pressed:
			user_results[i] = 1
		i += 1
	
	if user_results == article["results"]:
		return true
	else:
		var output = ""
		for j in range(len(user_results)):
			if user_results[j] != article["results"][j]:
				output += report_reasons[j] + "\n"
		report_text.text = output
		return false

var report_reasons = [
	"This link was quite dodgy... make sure to look at the trusted domains document!",
	"The headline was quite exagerised, or it was completely made up - make sure to check the recent events.",
	"This publisher doesn't exist - check out the trusted publishers document.",
	"This author isn't trusted - check out the trusted authors document.",
	"The date in which this article was published doesn't align with the current events....",
	"This image is AI generated! Or completely irrelevant to the article....",
	"The text doesn't align with the headline at all...."
]
