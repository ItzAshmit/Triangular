extends AudioStreamPlayer2D

@onready var music: AudioStreamPlayer2D = $"."


func _ready() -> void:
	music.stream.loop = true
	if not music.playing:
		music.play()
