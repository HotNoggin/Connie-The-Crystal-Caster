class_name BulletSpawner
extends Component

@export var marker: Marker2D
@export var bullet: PackedScene


## Instantiate the bullet at the marker position, given a direction, speed, and lifetime.
func spawn_bullet(direction: Vector2,
	spawn_position = marker.global_position,
	speed: float = 10,
	lifetime: float = 15):
	
	var this_bullet: Collectable = bullet.instantiate() as Collectable
	add_child(this_bullet)
	var movement_vector = direction.normalized() * speed
	print(movement_vector)
	# change bullet movement vector
