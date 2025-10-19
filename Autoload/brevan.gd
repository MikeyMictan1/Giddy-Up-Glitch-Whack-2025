extends Node

#class_name Brevan

var username: String
var score: int
var highscore: int
var attempts: int
var bucks: int
var owned_outfits: Array = []
var current_outfit: String = ""


func _init(name: String = "Brevan", s: int = 0, hs: int = 0, a: int = 0, b: int = 0):
	username = name
	score = s
	highscore = hs
	attempts = a
	bucks = b
	current_outfit = ""

func add_score():
	score += 5
	emit_signal("stats_changed")
	
func add_bucks():
	bucks += 5
	emit_signal("stats_changed")
	
func add_attempts():
	attempts += 1
	emit_signal("stats_changed")

func get_score():
	return score

func get_bucks():
	return bucks

func get_attempts():
	return attempts

func update_highscore(ns: int):
	highscore = ns
	emit_signal("stats_changed")
	
func buy_outfit(o: String):
	owned_outfits.append(o)
	emit_signal("stats_changed")
	
func equip_outfit(outfit: String):
	current_outfit = outfit
	emit_signal("stats_changed")
