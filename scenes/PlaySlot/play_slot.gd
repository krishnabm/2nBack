class_name PlaySlot
extends Control

# Nodes
const self_scene = preload("res://scenes/PlaySlot/play_slot.tscn")
@onready var state_chart: StateChart = %StateChart
@onready var color_rect = %ColorRect

# Members
@export var slot_id: int

static func constructor(id: int = 0)-> PlaySlot:
	var obj = self_scene.instantiate()
	obj.slot_id = id
	return obj

func _ready():
	if slot_id == 99:
		color_rect.visible = false

# Commands
func do_activate():
	state_chart.send_event("SlotActivated")


func _on_active_state_entered():
	color_rect.color = Color(0.27373531460762, 0.72879731655121, 0.71722286939621)


func _on_active_state_exited():
	color_rect.color = Color(1, 1, 1)
