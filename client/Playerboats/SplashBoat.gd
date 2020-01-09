extends KinematicBody2D

signal turn_turret(mouse_pos)
signal fire_turret(group)
export var engine_power = 800
export var wheel_base = 160
export var steering_angle = 30
export var fire_rate = 0.5
var p_owner = 'SplashBoat'
var ready_to_fire = true
var projectile = preload('res://Projectile.tscn')
var mouse_pos = Vector2()
var touch_enabled = OS.has_touchscreen_ui_hint()
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
	acceleration = Vector2.ZERO
	get_input()
	apply_friction()
	calculate_steering(delta)
	velocity += acceleration * delta
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
	
	if (touch_enabled):
		if (mob_x > 0):
			turn += mob_x
		if (mob_x < 0):
			turn += mob_x
		
		steer_angle = turn * deg2rad(steering_angle)
		
		if (mob_y > 0):
			acceleration = transform.x * (engine_power * mob_y)
		if (mob_y < 0):
			acceleration = -transform.x * (braking * mob_y)
		
		if (mob_firing):
			emit_signal('fire_turret', 1)
	
func apply_friction():
	if velocity.length() < 8:
		velocity = Vector2.ZERO
	var friction_force = velocity * velocity.length() * friction
	var drag_force = velocity * velocity.length() * drag
	
	if velocity.length() < 100:
		friction_force *= 3
	acceleration += drag_force + friction_force
	
func calculate_steering(delta):
	var rear_wheel = position - transform.x * wheel_base / 4.0
	var front_wheel = position + transform.x * wheel_base / 2.0
	
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_angle) * delta
	
	var new_heading = (front_wheel - rear_wheel).normalized()
	var traction = traction_slow
	if velocity.length() > slip_speed:
		traction = traction_fast
	
	var d = new_heading.dot(velocity.normalized())
	
	if d > 0:
		velocity = velocity.linear_interpolate(new_heading * velocity.length(), traction)
	if d < 0:
		velocity = -new_heading * min(velocity.length(), max_speed_reverse)

	rotation = new_heading.angle()

func _process(delta):
	# Override mouse position with touch here
	
	if !touch_enabled:
		mouse_pos = get_global_mouse_position()
	else:
		mouse_pos = touch_position # Mobile pos

	emit_signal("turn_turret", mouse_pos)
	set_camera_position()
	ripple_visibility()

func mobile_joystick(x, y):
	mob_x = x
	mob_y = y

func touch_aim(position):
	touch_position = position
	# This fire relative to the center of the screen, not the boats position.
	# It also does not continue to fire directly at the event unless the event is moving.
	touch_position.x += self.position.x - get_viewport_rect().size.x / 2
	touch_position.y += self.position.y - get_viewport_rect().size.y / 2

func touch_firing(isFiring):
	mob_firing = isFiring
	
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

