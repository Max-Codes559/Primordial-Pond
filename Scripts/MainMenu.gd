extends Node2D


func _on_BtnStart_pressed():
	get_tree().change_scene("res://Scenes/MainGame.tscn")
	Audio.sfx_play(0)

func _on_BtnAquarium_pressed():
	get_tree().change_scene("res://Scenes/Aquarium.tscn")
	Audio.sfx_play(0)

func _on_BtnOptions_pressed():
	get_tree().change_scene("res://Scenes/Options.tscn")
	Audio.sfx_play(0)

func _on_BtnQuit_pressed():
	get_tree().quit()
	Audio.sfx_play(0)
