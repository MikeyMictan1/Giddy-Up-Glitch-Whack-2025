extends Node

class_name Brevan

var username: String
var score: int
var highscore: int
var attempts: int
var bucks: int
var owned_outfits: Array = []
var current_outfit: String = ""


func _init(name: String, s: int = 0, hs: int = 0, a: int = 0, b: int = 0):
	username = name
	score = s
	highscore = hs
	attempts = a
	bucks = 10000
	current_outfit = ""
	owned_outfits = []
	
func add_score(amount: int):
	score += amount
	
func add_bucks(amount: int):
	bucks += amount
	
func add_attempts(amount: int):
	attempts += amount

func update_highscore(ns: int):
	highscore = ns
	
func buy_outfit(o: String):
	owned_outfits.append(o)
	
func equip_outfit(o: String):
	current_outfit = o
