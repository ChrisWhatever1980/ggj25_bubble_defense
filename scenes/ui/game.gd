extends Control

@onready var animation_player: AnimationPlayer = $MarginContainer/AnimationPlayer
@onready var message_label: Label = $MarginContainer/Message/MessageText
@onready var message: CenterContainer = $MarginContainer/Message

func _ready() -> void:
	GameEvents.show_game_ui.connect(show_game_ui)
	GameEvents.show_message.connect(on_show_message)
	


func show_game_ui() -> void:
	visible = true


func on_show_message(txt, duration):
	message_label.text = txt
	animation_player.play("show_message_anim")
	await get_tree().create_timer(duration).timeout
	animation_player.play_backwards("show_message_anim")
