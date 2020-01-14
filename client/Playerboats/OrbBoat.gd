extends "res://RealPlayer.gd"

var projectile = preload("res://Projectiles/RCFloatProjectile.tscn")
var projectile_secondary = preload("res://Projectiles/Ghost.tscn")
# Temporary error fix
func _spawn_projectile(arg1, arg2, arg3):
	pass