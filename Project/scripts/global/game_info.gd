extends Node

@onready var arena_scene: PackedScene = preload("res://scenes/world/levels/arena.tscn")
@onready var comic_scene: PackedScene = preload("res://scenes/ui/comic.tscn")

var time: float = 0
var player: Player
