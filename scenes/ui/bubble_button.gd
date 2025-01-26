class_name BubbleButton
extends Control

@onready var anim = $"AnimationPlayer"
@onready var btn = $"Panel/TextureButton"
@export var bubble_padding: int = 20

func _ready() -> void:
	randomize()
	var contentSize = max(btn.get_child(0).get_size().x, btn.get_child(0).get_size().y)
	var parent = btn.get_parent_control()
	parent.set_custom_minimum_size(Vector2(contentSize + bubble_padding, contentSize + bubble_padding))
	
	var offset : float = randf_range(0, anim.current_animation_length)
	anim.advance(offset)
	btn.mouse_entered.connect(_on_mouse_entered)
	btn.mouse_exited.connect(_on_mouse_exited)
	
func _on_mouse_entered() -> void:
	anim.pause()


func _on_mouse_exited() -> void:
	anim.play()
