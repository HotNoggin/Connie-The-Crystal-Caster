extends Enemy

@export var wand: BulletSpawner
@export var marker: Marker2D
@export var teleport_range: float = 384
@export var movement_speed = 100

@onready var timer: Timer = Timer.new()


func _ready():
	add_child(timer)
	timer.timeout.connect(_cast)
	timer.start(2)
	play_safe("idle")


func _physics_process(delta):
	if (not health.alive) or disabled:
		die()
		return
	
	var movement_direction: Vector2 = Vector2.ZERO
	var target_x = GameInfo.player.position.x
	
	if animator.current_animation == "idle":
		movement_direction = Vector2.RIGHT if target_x > position.x else Vector2.LEFT
	else:
		movement_direction = Vector2.ZERO
	
	if movement_direction.x < 0:
		graphic.flip_h = false
	if movement_direction.x > 0:
		graphic.flip_h = true
	
	if abs(target_x - position.x) > 50:
		velocity.x = movement_direction.x * movement_speed
	
	apply_gravity(delta)
	move_and_slide()


func _cast():
	play_safe("cast")


func shoot():
	var spawn_position = -marker.global_position if graphic.flip_h else marker.global_position
	var spawn_direction = Vector2.RIGHT if graphic.flip_h else Vector2.LEFT
	wand.spawn_bullet(spawn_direction, spawn_position)


func teleport():
	var player_x = GameInfo.player.position.x
	var i = 0
	while true:
		i += 1
		position.x = randf_range(-teleport_range, teleport_range)
		if abs(player_x - position.x) > 50:
			break
		if i > 100:
			print("Tried looping over 100 times")
			break
	
	graphic.flip_h = true if GameInfo.player.position.x > position.x else false
	timer.start()


func idle():
	play_safe("idle")
