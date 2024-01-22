extends Node2D

func start_game():
	Transition.transition_to_packed(GameInfo.arena_scene)
