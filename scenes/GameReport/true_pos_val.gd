extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	text = str(GameState.truePositiveCount[0] + GameState.truePositiveCount[1])
