extends Node2D

# Signals
signal on_tapper_pressed(tapperName: String)
# Called when the node enters the scene tree for the first time.

func _on_left_tapper_pressed():
	on_tapper_pressed.emit("left")


func _on_right_tapper_pressed():
	on_tapper_pressed.emit("right")
