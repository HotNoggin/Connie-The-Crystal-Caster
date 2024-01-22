class_name Spawner
extends Node

@export var spawn_minimum: Marker2D
@export var spawn_maximum: Marker2D
@export var scene: PackedScene
@export_category("Timer")
@export var spawn_on_start: bool = false
@export var spawn_time: float = 5
@export var initial_time: float = spawn_time
@export var randomization: float = 0

var timer: Timer = Timer.new()
var minimum: Vector2
var maximum: Vector2


func _ready():
	minimum = spawn_minimum.position
	maximum = spawn_maximum.position
	
	add_child(timer)
	timer.one_shot = true
	timer.timeout.connect(_timer_timeout)
	reset_timer(initial_time)

	
	if spawn_on_start:
		spawn_instance()


func _timer_timeout():
	spawn_instance()
	reset_timer()


func spawn_instance():
	var instance = scene.instantiate() as Node2D
	add_sibling.call_deferred(instance)
	if instance is Node2D:
		instance.position.x = randf_range(minimum.x, maximum.x)
		instance.position.y = randf_range(minimum.y, maximum.y)
	else:
		printerr("The root node of the scene is not a Node2D. Instantiation aborted.")
		instance.queue_free()
		timer.paused = true


func reset_timer(time: float = spawn_time):
	timer.start(time + randf_range(-randomization, randomization))
