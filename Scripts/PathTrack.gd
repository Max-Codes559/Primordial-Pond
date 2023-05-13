extends Node2D

onready var Track = get_parent()

var speed = 40

func _physics_process(delta):
	Track.set_offset(Track.get_offset() + speed * delta)
