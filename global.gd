extends Node

@onready var messageScene = preload("res://scenes/message/message.tscn")

const FONT_COLORS = {
	'physical': Color(0.5, 0.1, 0.1),
	'arcane': Color(0.5, 0.1, 0.5),
	'water': Color(0.1, 0.1, 0.5),
	'fire': Color(0.7, 0.2, 0.1),
	'ice': Color(0.1, 0.4, 0.9),
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
var currentBiome := 'cave'
var stepCount: int
var canExitLevel: bool
var playerRef: CharacterBody2D


func initialize():
	randomize()
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


func checkIfGameOver():
	if !(player.hitpoints > 0):
		gameOver()


func gameOver():
	# TODO -> Probably don't have to change scenes as it appears to be throwing
	# errors on input handling functions when we do this
	get_tree().change_scene_to_file("res://scenes/game over/game_over.tscn")


func combat(attacker: String, attack: Dictionary, receiver):
	receiver.getAttacked(attacker, attack)


func checkForDeaths():
	var monsters = get_tree().get_nodes_in_group('MONSTER')
	
	for mob in monsters:
		mob.checkIfDead()


func moveMonsters():
	# TODO -> Make monster a classname
	var monsters = get_tree().get_nodes_in_group('MONSTER')
	
	for mob in monsters:
		mob.move()


func givePlayerExp(monsterStats: Dictionary):
	var experience: int
	
	experience = \
		monsterStats['strength'] + \
		monsterStats['maxHitpoints'] + \
		monsterStats['dexterity'] + \
		monsterStats['intelligence']
	
	player['experience'] += experience


func sendMessage(message: String, type: String = ''):
	# TODO -> Log messages to save/log file
	# TODO -> Utilize type for different colors of messages
	var chatLog = get_node("/root/Hud/Log/ScrollContainer/Messages")
	var chatScroll: ScrollContainer = chatLog.get_parent()
	var newMessage = messageScene.instantiate()
	var messageLabel: Label = newMessage.getLabel()
	
	if FONT_COLORS.has(type):
		messageLabel.add_theme_color_override("font_color", FONT_COLORS[type])
	
	messageLabel.text = message
	
	chatLog.add_child(newMessage)
	
	await get_tree().process_frame
	chatScroll.scroll_vertical = int(chatScroll.get_v_scroll_bar().max_value)


func getRandomDictItem(dict: Dictionary, returnKey = false):
	# Get all keys as an array
	var keys = dict.keys()
	
	# Generate a random index
	var random_index = randi() % dict.size()
	
	# [RandomItem, Key]
	if returnKey:
		return [dict[keys[random_index]], keys[random_index]]
	
	# RandomItem
	return dict[keys[random_index]]
