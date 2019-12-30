extends Node2D

signal spawn_projectile(projectile)

var baseBullet = preload("res://Projectile.tscn")
var projectile = baseBullet
# Called when the node enters the scene tree for the first time.

func _ready():
	get_node("..").connect("fire_turret", self, "_fire")

func _process(delta):
	look_at(get_global_mouse_position())
	rotation_degrees -= 90

func _fire(group):
	var proj = baseBullet
	var direction = Vector2(1, 0).rotated(self.global_rotation + deg2rad(90))
	emit_signal("spawn_projectile", proj, $Muzzle.global_position, direction)