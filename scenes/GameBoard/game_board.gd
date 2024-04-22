extends Node2D
@onready var play_slot_grid = %PlaySlotGrid

func _ready():
	var tape = TapeGenerator.gen_key(10,5)
	for n in range(0,8):
		var nextChild: PlaySlot = PlaySlot.constructor(n)
		nextChild.name = "PlaySlot" + str(n)
		nextChild.add_to_group("PlaySlots")
		#nextChild.global_position = PlacementHelper.place_game_slot(n)
		play_slot_grid.add_child(nextChild)
