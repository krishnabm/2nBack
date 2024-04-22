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
	
