extends Node3D

@onready var bubble: MeshInstance3D = $Bubble
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var bubble_pop_sound: AudioStreamPlayer3D = $BubblePopSound


var lifetime : float = 5.0
var speed : float = 0.5


func _ready() -> void:
	lifetime = randf_range(3.0, 3.0)
	speed = randf_range(0.15, 0.3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += delta * speed

	lifetime -= delta
	if lifetime <= 0.0:
		pop()


func pop() -> void:
	animation_player.play("pop_animation")
