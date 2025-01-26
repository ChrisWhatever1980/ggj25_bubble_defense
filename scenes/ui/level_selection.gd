extends Control


var level_completed = []
var level_buttons = []


func _ready() -> void:
	var i = 0
	for level_option in $MarginContainer/CenterContainer/GridContainer.get_children():
		var btn = level_option.get_node_or_null("Panel/TextureButton")
		
		if (is_instance_valid(btn)):
			btn.connect("pressed", on_level_btn_pressed.bind(i));
		else:
			print('Error with level selection btn structure')
		i += 1

		# init level completed array
		level_buttons.append(btn)
		level_completed.append(false)

	# Read level completed info from storage
	load_level_info()

	GameEvents.show_level_menu.connect(show_level_menu)
	GameEvents.level_completed.connect(save_level_info)


func load_level_info():
	var config = ConfigFile.new()

	# Load data from a file.
	var err = config.load("user://level_completed.cfg")
	var file_loaded = false
	if err == OK:
		file_loaded = true
	else:
		file_loaded = false

	# Iterate over all sections.
	var level_idx = 0
	var highest_level_completed = -1
	for lc in level_completed:
		var this_level_completed = false

		if file_loaded:
			# Fetch the data for each section.
			this_level_completed = config.get_value("Completed", "Level" + str(level_idx))
		level_completed[level_idx] = this_level_completed

		# set button visibility
		level_buttons[level_idx].visible = this_level_completed
		if this_level_completed:
			highest_level_completed = level_idx
		level_idx += 1

	# unlock the next uncompleted level
	if highest_level_completed + 1 < level_completed.size():
		level_buttons[highest_level_completed + 1].visible = true


func save_level_info(completed_level_idx):
	# Create new ConfigFile object.
	var config = ConfigFile.new()

	level_completed[completed_level_idx] = true

	# Store some values.
	var level_idx = 0
	for lc in level_completed:
		config.set_value("Completed", "Level" + str(level_idx), level_completed[level_idx])
		level_idx += 1

	config.save("user://level_completed.cfg")

	#reinit the level selection
	load_level_info()


func show_level_menu() -> void:
	visible = true


func _on_back_button_pressed() -> void:
	visible = false
	GameEvents.show_main_menu.emit()


func on_level_btn_pressed(level_id: int) -> void:
	GameEvents.select_level.emit(level_id)
	visible = false
	
