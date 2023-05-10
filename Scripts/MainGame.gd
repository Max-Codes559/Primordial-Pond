extends Node2D

const FishPopup = preload("res://Scenes/Popup.tscn")

signal fish_caught(type)
#only for giving popup data

onready var FishingBar = $FishingBar
onready var Bobber = $Bobber

onready var Anim1 = $BackGrounds/Cloud1/AnimationPlayer
onready var Anim2 = $"BackGrounds/Cloud Fisher/AnimationPlayer"

onready var GrassFish = $Grass
onready var FireFish = $Fire
onready var RiverFish
onready var MountainFish = $Mountain

export (Resource) var fishOwned

func free_fish():
	if Global.Grass == true:
		GrassFish.queue_free()
	if Global.Fire == true:
		FireFish.queue_free()
	if Global.River == true:
		RiverFish.queue_free()
	if Global.Mountain == true:
		MountainFish.queue_free()

func _ready():
	Audio.sfx3_play(4)
	Anim1.play("bobbing")
	Anim2.play("bobbing2")
	free_fish()
	FishingBar.connect("fishing_success", self, "on_fishing_success")
	Bobber.connect("fish_caught", self, "on_fish_caught")
	
func on_fishing_success():
	print("fishing success recieved")
	
func on_fish_caught(fishType):
	var newPopup = FishPopup.instance()
	add_child(newPopup)
	newPopup.position = Vector2(517, 327)
	emit_signal("fish_caught", fishType)
	match fishType:
		"Grass":
			Global.Grass = true
		"Fire":
			Global.Fire = true
		"River":
			Global.River = true
		"Mountain":
			Global.Mountain = true


func _on_Timer_timeout():
	Audio.sfx3_play(4)
