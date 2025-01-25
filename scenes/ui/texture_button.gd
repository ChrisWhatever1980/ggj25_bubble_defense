extends TextureButton

var prev_self_modulate

@onready var anim = $"../../AnimationPlayer"
@export var bubble_padding: float = 20

func _ready() -> void:
	randomize()
	var labelSize = $"Label".get_size().x
	var parent = get_parent_control()
	parent.set_custom_minimum_size(Vector2(labelSize + bubble_padding, labelSize + bubble_padding))
	
	var offset : float = randf_range(0, anim.current_animation_length)
	anim.advance(offset)

func _on_mouse_entered() -> void:
	prev_self_modulate = self_modulate
	anim.pause()
	prev_self_modulate = self_modulate
	self_modulate = self_modulate.lightened(1)


func _on_mouse_exited() -> void:
	anim.play()
	self_modulate = prev_self_modulate
