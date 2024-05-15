class_name PlaySlot
extends Control

# Nodes
const self_scene = preload("res://scenes/PlaySlot/play_slot.tscn")
@onready var state_chart: StateChart = %StateChart
@onready var color_rect = %ColorRect
@onready var default_sprite = %DefaultSprite
@onready var audio_sprite = %AudioSprite

# Members
@export var slot_id: int
var dormant_color: Color = Color(1, 1, 1)
var active_color: Color = Color(0.27373531460762, 0.72879731655121, 0.71722286939621)

static func constructor(id: int = 0)-> PlaySlot:
	var obj = self_scene.instantiate()
	obj.slot_id = id
	return obj

func _ready():
	if slot_id == 99:
		color_rect.visible = false
		return
	
	if GameParams.dualMode:
		audio_sprite.visible = true
	else:
		default_sprite.visible = true

# Commands
func do_activate():
	state_chart.send_event("SlotActivated")


# Handlers
func _on_active_state_entered():
	color_rect.visible = true
	# color_rect.color = active_color


func _on_active_state_exited():
	color_rect.visible = false
	# color_rect.color = dormant_color
