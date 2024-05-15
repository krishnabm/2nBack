extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	if GameParams.dualMode == true:
		text = "Slot False Positives"
	else: 
		text = "False Positives"
