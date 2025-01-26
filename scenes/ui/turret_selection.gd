extends Control

@onready var container : VBoxContainer = $VBoxContainer
@export_range(0, 10, 1.0) var initial_turret: int = 0
@onready var selected_turret : int = initial_turret;

func _ready() -> void:
	update_selected_turret()

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("turret_selection_down")):
		selected_turret += 1
		if (selected_turret + 1 > container.get_child_count()):
			selected_turret = 0
		update_selected_turret()
			
	if (event.is_action_pressed("turret_selection_up")):
		selected_turret -= 1
		if (selected_turret < 0):
			selected_turret = container.get_child_count() - 1
		update_selected_turret()
		

func update_selected_turret() -> void:
	GameEvents.select_turret.emit(selected_turret)
	var i = 0;
	for turret_option in container.get_children():
		turret_option.selected = i == selected_turret
		i += 1
