extends Node


@onready var chill_music: AudioStreamPlayer = $ChillMusic
@onready var jazz_music: AudioStreamPlayer = $JazzMusic
@onready var techno_music: AudioStreamPlayer = $TechnoMusic
@onready var creepy_music: AudioStreamPlayer = $CreepyMusic


var playlist = []
var current_song = 0


func _ready() -> void:
	playlist = [
		chill_music,
		jazz_music,
		techno_music,
		creepy_music
	]
	playlist[current_song].play()


func next_song():
	playlist[current_song].stop()
	current_song += 1
	if current_song >= playlist.size():
		current_song = 0
	playlist[current_song].play()


func _on_song_finished() -> void:
	next_song()
