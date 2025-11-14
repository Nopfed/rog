extends Node

@onready var messageScene = preload("res://scenes/message/message.tscn")

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
var playerRef: CharacterBody2D


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
	receiver.getAttacked(attacker.name, attack)


func moveMonsters():
	# TODO -> Make monster a classname
	var monsters = get_tree().get_nodes_in_group('MONSTER')
	
	for mob in monsters:
		mob.move()


func sendMessage(message: String, _type: String = ''):
	# TODO -> Utilize type for different colors of messages
	var newMessage = messageScene.instantiate()
	
	newMessage.label.text = message
	
	# BUG -> Can't access the chatlog through this method for some reason
	var chatLog = get_tree().get_first_node_in_group('LOG')
	
	chatLog.add_child(newMessage)
