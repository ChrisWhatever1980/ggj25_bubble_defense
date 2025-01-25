extends Node3D

@onready var bubble: MeshInstance3D = $Bubble
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var bubble_pop_sound: AudioStreamPlayer3D = $BubblePopSound


var lifetime : float = 5.0
var speed : float = 5.0


func _ready() -> void:
	lifetime = randf_range(2.0, 7.0)
	speed = randf_range(2.0, 5.0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	#position.y += delta * speed
#
	#lifetime -= delta
	#if lifetime <= 0.0:
		#pop()


func pop() -> void:
	animation_player.play("pop_animation")
