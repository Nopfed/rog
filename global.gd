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
	receiver.getAttacked(attacker.stats['name'], attack)


func moveMonsters():
	# TODO -> Make monster a classname
	var monsters = get_tree().get_nodes_in_group('MONSTER')
	
	for mob in monsters:
		mob.move()


func sendMessage(message: String, _type: String = ''):
	# TODO -> Utilize type for different colors of messages
	var chatLog = get_node("/root/Hud/Log/Messages")
	var newMessage = messageScene.instantiate()
	var messageLabel = newMessage.getLabel()
	
	messageLabel.text = message
	
	chatLog.add_child(newMessage)
