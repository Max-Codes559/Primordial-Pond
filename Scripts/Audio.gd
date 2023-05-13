extends AudioStreamPlayer

onready var SFX = get_child(0)
onready var SFX2 = get_child(1)
onready var SFX3 = get_child(2)

var currentSFX

var menuSong = preload("res://Assets/Sounds/PrimalPondsMenu.wav")
var loopSong = preload("res://Assets/Sounds/PrimalPondsLoop.wav")
var creditsSong = preload("res://Assets/Sounds/PrimalPondsCredits.wav")
var songList = [menuSong, loopSong, creditsSong]

var buttonSFX = preload("res://Assets/Sounds/SFX/SFXbutton.wav")
var alertSFX = preload("res://Assets/Sounds/SFX/SFXalert.wav")
var corkSXF = preload("res://Assets/Sounds/SFX/SFXcorkSplash.wav")
var reelSFX = preload("res://Assets/Sounds/SFX/SFXreelingloop.wav")
var waveSFX = preload("res://Assets/Sounds/SFX/SFXwavetransition.wav")

var n = 0

func _ready():
	if OS.is_debug_build():
		print("muting on debug")
		volume_db = -80

func _on_Audio_finished():
	n += 1
	if n >= 3:
		n = 0
	stream = songList[n]
	play()
	
func sfx_play(track):
	currentSFX = track
	var sfxList = [buttonSFX, alertSFX, corkSXF, reelSFX, waveSFX]
	SFX.stream = sfxList[track]
	SFX.play()
	
func sfx2_play(track):
	var sfxList = [buttonSFX, alertSFX, corkSXF, reelSFX, waveSFX]
	SFX2.stream = sfxList[track]
	SFX2.play()
	
func sfx3_play(track):
	var sfxList = [buttonSFX, alertSFX, corkSXF, reelSFX, waveSFX]
	SFX3.stream = sfxList[track]
	SFX3.play()

func _on_SFX_finished():
	if currentSFX == 2:
		SFX.stream = reelSFX
		SFX.play()
