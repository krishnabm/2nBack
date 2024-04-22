extends Node2D

func _ready():
	var tape = TapeGenerator.gen_key(10,5)
	for n in range(0,8):
		var nextChild: PlaySlot = PlaySlot.constructor(n)
		nextChild.global_position = (Vector2(n*100 + 250,n*100 + 250))
		add_child(nextChild)
