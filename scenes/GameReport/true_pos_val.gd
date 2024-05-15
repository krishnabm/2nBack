extends Label

func _ready():
	text = str(GameState.truePositiveCount[0] + GameState.truePositiveCount[1])
