extends "res://Boat.gd"

signal fire_turret(group)
signal turn_turret(mouse_pos)
onready var bar = $Bar/TextureProgress
onready var tween = $Tween

var mouse_pos = Vector2()

var animated_health = 100
var ripple_opacity = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	for Turret in $Turrets.get_children():
		Turret.connect("spawn_projectile", self, "_spawn_projectile")
	var player_max_health = hp
	bar.max_value = player_max_health
	update_health(player_max_health)

func _process(delta):
	emit_signal("turn_turret", get_global_mouse_position())
	mouse_pos = get_global_mouse_position()
	set_camera_position()
	bar.value = animated_health
	ripple_visibility()

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

func update_health(new_value):
	tween.interpolate_property(self, "animated_health", animated_health, new_value, 0.6, Tween.TRANS_LINEAR, Tween.EASE_IN)
	if not tween.is_active():
		tween.start()

func ripple_visibility():
	var new_opacity = velocity.length() / 100
	
	if new_opacity > 1:
		new_opacity = 1
	
	$Tween.interpolate_property($BoatRipple, "modulate",
		Color(1, 1, 1, ripple_opacity), Color(1, 1, 1, new_opacity), 0.05,
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	
	ripple_opacity = new_opacity

func set_camera_position():
	var offset = get_viewport().get_mouse_position() - self.global_position
	var x_offset = get_viewport().get_mouse_position()[0] - get_viewport_rect().size.x / 2
	var y_offset = get_viewport().get_mouse_position()[1] - get_viewport_rect().size.y / 2
	# The viewport scale is zoomed out by 3.  So we need to multiply the size by 3,
	# THEN perform normal operations
	$Camera2D.global_position[0] = self.global_position[0] - (get_viewport_rect().size.x * 3) / 2 + x_offset
	$Camera2D.global_position[1] = self.global_position[1] - (get_viewport_rect().size.y * 3) / 2 + y_offset

func explode():
	velocity = Vector2()
	$Sprite.hide()
	if has_node('Turrets'):
		$Turrets.queue_free()
	$CollisionShape2D.disabled = true
	$Explosion.show()
	$Explosion.play("fire")
	

func _on_Explosion_animation_finished():
#	get_parent().add_child(death_screen.instance())
	queue_free()
	emit_signal("death_screen")
