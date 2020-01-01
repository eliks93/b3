extends "res://Boat.gd"

signal fire_turret(group)
signal turn_turret(mouse_pos)
onready var bar = $Bar/TextureProgress
# Called when the node enters the scene tree for the first time.
func _ready():
	$Turret1.connect("spawn_projectile", self, "_spawn_projectile")
	$Turret2.connect("spawn_projectile", self, "_spawn_projectile")
	$Turret3.connect("spawn_projectile", self, "_spawn_projectile")
	var player_max_health = hp
	bar.max_value = player_max_health
	update_health(player_max_health)

func _process(delta):
	emit_signal("turn_turret", get_global_mouse_position())

func get_input():
	var turn = 0
	if Input.is_action_just_pressed("space"):
		take_damage(10)
	if Input.is_action_pressed("steer_right"):
		turn += 1
	if Input.is_action_pressed("steer_left"):
		turn -= 1
	
	steer_angle = turn * deg2rad(steering_angle)
	
	if Input.is_action_pressed("accelerate"):
		acceleration = transform.x * engine_power
	
	if Input.is_action_pressed("brake"):
		acceleration = transform.x * braking
	
	if (Input.is_action_pressed("fire_1")):
		emit_signal("fire_turret", 1)

func _on_PlayerBoat_health_changed(player_health):
	update_health(player_health)

func update_health(new_value):
	bar.value = new_value

	
