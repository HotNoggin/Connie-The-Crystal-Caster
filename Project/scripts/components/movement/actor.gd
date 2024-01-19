class_name Actor
extends CharacterBody2D
## An actor that can be moved by various controllers (player, enemy) and gravity

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")


## Changes the velocity of the actor according to gravity
func apply_gravity(acceleration: float = gravity):
	velocity.y += acceleration
