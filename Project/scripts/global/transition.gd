extends CanvasLayer
## The Transition singleton script

@export var animator: AnimationPlayer
@export var test_scene: PackedScene


func transition_to_packed(scene: PackedScene):
	get_tree().paused = true
	_play_safe("transition_in")
	animator.animation_finished.connect(func(animation_name):
		if animation_name == "transition_in":
			_transition_out(scene))


func _play_safe(animation: StringName):
	if animator:
		if animator.has_animation(animation):
			animator.play(animation)
		else:
			print("Animation player doesn't have " + animation + " animation.")


func _transition_out(scene: PackedScene):
	get_tree().change_scene_to_packed(scene)
	_play_safe("transition_out")
	animator.animation_finished.connect(func(_animation_name):
		get_tree().paused = false)
