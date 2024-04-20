extends Node2D

const play_slot_scene = preload("res://scenes/PlaySlot/play_slot.tscn")
@onready var play_slot_0 = %PlaySlot0


func _ready():
	if not play_slot_scene.can_instantiate():
		push_error("Couldn't instantiate play slot")

	play_slot_0.constructor()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
