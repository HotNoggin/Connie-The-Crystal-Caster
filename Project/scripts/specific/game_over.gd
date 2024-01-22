extends Control

@export var time_label: Label


func _ready():
	time_label.text = "Your time was " + time_convert(GameInfo.time)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("shoot"):
		Transition.transition_to_packed(GameInfo.arena_scene)


func time_convert(time_in_sec: int) -> String:
	var seconds: float = time_in_sec % 60
	var minutes: float = (time_in_sec/ 60) % 60
	var hours: float = (time_in_sec/ 60)/ 60
	
	#returns a string with the format "HH:MM:SS"
	return "%02d:%02d:%02d" % [hours, minutes, seconds]
