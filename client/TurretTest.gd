extends Node2D

signal fire_turret(group)

var turret = preload("res://Turret.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var thisTurret = turret.instance()
	thisTurret.position = Vector2(150, 150)
	self.add_child(thisTurret)
	
	$Turret.connect("spawn_projectile", self, "_spawn_projectile")

func _spawn_projectile(projectile, _position, _direction):
	var proj = projectile.instance()
	add_child(proj)
	proj.start(_position, _direction)

func _process(delta):
	if (Input.is_action_pressed("fire_1")):
		emit_signal("fire_turret", 1)