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
	'rapier': {
		'damage': [2, 4],
		'attributes': ['dexterity', 'charisma']
	},
	'scimitar': {
		'damage': [3, 6],
		'attributes': ['constitution', 'strength', 'charisma']
	},
	'sword': {
		'damage': [2, 5],
		'attributes': [
			'intelligence',
			'strength',
			'constitiution',
			'dexterity',
			'wisdom',
			'charisma'
		]
	},
	'shortsword': {
		'damage': [2, 4],
		'attributes': [
			'intelligence',
			'strength',
			'constitiution',
			'dexterity',
			'wisdom',
			'charisma'
		]
	},
	'machete': {
		'damage': [3, 5],
		'attributes': ['strength', 'dexterity']
	},
	'blade': {
		'damage': [3, 4],
		'attributes': [
			'strength',
			'constitiution',
			'dexterity',
			'wisdom',
			'charisma'
		]
	},
	'sabre': {
		'damage': [2, 5],
		'attributes': [
			'strength',
			'constitiution',
			'dexterity',
			'charisma'
		]
	},
	'gladius': {
		'damage': [3, 5],
		'attributes': [
			'strength',
			'constitiution',
			'dexterity',
			'wisdom',
			'charisma'
		]
	},
	'broadsword': {
		'damage': [3, 5],
		'attributes': [
			'strength',
			'constitiution',
			'dexterity',
			'wisdom',
			'charisma'
		]
	},
	'cutlass': {
		'damage': [3, 5],
		'attributes': [
			'intelligence',
			'strength',
			'constitiution',
			'dexterity',
			'wisdom',
			'charisma'
		]
	}
}

const ARMOR = {
	'chest': {
		'material': [
			'leather',
			'studded',
			'cloth',
			'steel',
			'iron',
			'bronze',
			'copper',
			'silver',
			'gold'
		],
		'fashion': [
			'hauberk',
			'cuirass',
			'brigandine',
			'plackart',
			'faulds',
			'lorica'
		]
	}
}

const MATERIALS = {
	'leather': {
		'attributes': [
		]
	},
	'studded': {
		'attributes': [
		]
	}
}
