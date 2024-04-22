extends Node2D

func _ready():
	var tape = TapeGenerator.gen_key(10,5)
	for n in range(0,8):
		var nextChild: PlaySlot = PlaySlot.constructor(n)
		nextChild.name = "PlaySlot" + str(n)
		nextChild.global_position = PlacementHelper.place_game_slot(n)
		add_child(nextChild)
