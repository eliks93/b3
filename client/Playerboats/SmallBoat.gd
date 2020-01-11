extends "res://RealPlayer.gd"

var projectile = preload('res://MachineGunProjectile.tscn')
var projectile_secondary = preload('res://Projectiles/Torpedo.tscn')

func _ready():
	hp = 50
	player_max_health = 50