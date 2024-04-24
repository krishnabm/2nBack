# This script is autoloaded from Project Settings > Autoload
#
# Global Class Name : GameState
# This stores properties subject to frequent change during the game across multiple scenes
extends Node2D

var truePositiveCount: int
var falsePositiveCount: int
var falseNegativeCount: int

func init_store(_truePositiveCount = 0, _falsePositiveCount = 0, _falseNegativeCount = 0):
	self.truePositiveCount = _truePositiveCount
	self.falsePositiveCount = _falsePositiveCount
	self.falseNegativeCount = _falseNegativeCount
