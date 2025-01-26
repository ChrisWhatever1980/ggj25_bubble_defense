extends Control


func _ready() -> void:
	GameEvents.show_game_ui.connect(show_game_ui)


func show_game_ui() -> void:
	visible = true
