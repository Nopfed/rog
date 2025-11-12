extends Node

var player := {
	'hitpoints': 10,
	'maxHitpoints': 10,
	'mana': 10,
	'maxMana': 10,
	'experience': 0,
	'experienceToLevel': 100,
	'gold': 10,
	'armorClass': 10,
	'strength': 10,
	'dexterity': 10,
	'intelligence': 10
}

var stepCount: int
var canExitLevel: bool


func initialize():
	stepCount = 0
	canExitLevel = false
	player = {
		'hitpoints': 10,
		'maxHitpoints': 10,
		'mana': 10,
		'maxMana': 10,
		'experience': 0,
		'experienceToLevel': 100,
		'gold': 10,
		'armorClass': 10,
		'strength': 10,
		'dexterity': 10,
		'intelligence': 10
	}


func combat(attacker, attack, receiver):
	print(attacker.name + 'attacks ' + receiver.name + '.')
	receiver.getAttacked(attack)
