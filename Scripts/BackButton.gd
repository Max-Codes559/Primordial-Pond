extends Button




func _on_BackButton_pressed():
	Audio.sfx_play(0)
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
