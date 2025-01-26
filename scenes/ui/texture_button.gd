extends TextureButton

var prev_self_modulate

@onready var anim = $"../../AnimationPlayer"
@export var bubble_padding: float = 20

func _ready() -> void:
	randomize()
	set_bubble_size()
	var offset : float = randf_range(0, anim.current_animation_length)
	anim.advance(offset)
	GameEvents.language_changed.connect(set_bubble_size)


func set_bubble_size() -> void:
	var labelSize = $"Label".get_size().x
	var parent = get_parent_control()
	#if ("text" in $"Label"):
		#print("Updated " + $"Label".text)
		#print("Size " + str(labelSize))
	parent.set_custom_minimum_size(Vector2(labelSize + bubble_padding, labelSize + bubble_padding))


func _on_mouse_entered() -> void:
	prev_self_modulate = self_modulate
	anim.pause()
	prev_self_modulate = self_modulate
	self_modulate = self_modulate.lightened(1)


func _on_mouse_exited() -> void:
	anim.play()
	self_modulate = prev_self_modulate
