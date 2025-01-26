extends Control


func _ready() -> void:
	GameEvents.show_main_menu.connect(show_main_menu)


func _on_quit_texture_button_pressed() -> void:
	get_tree().quit()


func show_main_menu() -> void:
	visible = true


func _on_settings_button_pressed() -> void:
	GameEvents.show_settings_menu.emit()
	visible = false


func _on_level_select_button_pressed() -> void:
	GameEvents.show_level_menu.emit()
	visible = false
