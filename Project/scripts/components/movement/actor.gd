class_name Actor
extends CharacterBody2D
## An actor that can be moved by various controllers (player, enemy) and gravity

@export var player_controller: PlayerController
@export_category("Movement")
@export var movement_speed: float = 100
@export var jump_strength: float = 200
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(_delta):
	_get_movement()
	apply_gravity()
	if player_controller.just_jumped(self):
		jump()
	move_and_slide()


## Sets the player horizontal movement according to the ipnut and speed
func _get_movement():
	velocity.x = player_controller.get_run_direction() * movement_speed


## Changes the velocity of the actor according to gravity
func apply_gravity(acceleration: float = gravity):
	velocity.y += acceleration


## Set the velocity to the jump height
func jump():
	velocity.y = -jump_strength
