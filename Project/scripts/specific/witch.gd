extends Enemy

@export var wand: BulletSpawner
@export var marker: Marker2D
@export var movement_speed: float = 80
@export var teleport_range: float = 384

var timer: Timer = Timer.new()

var target_position:
	get:
		return GameInfo.player.position
var movement_direction:
	get:
		return position.direction_to(target_position)


func _ready():
	add_child(timer)
	timer.timeout.connect(_cast)
	timer.start(2)
	play_safe("idle")


func _physics_process(delta):
	if (not health.alive) or disabled:
		die()
		velocity.x = 0
		apply_gravity(delta)
		move_and_slide()
		return
	
	if position.distance_to(target_position) > 200:
		graphic.flip_h = true if movement_direction.x > 0 else false
		velocity = movement_direction * movement_speed
	else:
		teleport()
	
	if not animator.is_playing():
		play_safe("fly")
	
	move_and_slide()


func _cast():
	play_safe("cast")


func teleport():
	var player_x = GameInfo.player.position.x
	var i = 0
	while true:
		i += 1
		position.x = randf_range(-teleport_range, teleport_range)
		if abs(player_x - position.x) > 400:
			break
		if i > 100:
			print("Tried looping over 100 times")
			break
