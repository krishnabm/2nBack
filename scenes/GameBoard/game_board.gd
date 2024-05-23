extends Node2D

# Nodes
@onready var play_slot_grid: GridContainer = %PlaySlotGrid
@onready var timer = %Timer
@onready var score_bar = %ScoreBar
@onready var slot_grid: SlotGrid = %SlotGrid
@onready var tappers: Tappers = %Tappers
@onready var alert_dialog = %AlertDialog

# Members
var cur_tape_pointer: int

var primary_pressed_since_last_frame: bool
var primary_tape: Array[int]
var primary_tape_key: Array[bool]

var secondary_pressed_since_last_frame: bool
var secondary_tape: Array[int]
var secondary_tape_key: Array[bool]
var voice_id: String

func _ready():
	primary_pressed_since_last_frame = false
	secondary_pressed_since_last_frame = false
	cur_tape_pointer = 0
	
	GameState.early_exit = false

	primary_tape_key = TapeGenerator.gen_key(GameParams.testLength,GameParams.get_test_positive_count())
	primary_tape = TapeGenerator.get_tape_from_key(primary_tape_key)

	if GameParams.dualMode == true:
		tappers.do_set_dual_mode(true)
		secondary_tape_key = TapeGenerator.gen_key(GameParams.testLength,GameParams.get_test_positive_count())
		secondary_tape = TapeGenerator.get_tape_from_key(secondary_tape_key)

		var voices = DisplayServer.tts_get_voices_for_language("en")
		
		match OS.get_name():
			"Windows", "UWP":
				voice_id = voices[1]
			_:
				voice_id = voices[0]
	
	%NLabel.text = %NLabel.text.get_slice(":",0) + ": " + str(GameParams.nValue)

func _process(_delta):
	if (score_bar.visible):
		update_labels()

func check_on_press(tapperName: String):
	# cur_tape_pointer is 1 ahead of the tape index we are interested in
	var testing_ptr = cur_tape_pointer - 1

	if tapperName == "primary":
		if testing_ptr >= primary_tape.size() or primary_pressed_since_last_frame == true:
			return
		
		primary_pressed_since_last_frame = true
		
		var key_idx = testing_ptr - GameParams.nValue
		
		if key_idx > -1 and primary_tape_key[key_idx] == true:
			GameState.truePositiveCount[0] += 1
		else :
			GameState.falsePositiveCount[0] += 1
	elif tapperName == "secondary":
		if testing_ptr >= secondary_tape.size() or secondary_pressed_since_last_frame == true:
			return
		
		secondary_pressed_since_last_frame = true
		
		var key_idx = testing_ptr - GameParams.nValue
		
		if key_idx > -1 and secondary_tape_key[key_idx] == true:
			GameState.truePositiveCount[1] += 1
		else :
			GameState.falsePositiveCount[1] += 1

func update_labels():
	%Round.text = %Round.text.get_slice(":",0) + ": " + str(cur_tape_pointer)
	%TPLabel.text = %TPLabel.text.get_slice(":",0) + ": " + str(GameState.truePositiveCount[0] + GameState.truePositiveCount[1])
	%FPLabel.text = %FPLabel.text.get_slice(":",0) + ": " + str(GameState.falsePositiveCount[0] + GameState.falsePositiveCount[1])
	%FNLabel.text = %FNLabel.text.get_slice(":",0) + ": " + str(GameState.falseNegativeCount[0] + GameState.falseNegativeCount[1])

func activate_test_inputs():
	var slot_id: int = primary_tape[cur_tape_pointer]
	slot_grid.do_activate_slot(slot_id)

	if GameParams.dualMode == true:
		var secondary_id: int = secondary_tape[cur_tape_pointer]
		var letter = TapeGenerator.idx_to_alphabet(secondary_id)
		
		# Fine-tweaking speed for certain letters.
		match letter:
			"a":
				DisplayServer.tts_speak(letter, voice_id, 100, 0.8, 0.4, 0, true)
			_:
				DisplayServer.tts_speak(letter, voice_id, 100, 0.8, 0.6, 0, true)

# Handlers
func _on_timer_timeout():
	if cur_tape_pointer <= primary_tape.size():
		var prev_key_idx = cur_tape_pointer - GameParams.nValue - 1
		
		if prev_key_idx > -1:
			if primary_pressed_since_last_frame == false and primary_tape_key[prev_key_idx] == true:
				GameState.falseNegativeCount[0] += 1
			
			if GameParams.dualMode == true and secondary_pressed_since_last_frame == false and secondary_tape_key[prev_key_idx] == true:
				GameState.falseNegativeCount[1] += 1
	
	if cur_tape_pointer == primary_tape.size():
		cur_tape_pointer += 1
		return

	if cur_tape_pointer > primary_tape.size():
		timer.stop()
		get_tree().current_scene.call("change_scene", "res://scenes/GameReport/game_report.tscn")
		return
	
	primary_pressed_since_last_frame = false
	secondary_pressed_since_last_frame = false
	
	activate_test_inputs()
	
	cur_tape_pointer += 1

func _on_tappers_on_tapper_pressed(tapperName):
	if GameParams.dualMode == true:
		check_on_press(tapperName)
	else:
		check_on_press("primary")

func _on_exit_button_pressed():
	alert_dialog.visible = true


func _on_exit_no_button_pressed():
	alert_dialog.visible = false

func _on_exit_yes_button_pressed():
	GameState.early_exit = true
	get_tree().current_scene.call("change_scene", "res://scenes/GameReport/game_report.tscn")
