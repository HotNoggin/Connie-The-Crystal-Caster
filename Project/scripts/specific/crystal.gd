extends Collectable
## Increases the player's weight when collected


func _collected(player: Player):
	player.health.increase()
	main_parent.queue_free()
