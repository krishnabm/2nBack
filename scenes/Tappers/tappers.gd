class_name Tappers
extends Node2D

# Inputs
@export var isDualMode: bool = false

@onready var sec_tapper = %SecTapper

# Signals
signal on_tapper_pressed(tapperName: String)

func _ready():
	sec_tapper.visible = isDualMode

func _on_left_tapper_pressed():
	on_tapper_pressed.emit("secondary")

func _on_right_tapper_pressed():
	on_tapper_pressed.emit("primary")

# Commands
func do_set_dual_mode(isDual: bool):
	sec_tapper.visible = isDual
	isDualMode = isDual
