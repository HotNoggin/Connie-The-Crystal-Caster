class_name Projectile
extends Collectable

@export var movement_speed: float = 500
@export var lifetime: float = 15
var movement_direction: Vector2 = Vector2.ZERO
@export var friendly: bool = false

var time_remaining: float = lifetime

func _ready():
	area_entered.connect(_collided)


func _process(delta):
	time_remaining -= delta
	if time_remaining <= 0:
		queue_free()


func _physics_process(delta):
	position += movement_direction * movement_speed * delta
	rotation = movement_direction.angle()


func _collided(node: Node2D):
	if super(node) == false:
		queue_free()


func _collected(player: Player):
	if not friendly:
		if not player.invincible:
			player.health.decrease()
			player.set_invinciblility()


func _enemy_collided(enemy: Enemy):
	if friendly:
		enemy.hurt()
		queue_free()
