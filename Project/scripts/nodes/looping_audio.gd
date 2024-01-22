class_name MusicLoop
extends AudioStreamPlayer

func _ready():
	autoplay = true
	play()
	finished.connect(func():
		play())
