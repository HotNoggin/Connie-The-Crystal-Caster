class_name Enemy
extends Actor

@export var hurtbox: HurtBox
@export var graphic: Sprite2D

var ignore: bool = false
var disabled: bool = false
var invincibility_timer: Timer
var invincible: bool = false


func disable():
	hurtbox.hurts_player = false
	hurtbox.hurts_enemies = false
	ignore = true
	disabled = true


func play_safe(animation: StringName):
	if not animator.has_animation(animation):
		printerr("Enemy animator is missing animation '" + animation + "'. Aborted.")
		return
	
	animator.play(animation)


func hurt():
	if (not disabled) and (health.alive) and (not invincible):
		health.decrease()
		play_safe("hurt")
		invincible = true
		invincibility_timer = Timer.new()
		add_child(invincibility_timer)
		invincibility_timer.one_shot = true
		invincibility_timer.start(0.2)
		invincibility_timer.timeout.connect(func():
			invincible = false)
		_was_hurt()


func _was_hurt():
	pass
