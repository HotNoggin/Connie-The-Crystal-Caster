class_name Player
extends Actor
## The player actor

enum State {IDLE, RUN, JUMP, FALL, SHOOT, SHOOT_RUN, NONE}

@export var player_controller: PlayerController
@export var graphic: Sprite2D
@export var idle_gun: BulletSpawner
@export var run_gun: BulletSpawner
@export var health_displays: Array[Sprite2D] ## NEED AT LEAST 5
@export var death_scene: PackedScene
@export_group("Movement")
@export var movement_speed: float = 300
@export var jump_strength: float = 600

var shoot_timer: Timer = Timer.new()
var invincibility_remaining: float = 0
var invincible:
	get:
		return invincibility_remaining > 0
var current_state: State:
	set(value):
		if not current_state == value:
			var old_state = current_state
			current_state = value
			_state_changed(old_state)


func _ready():
	add_child(shoot_timer)
	shoot_timer.one_shot = true
	shoot_timer.timeout.connect(_done_shooting.bind("shoot_run"))
	
	# Display the health when it changes, set it to center
	health.value = 3
	show_health()
	health.overmaxed.connect(func():
		die()
		active = false)
	health.drained.connect(func():
		die())
	health.changed.connect(func():
		show_health())


func _process(_delta):
	print(current_state)
	print(animator.current_animation)
	print(health.alive)
	print("ARGH")
	
	if not health.alive:
		animator.play("die")
		return
	
	if not active:
		animator.play("die")
		return
	
	invincibility_remaining -= _delta
	invincibility_remaining = max(invincibility_remaining, 0)
	
	update_state()
	
	if player_controller.get_run_direction():
		graphic.flip_h = true if player_controller.get_run_direction() > 0 else false
	
	match current_state:
		State.IDLE:
			animator.play("idle")
		State.FALL:
			animator.play("fall")
		State.JUMP:
			animator.play("jump")
		State.RUN:
			animator.play("run")
		State.SHOOT:
			animator.play("shoot")
		State.SHOOT_RUN:
			animator.play("shoot_run")
		_:
			animator.play("idle")


func _physics_process(delta):
	if not health.alive:
		return
	
	if not active:
		return
	
	_get_movement()
	apply_gravity(delta)
	if player_controller.just_jumped(self):
		jump()
	move_and_slide()


## Sets the player horizontal movement according to the input and speed
func _get_movement(test: bool = false) -> float:
	var added_velocity: float = player_controller.get_run_direction() * movement_speed
	if not test:
		velocity.x = added_velocity
	return added_velocity


## Set the velocity to the jump height
func jump():
	velocity.y = -jump_strength


func shoot(gun: BulletSpawner, direction: Vector2):
	health.value -= 1
	var gun_position: Vector2 = gun.marker.position
	var spawn_position: Vector2 = global_position
	if graphic.flip_h:
		spawn_position += Vector2(-gun_position.x, gun_position.y)
	else:
		spawn_position += Vector2(gun_position.x, gun_position.y)
	gun.spawn_bullet(direction, spawn_position)


func call_transition():
	Transition.transition_to_packed(death_scene)


func update_state() -> void:
	# Don't change states if shooting
	if current_state == State.SHOOT or current_state == State.SHOOT_RUN:
		return
	
	# Choose the correct movement state
	if player_controller.just_shot:
		current_state = State.SHOOT
	elif velocity.y < 0:
		current_state = State.JUMP
	elif velocity.y > 0:
		current_state = State.FALL
	elif velocity.x:
		current_state = State.RUN
	else:
		current_state = State.IDLE


func _state_changed(old_state: State):
	if current_state == State.RUN and old_state == State.SHOOT:
		var time_mark: float = animator.current_animation_position
		animator.play("run")
		animator.seek(time_mark)

	elif current_state == State.SHOOT:
		var shoot_direction: Vector2 = Vector2.ZERO
		shoot_direction.x = 1 if graphic.flip_h else -1
		
		if old_state == State.RUN:
			current_state = State.SHOOT_RUN
			shoot(run_gun, shoot_direction)
		else:
			shoot(idle_gun, shoot_direction)
		
		animator.animation_finished.connect(_done_shooting)

	elif current_state == State.SHOOT_RUN:
		var time_mark: float = animator.current_animation_position
		animator.play("shoot_run")
		animator.seek(time_mark)
		shoot_timer.start(0.2)
		

func _done_shooting(animation_name):
	match animation_name:
		"shoot", "shoot_run":
			current_state = State.NONE
			update_state()
			animator.animation_finished.disconnect(_done_shooting)
			if animation_name == "shoot_run":
				shoot_timer.stop()


func set_invinciblility(time: float = 1):
	invincibility_remaining = time


func show_health():
	if health_displays.size() < health.value:
		printerr("Not enough displays for health.")
		return
	
	for health_icon in health_displays:
		health_icon.hide()
	for index in health.value:
		health_displays[index].show()
