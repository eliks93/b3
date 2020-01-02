extends "res://Boat.gd"

signal fire_turret(group)

var mouse_pos

# Called when the node enters the scene tree for the first time.
func _ready():
	$Turret1.connect("spawn_projectile", self, "_spawn_projectile")
	$Turret2.connect("spawn_projectile", self, "_spawn_projectile")
	$Turret3.connect("spawn_projectile", self, "_spawn_projectile")

func _process(delta):
	pass

func get_input():
	var turn = 0
	
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

remote func update_position(packet):
	mouse_pos = packet.mouse_pos
	position.x = packet.position.x
	position.y = packet.position.y
	rotation = packet.rotation
	acceleration = packet.acceleration
	velocity = packet.velocity















































