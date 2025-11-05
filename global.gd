extends Node

var player := {
	'hp': 10,
	'max_hp': 10,
	'mp': 10,
	'max_mp': 10,
	'xp': 0,
	'level_up': 100,
	'gold': 10,
	'ac': 10,
	'str': 10,
	'dex': 10,
	'int': 10
}

var stepCount: int
var canExitLevel: bool


func initialize():
	stepCount = 0
	canExitLevel = false
	player = {
		'hp': 10,
		'max_hp': 10,
		'mp': 10,
		'max_mp': 10,
		'xp': 0,
		'level_up': 100,
		'gold': 10,
		'ac': 10,
		'str': 10,
		'dex': 10,
		'int': 10
	}
	
