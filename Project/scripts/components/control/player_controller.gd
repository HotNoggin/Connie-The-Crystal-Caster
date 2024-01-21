class_name PlayerController
extends Component

@export var jump_buffer_time: float = 0.25 ## Run time of buffer in seconds
var buffer_time_remaining: float = 0
var just_shot: bool:
	get:
		return Input.is_action_just_pressed("shoot")
var jump_buffered: bool:
	get:
		return buffer_time_remaining > 0
var jumping: bool:
	get:
		return Input.is_action_pressed("jump")


func _process(_delta):
	# Decrease the time remaining in the jump buffer
	if jump_buffered:
		buffer_time_remaining -= _delta
		buffer_time_remaining = max(buffer_time_remaining, 0)
	# Reset the jump buffer if jump was pressed
	if Input.is_action_just_pressed("jump"):
		buffer_time_remaining = jump_buffer_time


## Returns the current axis of the player movement input with a max length of 1.
func get_run_direction() -> float:
	return clampf(Input.get_axis("left", "right"), -1, 1)


## Returns true if the player has pressed jump and they can jump.
func just_jumped(actor: Actor) -> bool:
	return jump_buffered and actor.is_on_floor()
