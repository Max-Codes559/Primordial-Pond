extends Sprite

signal sun_hit(accuracy)

onready var Earth = get_parent()
onready var Sun = $"../Sun"
onready var Bobber = $"../../Bobber"
onready var FishingBar = $"../../FishingBar"
onready var MoonZone = $Area2D
onready var MoonZoneShape = $Area2D/CollisionShape2D

var radius = 50
var speed
var d : float
var orbit
var orbiting = false

func grass_orbit(delta):
	speed = -1.8
	d += delta
	position = Vector2(sin(d * speed) * radius, cos(d * speed) * radius)
	
func fire_orbit(delta):
	speed = -2.5
	d += delta
	position = Vector2(sin(d * speed) * 2, cos(d * speed)) * radius
	
func river_orbit(delta):
	speed = -2.5
	d += delta
	position = Vector2(sin(d * speed), cos(d * speed)) * radius * 1.12 * sin(d)
	
func mountain_orbit(delta):
	speed = -4
	d += delta
	position = Vector2(sin(d * speed) * radius, cos(d) * radius)
	
func reset():
	orbiting = false
	position = Vector2.ZERO
		
func _ready():
	Bobber.connect("fish_hooked", self, "on_fish_hooked")
	FishingBar.connect("fishing_success", self, "on_fishing_success")
	
func _process(delta):
	if orbiting == true:
		match orbit:
			"grass":
				grass_orbit(delta)
			"fire":
				fire_orbit(delta)
			"river":
				river_orbit(delta)
			"mountain":
				mountain_orbit(delta)
			
	if orbiting == true:
		if Input.is_action_just_pressed("catch"):
			if MoonZone.get_overlapping_areas().size() > 0:
				var areaname = MoonZone.get_overlapping_areas()
				areaname = areaname[0].name
				if areaname == "SunArea":
					var accuracyRadius = MoonZoneShape.get_shape().radius
					var distance = (Sun.position - position)
					var accuracy = abs(accuracyRadius * 2 - distance.length())
					emit_signal("sun_hit", accuracy)
				else:
					emit_signal("sun_hit", -2)
					Audio.sfx2_play(1)
			else:
				emit_signal("sun_hit", -2)
				Audio.sfx2_play(1)
				
func on_fish_hooked(fishType):
	orbiting = true
	match fishType:
		"Grass":
			orbit = "grass"
		"Fire":
			orbit = "fire"
		"River":
			orbit = "river"
		"Mountain":
			orbit = "mountain"

func on_fishing_success():
	reset()
