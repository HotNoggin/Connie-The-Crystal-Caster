extends Enemy

@export var movement_speed: float = 120
var target_position:
	get:
		return GameInfo.player.position
var movement_direction:
	get:
		return position.direction_to(target_position)


func _physics_process(delta):
	if (not health.alive) or disabled:
		die()
		velocity.x = 0
		apply_gravity(delta)
		move_and_slide()
		return
	
	if position.distance_to(target_position) > 50:
		graphic.flip_h = true if movement_direction.x > 0 else false
		velocity = movement_direction * movement_speed
	
	if not animator.is_playing():
		play_safe("fly")
	
	move_and_slide()


func bounce():
	velocity.y = -600
