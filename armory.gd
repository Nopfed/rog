extends Node

const ITEM_TYPES: Array[String] = [
	# TODO -> Weighted system so that everything doesn't have equal chance
	'potion',
	'weapon',
	'armor',
	'gold',
	'scroll'
]
const RARITIES: Array[String] = [
	# TODO -> Weighted system so that everything doesn't have equal chance
	'common',
	'uncommon',
	'rare',
	'epic',
	'unique'
]

const WEAPONS = {
	'sword': [
		'rapier',
		'scimitar',
		'sword',
		'shortsword',
		'machete',
		'blade',
		'sabre',
		'gladius',
		'clipper',
		'skinner',
		'broadsword',
		'cutlass'
	]
}
