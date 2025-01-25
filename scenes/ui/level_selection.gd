extends Control

func _ready() -> void:
	var i = 0
	for level_option in $MarginContainer/CenterContainer/GridContainer.get_children():
		var btn = level_option.get_node_or_null("Panel/TextureButton")
		
		if (is_instance_valid(btn)):
			btn.connect("pressed", on_level_btn_pressed.bind(i));
		else:
			print('Error with level selection btn structure')
		i += 1


func _on_back_button_pressed() -> void:
	visible = false
	GameEvents.show_main_menu.emit()


func on_level_btn_pressed(level_id: int) -> void:
	GameEvents.select_level.emit(level_id)
	visible = false
	
