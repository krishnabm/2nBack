extends Node2D

# Nodes
@onready var play_slot_grid: GridContainer = %PlaySlotGrid
@onready var timer = %Timer
@onready var score_bar = %ScoreBar

# Members
var cur_tape_pointer: int
var tape: Array[int]
var tape_key: Array[bool]
var play_slots: Array[PlaySlot]
var pressed_since_last_frame: bool

func _ready():
	tape_key = TapeGenerator.gen_key(GameParams.testLength,GameParams.get_test_positive_count())
	tape = TapeGenerator.get_tape_from_key(tape_key)
	cur_tape_pointer = 0
	pressed_since_last_frame = false
	
	%NLabel.text = %NLabel.text.get_slice(":",0) + ": " + str(GameParams.nValue)
	generate_play_slots()

func _process(_delta):
	if (score_bar.visible):
		update_labels()

func generate_play_slots():
	for i in range(0,9):
		var id = i
		if i == 4:
			id = 99
		elif i > 4:
			id = i-1
			
		var nextChild: PlaySlot = PlaySlot.constructor(id)
		
		nextChild.name = "PlaySlot" + str(id)
		nextChild.add_to_group("PlaySlots")
		play_slots.push_back(nextChild)
		play_slot_grid.add_child(nextChild)

func check_on_press():
	# cur_tape_pointer is 1 ahead of the tape index we are interested in
	var testing_ptr = cur_tape_pointer - 1
	if testing_ptr >= tape.size() or pressed_since_last_frame == true:
		return
	
	pressed_since_last_frame = true
	
	var key_idx = testing_ptr - GameParams.nValue
	
	if key_idx > -1 and tape_key[key_idx] == true:
		GameState.truePositiveCount += 1
	else :
		GameState.falsePositiveCount += 1

func update_labels():
	%Round.text = %Round.text.get_slice(":",0) + ": " + str(cur_tape_pointer)
	%TPLabel.text = %TPLabel.text.get_slice(":",0) + ": " + str(GameState.truePositiveCount)
	%FPLabel.text = %FPLabel.text.get_slice(":",0) + ": " + str(GameState.falsePositiveCount)
	%FNLabel.text = %FNLabel.text.get_slice(":",0) + ": " + str(GameState.falseNegativeCount)
# Handlers
func _on_timer_timeout():
	if pressed_since_last_frame == false and cur_tape_pointer <= tape.size():
		var prev_key_idx = cur_tape_pointer - GameParams.nValue - 1
	
		if prev_key_idx > -1 and tape_key[prev_key_idx] == true:
			GameState.falseNegativeCount += 1
	
	if cur_tape_pointer == tape.size():
		cur_tape_pointer += 1
		return

	if cur_tape_pointer > tape.size():
		timer.stop()
		get_tree().change_scene_to_file("res://scenes/GameReport/game_report.tscn")
		return
	
	pressed_since_last_frame = false
	
	var slot_id: int = tape[cur_tape_pointer]
	
	var play_slot:PlaySlot = play_slots.filter(func(slot): return slot.slot_id == slot_id)[0]
	play_slot.do_activate()
	
	cur_tape_pointer += 1
	

func _on_right_tapper_pressed():
	check_on_press()


func _on_left_tapper_pressed():
	check_on_press()
