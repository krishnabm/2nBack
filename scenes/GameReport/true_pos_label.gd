extends Label

func _ready():
	if GameParams.dualMode == true:
		text = "Slot True Positives"
	else: 
		text = "True Positives"
