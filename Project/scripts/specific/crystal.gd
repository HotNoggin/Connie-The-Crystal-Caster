extends Collectable
## Increases the player's weight when collected


func _collected(player: Player):
	player.health.decrease()
	queue_free()
