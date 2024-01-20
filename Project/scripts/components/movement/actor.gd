class_name Actor
extends CharacterBody2D
## An actor that can be moved by various controllers (player, enemy) and gravity

@export var fall_speed_scale: float = 1 ## How much gravity should multiply when falling
@export var health: Health
@export var animator: AnimationPlayer
var active: bool = true
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")


## Changes the velocity of the actor according to gravity
func apply_gravity(delta: float, acceleration: float = gravity):
	# fall quicker when already going down
	if velocity.y > 0:
		velocity.y += acceleration * fall_speed_scale * delta
	else:
		velocity.y += acceleration * delta


func die():
	if animator.has_animation("die"):
		animator.play("die")
	else:
		printerr("Actor animator lacks a 'die' animation and was freed.")
		queue_free()
