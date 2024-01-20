class_name Projectile
extends Collectable

@export var movement_speed: float = 500
@export var lifetime: float = 15
var movement_direction: Vector2 = Vector2.ZERO
@export var friendly: bool = false


func _physics_process(delta):
	position += movement_direction * movement_speed * delta


func _collected(player: Player):
	if not friendly:
		if not player.invincible:
			player.health.decrease()
			player.set_invinciblility()


func _enemy_collided(enemy: Enemy):
	if friendly:
		enemy.health.decrease()
		queue_free()
