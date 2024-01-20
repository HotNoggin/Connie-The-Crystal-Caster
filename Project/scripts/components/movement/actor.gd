class_name Actor
extends CharacterBody2D
## An actor that can be moved by various controllers (player, enemy) and gravity

@export var fall_speed_scale: float = 1 ## How much gravity should multiply when falling
@export var health: Health
@export var animator: AnimationPlayer
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")


## Changes the velocity of the actor according to gravity
func apply_gravity(acceleration: float = gravity):
	# fall quicker when already going down
	if velocity.y > 0:
		velocity.y += acceleration * fall_speed_scale
	else:
		velocity.y += acceleration


func die():
	if animator.has_animation("die"):
		animator.play("die")
	else:
		printerr("Actor animator lacks a 'die' animation and was freed.")
		queue_free()
