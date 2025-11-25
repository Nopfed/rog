extends Node2D

var type: String
var rarity: String


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
	pass
