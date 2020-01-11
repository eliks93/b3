extends "res://NPCBoat.gd"
var projectile = preload('res://MachineGunProjectile.tscn')
var projectile_secondary = preload('res://Projectiles/Torpedo.tscn')
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	hp = 50
	npc_max_health = 50

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
