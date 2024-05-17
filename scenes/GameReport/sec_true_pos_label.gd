extends Label

func _ready():
	if GameParams.dualMode == true:
		text = "Audio True Positives"
	else: 
		text = "True Positives"
