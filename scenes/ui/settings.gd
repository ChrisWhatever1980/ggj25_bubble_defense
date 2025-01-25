extends Control

@onready var window_mode_control : OptionButton = $CenterContainer/MarginContainer/HSplitContainer/MarginContainer/Optionsleft/GridContainer/OptionButtonWindowMode
@onready var resolution_control: OptionButton = $CenterContainer/MarginContainer/HSplitContainer/MarginContainer/Optionsleft/GridContainer/OptionButtonResolution
@onready var language_control: OptionButton = $CenterContainer/MarginContainer/HSplitContainer/MarginContainer/Optionsleft/GridContainer/OptionButtonLanguage
var screen_sizes : Array = [
	'2560x1440',
	'1920x1080',
	'1366x768',
	'1280x720'
]
var languages : Dictionary = {
	'en': 'ENGLISH',
	'de': 'GERMAN'
}

func _ready() -> void:
	window_mode_control.select(window_mode_control.get_item_index(DisplayServer.window_get_mode()))
	set_screen_size()
	set_locale()
	

func set_locale() -> void:
	var os_locale = OS.get_locale_language()
	if (languages.has(os_locale)):
		for i in range(0, language_control.item_count):
			if (languages[os_locale] == language_control.get_item_text(i)):
				language_control.select(i)
	else:
		language_control.select(0)
	

func set_screen_size() -> void:
	var current_screen_size = DisplayServer.screen_get_size()
	var screen_size_string : String = str(current_screen_size.x) + 'x' + str(current_screen_size.y)
	var i : int = 1
	
	for screen_size in screen_sizes:
		resolution_control.add_item(screen_size, i)
		if (screen_size_string == screen_size):
			resolution_control.select(i)
		i += 1
		
	if (resolution_control.get_selected_id() == -1):
		resolution_control.add_item(get_resolution_string_by_vec(current_screen_size), 0)
		resolution_control.select(i)
		

func _on_option_button_window_mode_item_selected(index: int) -> void:
	DisplayServer.window_set_mode(window_mode_control.get_item_id(index))


func _on_option_button_resolution_item_selected(index: int) -> void:
	var resolution_string = resolution_control.get_item_text(index)
	DisplayServer.window_set_size(get_resolution_vec_by_string(resolution_string)) 


func _on_option_button_language_item_selected(index: int) -> void:
		TranslationServer.set_locale(languages.find_key(language_control.get_item_text(index)))
		GameEvents.language_changed.emit()


func get_resolution_vec_by_string(resolution_string: String) -> Vector2i:
	var resolution_array = resolution_string.split('x')
	return Vector2i(int(resolution_array[0]), int(resolution_array[1]))


func get_resolution_string_by_vec(resolution_vec: Vector2i) -> String:
	return str(resolution_vec.x) + 'x' + str(resolution_vec.y)
