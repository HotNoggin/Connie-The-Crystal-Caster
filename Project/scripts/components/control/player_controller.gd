class_name PlayerController
extends Component


## Returns the current axis of the player movement input with a max length of 1.
func get_run_direction() -> float:
	return clampf(Input.get_axis("left", "right"), -1, 1)


## Returns true if the player has pressed jump and they can jump.
func just_jumped(actor: Actor) -> bool:
	return Input.is_action_just_pressed("jump") and actor.is_on_floor()
