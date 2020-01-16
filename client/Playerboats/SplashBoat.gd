extends KinematicBody2D

signal turn_turret(mouse_pos)
signal fire_turret(group)
signal fire_turret_secondary
export var engine_power = 800
export var wheel_base = 160
export var steering_angle = 30
export var fire_rate = 0.5
var p_owner = 'SplashBoat'
var ready_to_fire = true
var projectile = preload('res://MachineGunProjectile.tscn')
var projectile_secondary = preload('res://Projectiles/Torpedo.tscn')
var mouse_pos = Vector2()

var acceleration = Vector2.ZERO
var velocity = Vector2.ZERO
var steer_angle = 0

var mob_x = 0
var mob_y = 0
var mob_firing = false

var ripple_opacity = 0
var rng = RandomNumberGenerator.new()
var touch_position = Vector2()
export var braking = -800
export var max_speed_reverse = 250

export var friction = -0.01
export var drag = -0.0015

export var slip_speed = 400
var traction_fast = 0.1
var traction_slow = 0.7

func _ready():
	position = Vector2(200.0, 200.0)

func _physics_process(delta):
	
	get_input()
	apply_friction()
	calculate_steering(delta)
	
	var old_vel = Vector2(velocity.x, velocity.y)
	
	velocity += acceleration * delta
	
	if (old_vel.length() > velocity.length()):
		acceleration = Vector2.ZERO
		velocity *= 0.98
	
	velocity = move_and_slide(velocity)
	
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
		emit_signal('fire_turret', 1)
		
	if (Input.is_action_pressed("fire_2")):
		emit_signal("fire_turret_secondary", 1)
	
	
func apply_friction():
	var friction_force = velocity * friction
	var drag_force = velocity * velocity.length() * drag
	
	acceleration += drag_force + friction_force

func calculate_steering(delta):
	var rear_wheel = position - transform.x * wheel_base / 4.0
	var front_wheel = position + transform.x * wheel_base / 2.0
	
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_angle) * delta
	
	var new_heading = (front_wheel - rear_wheel).normalized()
	
	rotation = new_heading.angle()
	

func _process(delta):
	# Override mouse position with touch here
	
	
	mouse_pos = get_global_mouse_position()
	emit_signal("turn_turret", mouse_pos)
	set_camera_position()
	ripple_visibility()


func set_camera_position():
	var offset = get_viewport().get_mouse_position() - self.global_position
	var x_offset = get_viewport().get_mouse_position()[0] - get_viewport_rect().size.x / 2
	var y_offset = get_viewport().get_mouse_position()[1] - get_viewport_rect().size.y / 2
	# The viewport scale is zoomed out by 3.  So we need to multiply the size by 3,
	# THEN perform normal operations
	$Camera2D.global_position[0] = self.global_position[0] - (get_viewport_rect().size.x * 3) / 2 + x_offset
	$Camera2D.global_position[1] = self.global_position[1] - (get_viewport_rect().size.y * 3) / 2 + y_offset

func ripple_visibility():
	var new_opacity = velocity.length() / 100
	
	if new_opacity > 1:
		new_opacity = 1
	
	$Tween.interpolate_property($BoatRipple, "modulate",
		Color(1, 1, 1, ripple_opacity), Color(1, 1, 1, new_opacity), 0.05,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	
	ripple_opacity = new_opacity

