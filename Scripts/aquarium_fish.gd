extends Sprite



var speed = -0.1
var velocity
var d : float
var radius = 0.5

	
func _process(delta):
	d += delta
	position += Vector2(sin(d) * radius * speed + sin(d) * 3 * speed, cos(d) * radius * speed)
