extends Node2D

export (Resource) var fishOwned

func _ready():
	if Global.Grass:
		$Grass.visible = true
	if Global.Fire:
		$Volcano.visible = true
	if Global.River:
		$River.visible = true
	if Global.Mountain:
		$Mountains.visible = true
