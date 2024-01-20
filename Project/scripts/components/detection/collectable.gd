class_name Collectable
extends Area2D

var collected_already: bool = false


func _init():
	body_entered.connect(_collided)


## OVERRIDING THIS FUNCTION WILL CAUSE _collected AND _enemy_collided TO BREAK
func _collided(body: Node2D):
	if body is Player:
		_collected(body)
	if body is Enemy:
		_enemy_collided(body)
	
	collected_already = true


func _collected(_player: Player):
	pass


func _enemy_collided(_enemy: Enemy):
	pass
