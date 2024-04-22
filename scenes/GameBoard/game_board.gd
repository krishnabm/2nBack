extends Node2D

func _ready():
	for n in range(0,7):
		var nextChild: PlaySlot = PlaySlot.constructor(n)
		nextChild.global_position = (Vector2(n*100 + 250,n*100 + 250))
		add_child(nextChild)
