extends Node

signal enemy_destroyed
signal level_completed
signal wave_info_update
signal wave_defeated
signal fish_collected
signal select_level(level_id: int)
signal select_turret(turret_id: int)

## UI exclusive
signal language_changed
signal show_main_menu
signal show_settings_menu
signal show_level_menu
signal show_game_ui
