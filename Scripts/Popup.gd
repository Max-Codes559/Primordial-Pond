extends Node2D

onready var fish = $Fish
onready var Bobber = $"../Bobber"
onready var FishLabel = $Label

var river = preload("res://Assets/Fish/diftingmola.png")
var mountain = preload("res://Assets/Fish/eel.png")
var grass = preload("res://Assets/Fish/grassygoldfish.png")
var fire = preload("res://Assets/Fish/firebeta.png")

func _ready():
	Bobber.connect("fish_caught", self,"on_fish_caught")
	get_parent().connect("fish_caught", self,"on_fish_caught")
func _on_Timer_timeout():
	queue_free()
	
func on_fish_caught(fishType):
	match fishType:
		"Grass":
			fish.texture = grass
			FishLabel.text = "Grassy Goldfish"
		"Fire":
			fish.texture = fire
			FishLabel.text = "Fire Beta"
		"River":
			fish.texture = river
			FishLabel.text = "Drifting Mola"
		"Mountain":
			fish.texture = mountain
			FishLabel.text = "Mountain Eel"
