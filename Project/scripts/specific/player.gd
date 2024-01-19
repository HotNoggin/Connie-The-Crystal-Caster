extends Actor
## The player actor

@export var player_controller: PlayerController
@export_group("Movement")
@export var movement_speed: float = 100
@export var jump_strength: float = 200


func _physics_process(_delta):
	_get_movement()
	apply_gravity()
	if player_controller.just_jumped(self):
		jump()
	move_and_slide()


## Sets the player horizontal movement according to the ipnut and speed
func _get_movement():
	velocity.x = player_controller.get_run_direction() * movement_speed


## Set the velocity to the jump height
func jump():
	velocity.y = -jump_strength
