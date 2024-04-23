extends Node2D
@onready var play_slot_grid = %PlaySlotGrid

func _ready():
	var tape = TapeGenerator.gen_key(10,4)
	generate_play_slots()

func generate_play_slots():
	for i in range(0,9):
		var id = i
		if i == 4:
			id = 99
		elif i > 4:
			id = i-1
			
		var nextChild: PlaySlot = PlaySlot.constructor(id)
		
		nextChild.name = "PlaySlot" + str(id)
		nextChild.add_to_group("PlaySlots")
		#nextChild.custom_minimum_size = Vector2(200,200)
		play_slot_grid.add_child(nextChild)
