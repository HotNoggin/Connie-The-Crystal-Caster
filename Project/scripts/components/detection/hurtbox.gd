class_name HurtBox
extends Area2D

signal hurt_enemy(enemy: Enemy)
signal hurt_player(player: Player)

@export var hurts_enemies: bool = false
@export var hurts_player: bool = false


func _process(_delta):
	var bodies: Array[Node2D] = get_overlapping_bodies()
	for body in bodies:
		if body is Actor:
			_hurt_actor(body)


func _hurt_actor(actor: Actor):
	if actor is Player and self.hurts_player:
		actor.hurt()
		hurt_player.emit(actor)
	if actor is Enemy and self.hurts_enemies:
		if actor.ignore:
			return
		hurt_enemy.emit(actor)
		actor.hurt()

