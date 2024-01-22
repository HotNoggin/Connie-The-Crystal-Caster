class_name PlayerDetector
extends Area2D

signal detected(player: Player)

func _ready():
	body_entered.connect(_collision)


func _collision(body: Node2D):
	if body is Player:
		detected.emit(body)
