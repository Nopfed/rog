extends Node2D

var type: String
var rarity: String


func _ready() -> void:
	rollType()
	if type != 'gold': rollRarity()


func rollType():
	type = Global.ITEM_TYPES.pick_random()


func rollRarity():
	rarity = Global.RARITIES.pick_random()
