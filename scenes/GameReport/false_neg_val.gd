extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	text = str(GameState.falseNegativeCount[0] + GameState.falseNegativeCount[1])
