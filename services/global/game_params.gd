# This script is autoloaded from Project Settings > Autoload
#
# Global Class Name : GameParams
# This stores config like properties
extends Node2D

var nValue = 2
var testLength = 10
var dualMode = true

# Number of true positives that must be generated based on test length
func get_test_positive_count():
	if testLength >= 20:
		return 8
	if testLength >= 15:
		return 6
	if testLength >= 12:
		return 5
	if testLength >= 10:
		return 4
	return 4
