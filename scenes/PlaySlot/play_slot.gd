class_name PlaySlot
extends Control

const self_scene = preload("res://scenes/PlaySlot/play_slot.tscn")
@onready var color_rect = %ColorRect

@export var slot_id: int

func _init(id: int = 0):
	slot_id = id

static func constructor(id: int = 0)-> PlaySlot:
	var obj = self_scene.instantiate()
	obj.slot_id = id
	return obj

func _ready():
	if slot_id == 99:
		color_rect.visible = false
