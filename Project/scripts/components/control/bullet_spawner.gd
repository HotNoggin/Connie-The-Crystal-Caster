class_name BulletSpawner
extends Node2D

@export var marker: Marker2D
@export var bullet: PackedScene
@export var main_parent: Node2D = self ## A parent to instantiate bullets as a sibling as


## Instantiate the bullet at the marker position, given a direction, speed, and lifetime.
func spawn_bullet(direction: Vector2,
	spawn_position: Vector2 = marker.global_position,
	speed: float = -1,
	lifetime: float = -1):
	
	var this_bullet: Projectile = bullet.instantiate() as Projectile
	main_parent.add_sibling(this_bullet)
	
	# Give the bullet the new direction, speed, lifetime, and position
	this_bullet.lifetime = lifetime if lifetime >= 0 else this_bullet.lifetime
	this_bullet.movement_speed = speed if speed >= 0 else this_bullet.movement_speed
	this_bullet.movement_direction = direction.normalized()
	this_bullet.global_position = spawn_position
