extends KinematicBody2D

signal fish_hooked(type)
signal fish_caught(type)

onready var CatchZone = $Area2D
onready var FishingBar = $"../FishingBar"
onready var Anim = $AnimationPlayer

var velocity = Vector2.ZERO
var speed = 0
var direction = Vector2.ZERO
var maxSpeed = 240
var catching = false

var fishOnHook

func basic_movement():
	move_and_slide(velocity, Vector2.ZERO)
	if catching != true:
		if Input.is_action_pressed("left"):
			direction.x -= 1
		if Input.is_action_pressed("right"):
			direction.x += 1
		if Input.is_action_pressed("up"):
			direction.y -= 1
		if Input.is_action_pressed("down"):
			direction.y += 1
		
		if Input.is_action_pressed("left") or Input.is_action_pressed("right") or Input.is_action_pressed("up") or Input.is_action_pressed("down"):
			speed = lerp(speed, maxSpeed, 0.2)
		direction = direction.normalized()
		velocity = speed * direction
		speed = lerp(speed, 0, 0.3)
	
func catch():
	if Input.is_action_just_pressed("catch") and catching == false:
		if CatchZone.get_overlapping_areas().size() > 0:
			var areaname = CatchZone.get_overlapping_areas()
			var areanode = areaname[0]
			areaname = areaname[0].name
			if areaname == "FishArea":
				catching = true
				fishOnHook = areanode.get_parent().name
				emit_signal("fish_hooked", fishOnHook)
				print(fishOnHook, " is hooked!")
				areanode.get_parent().hooked()
				velocity = Vector2.ZERO
				Audio.sfx_play(2)
	
func _ready():
	Anim.play("Cork")
	FishingBar.connect("fishing_success", self, "on_fishing_success")
	
func _physics_process(delta):
	basic_movement()

func _input(event):
	catch()
	
func on_fishing_success():
	catching = false
	emit_signal("fish_caught", fishOnHook)
	

