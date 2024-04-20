class_name PlaySlot
extends Node2D

const self_scene = preload("res://scenes/PlaySlot/play_slot.tscn")

@export var slot_id: int

static func constructor(id: int = 0)-> PlaySlot:
	var obj = self_scene.instantiate()
	
	obj.slot_id = id
	
	return obj
