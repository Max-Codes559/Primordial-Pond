extends Sprite

onready var Bobber = $"../Bobber"

var speed = -0.1
var velocity
var d : float
var radius = 0.5
var swimming = true

func hooked():
	Bobber.connect("fish_caught", self, "on_fish_caught")
	swimming = false
	
func on_fish_caught(_type):
	queue_free()
	
func _process(delta):
	if swimming == true:
		d += delta
		position += Vector2(sin(d) * radius * speed + sin(d)* 5 * speed, cos(d) * radius * speed)
