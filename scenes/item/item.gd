extends Node2D

var type: String
var rarity: String
var stats: Dictionary


func _ready() -> void:
	rollType()
	if type == 'armor' or type == 'weapon':
		rarity = Armory.getRarity()
		rollStats()


func rollType():
	type = Armory.ITEM_TYPES.pick_random()


func rollStats():
	if type == 'armor':
		
	# TODO -> Stats
	# TODO -> Icon
	# TODO -> Name
	pass
