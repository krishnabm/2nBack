extends Node2D

@onready var tutorial_text: DialogOrchestrator = %TutorialText
@onready var slot_grid = %SlotGrid
@onready var tutorial_state = %TutorialState

func _ready():
	tutorial_text.start_dialog()

func _on_tutorial_text_on_dialog_seq_ended():
	tutorial_state.send_event("Next")

func _on_first_impulse_state_entered():
	slot_grid.do_activate_slot(2)

func _on_second_text_state_entered():
	tutorial_text.messages = ["The top right one lit up", "Let's see what comes next"]
	tutorial_text.start_dialog()

func _on_second_impulse_state_entered():
	slot_grid.do_activate_slot(5)

func _on_third_text_state_entered():
	tutorial_text.messages = ["Hmm, this wasn't the same one as before", "Let's keep observing"]
	tutorial_text.start_dialog()
