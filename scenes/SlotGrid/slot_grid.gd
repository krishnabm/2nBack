class_name SlotGrid
extends Node2D

@onready var play_slot_grid = %PlaySlotGrid

var play_slots: Array[PlaySlot]

func _ready():
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

# Methods
func get_Slot_By_Id(slot_id: int): 
	return play_slots.filter(func(slot): return slot.slot_id == slot_id)[0]

func do_activate_slot(slot_id: int):
	var play_slot:PlaySlot = self.get_Slot_By_Id(slot_id)
	play_slot.do_activate()
