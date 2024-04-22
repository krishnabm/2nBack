class_name PlacementHelper
extends Object

static func place_game_slot(slot_id: int) -> Vector2:
	var pos: Vector2
	
	match slot_id:
		0:
			pos = Vector2(slot_id*100 + 250, slot_id*100 + 250)
		1:
			pos = Vector2(slot_id*100 + 250, slot_id*100 + 250)
		2:
			pos = Vector2(slot_id*100 + 250, slot_id*100 + 250)
		3:
			pos = Vector2(slot_id*100 + 250, slot_id*100 + 250)
		3:
			pos = Vector2(slot_id*100 + 250, slot_id*100 + 250)
		4:
			pos = Vector2(slot_id*100 + 250, slot_id*100 + 250)
		5:
			pos = Vector2(slot_id*100 + 250, slot_id*100 + 250)
		6:
			pos = Vector2(slot_id*100 + 250, slot_id*100 + 250)
		7:
			pos = Vector2(slot_id*100 + 250, slot_id*100 + 250)

	return pos
