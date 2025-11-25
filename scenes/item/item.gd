extends Node2D

var type: String
var rarity: String
var stats: Dictionary


func _ready() -> void:
	rollType()
	if type == 'armor' or type == 'weapon':
		rollRarity()
		rollStats()


func rollType():
	type = Armory.ITEM_TYPES.pick_random()


func rollRarity():
	rarity = Armory.RARITIES.pick_random()


func rollStats():
	# TODO -> Get item stats
	# TODO -> Create item name based on it's stats and rarity
	pass
