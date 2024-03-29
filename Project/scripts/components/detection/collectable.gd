class_name Collectable
extends Area2D

@export var main_parent: Node2D = self
var collected_already: bool = false


func _init():
	body_entered.connect(_collided)


## OVERRIDING THIS FUNCTION WILL CAUSE _collected AND _enemy_collided TO BREAK
func _collided(body: Node2D) -> bool:
	if body is Player:
		_collected(body)
		collected_already = true
		return true
	if body is Enemy:
		_enemy_collided(body)
		collected_already = true
		return true
	return false


func _collected(_player: Player):
	pass


func _enemy_collided(_enemy: Enemy):
	pass
