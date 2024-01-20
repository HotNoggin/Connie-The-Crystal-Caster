class_name Collectable
extends Area2D

var collected_already: bool = false


func _init():
	body_entered.connect(_collided)


func _collided(body: Node2D):
	if body is Player:
		_collected(body)
		collected_already = true


func _collected(_player: Player):
	pass
