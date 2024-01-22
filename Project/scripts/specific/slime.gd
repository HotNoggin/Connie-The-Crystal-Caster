extends Enemy

@export var movement_speed: float = 200
@export var raycast_left: RayCast2D
@export var raycast_right: RayCast2D
var movement_direction: Vector2 = Vector2.ZERO


func _ready():
	movement_direction = Vector2.LEFT if position.x > 0 else Vector2.RIGHT


func _physics_process(delta):
	if (not health.alive) or disabled:
		die()
		return
	
	# Directional switching
	if raycast_left.is_colliding():
		movement_direction = Vector2.RIGHT
	if raycast_right.is_colliding():
		movement_direction = Vector2.LEFT
	
	velocity.x = movement_direction.x * movement_speed
	graphic.flip_h = true if movement_direction.x > 0 else false
	
	apply_gravity(delta)
	move_and_slide()

