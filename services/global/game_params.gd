# This script is autoloaded from Project Settings > Autoload
#
# Global Class Name : GameParams
# This stores config like properties
extends Node2D

var nValue = 1
var testLength = 10

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
