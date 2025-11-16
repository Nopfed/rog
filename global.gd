extends Node

@onready var messageScene = preload("res://scenes/message/message.tscn")

const FONT_COLORS = {
	'hitPlayer': Color(0.5, 0.1, 0.1)
}

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


func sendMessage(message: String, type: String = ''):
	# TODO -> Reorder messages so that older messages float up instead of down
	# TODO -> Account for message overflow
	# TODO -> Log messages to save/log file
	# TODO -> Utilize type for different colors of messages
	var chatLog = get_node("/root/Hud/Log/Messages")
	var newMessage = messageScene.instantiate()
	var messageLabel: Label = newMessage.getLabel()
	
	if FONT_COLORS.has(type):
		messageLabel.add_theme_color_override("font_color", FONT_COLORS[type])
	
	messageLabel.text = message
	
	chatLog.add_child(newMessage)
