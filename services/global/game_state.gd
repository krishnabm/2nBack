# This script is autoloaded from Project Settings > Autoload
#
# Global Class Name : GameState
# This stores properties subject to frequent change during the game across multiple scenes
extends Node2D

var truePositiveCount: Array[int]
var falsePositiveCount: Array[int]
var falseNegativeCount: Array[int]

func init_store(_truePositiveCount: Array[int] = [0,0], _falsePositiveCount: Array[int] = [0,0], _falseNegativeCount: Array[int] = [0,0]):
	self.truePositiveCount = _truePositiveCount
	self.falsePositiveCount = _falsePositiveCount
	self.falseNegativeCount = _falseNegativeCount
