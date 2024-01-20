class_name Player
extends Actor
## The player actor

@export var player_controller: PlayerController
@export var health_label: Label
@export_group("Movement")
@export var movement_speed: float = 100
@export var jump_strength: float = 200


func _ready():
	# Display the health when it changes, set it to center
	health.value = 3
	health_label.text = str(health.value)
	health.changed.connect(func():
		health_label.text = str(health.value))


func _physics_process(_delta):
	if health.alive:
		_get_movement()
		apply_gravity()
		if player_controller.just_jumped(self):
			jump()
		move_and_slide()
	else:
			die()


## Sets the player horizontal movement according to the ipnut and speed
func _get_movement():
	velocity.x = player_controller.get_run_direction() * movement_speed


## Set the velocity to the jump height
func jump():
	velocity.y = -jump_strength
