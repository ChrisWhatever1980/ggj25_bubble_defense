extends Node3D


@onready var coffee_table: Node3D = $coffee_table
@onready var candles_node: Node3D = $coffee_table/Candles


var candles_lit = true
var candles = []
var candle_brightness = 0.1



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for c in candles_node.get_children():
		if c is OmniLight3D:
			#print("Candle " + c.name)
			candles.append(c)
			c.light_energy = candle_brightness * randf_range(0.2, 1.0)
			var candle_timer = Timer.new()
			candle_timer.wait_time = 0.1
			candle_timer.autostart = true
			candle_timer.one_shot = false
			add_child(candle_timer)
			candle_timer.timeout.connect(on_candle_timeout.bind(c, candle_timer))


func on_candle_timeout(candle : OmniLight3D, candle_timer):
	candle.light_energy = candle_brightness * randf_range(0.2, 1.0)


func toggle_candles():
	candles_lit = !candles_lit
	for c in candles:
		c.visible = candles_lit
		await get_tree().create_timer(1.0).timeout
