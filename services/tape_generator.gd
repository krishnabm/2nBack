class_name TapeGenerator
extends Object

static func gen_key(testLength: int, numMatches: int)-> Array[bool]:
	if (numMatches > testLength):
		push_error("can't do that m8")
		
	var ret: Array[bool] = []
	ret.resize(testLength)
	ret.fill(false)
	
	while(numMatches > 0):
		var idx = randi_range(0, testLength-1)
		if ret[idx]:
			continue
		else:
			ret[idx] = true
		numMatches -= 1
	return ret
	
static func get_tape_from_key(tapeKey: Array[bool]):
	var tape: Array[int] = []
	for fastPtr in range(0,GameParams.testLength + GameParams.nValue):
		var slowPtr = fastPtr - GameParams.nValue
		
		if slowPtr > -1:
			if tapeKey[slowPtr] == true:
				var curSlotIdx = tape[slowPtr]
				tape.push_back(curSlotIdx)
			else:
				var curSlotIdx = randi_range(0, 7)
				if tape[slowPtr] == curSlotIdx:
					curSlotIdx = (curSlotIdx + 1) % 8
				tape.push_back(curSlotIdx)
		else:
			var curSlotIdx = randi_range(0, 7)
			tape.push_back(curSlotIdx)
			
	return tape
