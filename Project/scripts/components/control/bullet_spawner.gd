class_name BulletSpawner
extends Component

@export var marker: Marker2D
@export var bullet: PackedScene


## Instantiate the bullet at the marker position, given a direction, speed, and lifetime.
func spawn_bullet(direction: Vector2,
	spawn_position: Vector2 = marker.global_position,
	speed: float = -1,
	lifetime: float = -1):
	
	var this_bullet: Projectile = bullet.instantiate() as Projectile
	add_child(this_bullet)
	
	# Give the bullet the new direction, speed, lifetime, and position
	this_bullet.lifetime = lifetime if lifetime >= 0 else this_bullet.lifetime
	this_bullet.movement_speed = speed if speed >= 0 else this_bullet.movement_speed
	this_bullet.movement_direction = direction.normalized()
	this_bullet.global_position = spawn_position
