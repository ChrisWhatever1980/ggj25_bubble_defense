extends GridContainer

@onready var points_label : Label = $LabelPoints
var points : int = 0

func _ready() -> void:
	update_points_label()
	GameEvents.fish_collected.connect(increment_points)

func update_points_label() -> void:
	if points == 1:
		points_label.text = tr("%d POINT") % points
	else:
		points_label.text = tr("%d POINTS") % points

func increment_points() -> void:
	points += 1
	update_points_label()
