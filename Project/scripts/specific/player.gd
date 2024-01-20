class_name Player
extends Actor
## The player actor

enum State {IDLE, RUN, JUMP, FALL, SHOOT, SHOOT_RUN}

@export var player_controller: PlayerController
@export var graphic: Sprite2D
@export var health_label: Label
@export var death_scene: PackedScene
@export_group("Movement")
@export var movement_speed: float = 300
@export var jump_strength: float = 600

var current_state: State:
	set(value):
		if not current_state == value:
			var old_state = current_state
			current_state = value
			_state_changed(old_state)


func _ready():
	# Display the health when it changes, set it to center
	health.value = 3
	health_label.text = str(health.value)
	health.overmaxed.connect(func():
		die())
	health.drained.connect(func():
		die())
	health.changed.connect(func():
		health_label.text = str(health.value))


func _process(_delta):
	if not health.alive:
		return
	
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


func _physics_process(_delta):
	update_state()
	if health.alive:
		_get_movement()
		apply_gravity()
		if player_controller.just_jumped(self):
			jump()
		move_and_slide()
	else:
		die()


## Sets the player horizontal movement according to the input and speed
func _get_movement(test: bool = false) -> float:
	var added_velocity: float = player_controller.get_run_direction() * movement_speed
	if not test:
		velocity.x = added_velocity
	return added_velocity


## Set the velocity to the jump height
func jump():
	velocity.y = -jump_strength


func call_transition():
	Transition.transition_to_packed(death_scene)


func update_state():
	if velocity.y < 0:
		current_state = State.JUMP
	elif velocity.y > 0:
		current_state = State.FALL
	elif velocity.x:
		current_state = State.RUN
	else:
		current_state = State.IDLE


func _state_changed(_old_state: State):
	pass
