extends KinematicBody2D

signal update_position
signal health_changed

export var hp = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

export var engine_power = 800
export var wheel_base = 160
export var steering_angle = 30

var acceleration = Vector2.ZERO
var velocity = Vector2.ZERO
var steer_angle = 0

export var braking = -800
export var max_speed_reverse = 250

export var friction = -0.01
export var drag = -0.0015

export var slip_speed = 400
var traction_fast = 0.1
var traction_slow = 0.7

func _physics_process(delta):
	acceleration = Vector2.ZERO
	get_input()
	apply_friction()
	calculate_steering(delta)
	velocity += acceleration * delta
	velocity = move_and_slide(velocity)
	emit_signal("update_position")

# Method override in lower boat classes
func get_input():
	pass

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

func take_damage(dmg, p_owner):
	hp -= dmg
	emit_signal("health_changed", hp, p_owner)

