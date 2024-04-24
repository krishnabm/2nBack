extends Node2D

# Nodes
@onready var play_slot_grid: GridContainer = %PlaySlotGrid
@onready var timer = $Timer

# Members
var curTapePointer: int = 0
var tape: Array[int]
var tape_key: Array[bool]
var play_slots: Array[PlaySlot]

func _ready():
	tape_key = TapeGenerator.gen_key(GameParams.testLength,GameParams.get_test_positive_count())
	tape = TapeGenerator.get_tape_from_key(tape_key)
	generate_play_slots()

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


func _on_timer_timeout():
	if curTapePointer >= tape.size():
		timer.stop()
		return
	
	var slot_id: int = tape[curTapePointer]
	
	var play_slot:PlaySlot = play_slots.filter(func(slot): return slot.slot_id == slot_id)[0]
	play_slot.do_activate()
	curTapePointer += 1
	
