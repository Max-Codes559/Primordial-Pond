extends ProgressBar

signal fishing_success

onready var Moon = $"../Earth/Moon"

func _ready():
	Moon.connect("sun_hit", self, "on_sun_hit")
	
func on_sun_hit(accuracy):
	value += 2 * accuracy
	if value >= 100:
		value = 0
		emit_signal("fishing_success")
		Audio.currentSFX = null
		Audio.SFX.stream = null
		
