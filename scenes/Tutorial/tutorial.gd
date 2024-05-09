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

func _on_third_impulse_state_entered():
	slot_grid.do_activate_slot(5)

func _on_fourth_text_state_entered():
	tutorial_text.messages = ["That one matched! Hit the tapper!"]
	tutorial_text.start_dialog()

func _on_tappers_on_tapper_pressed(tapperName):
	tutorial_state.send_event("Tapped")


func _on_ending_state_entered():
	tutorial_text.messages = ["Good Job!", "When N is at higher numbers, track repetitions N turns ago", "For e.g. at N = 2, tap when the displayed slot coincides with the one 2 turns ago"]
	tutorial_text.start_dialog()


func _on_exit_button_pressed():
	get_tree().change_scene_to_file("res://scenes/MainMenu/main_menu.tscn")
