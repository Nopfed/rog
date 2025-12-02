extends Node

const ITEM_TYPES: Array[String] = [
	'potion',
	'weapon',
	'armor',
	'gold',
	'scroll'
]
const WEAPONS = {
	'oneHand': {
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
		},
		'axe': {
			'damage': [3, 7],
			'attributes': [
				'strength',
				'dexterity'
			]
		},
		'mace': {
			'damage': [4, 6],
			'attributes': [
				'strength',
				'wisdom',
				'constitution'
			]
		},
	},
	'twoHand': {
		'sword': {
			'damage': [4, 10],
			'attributes': [
				'strength',
				'constitiution',
				'wisdom',
				'charisma'
			]
		},
		'axe': {
			'damage': [6, 12],
			'attributes': [
				'strength',
				'dexterity'
			]
		},
		'mace': {
			'damage': [5, 11],
			'attributes': [
				'strength',
				'constitiution',
				'wisdom'
			]
		},
	}
}
const ARMOR = {
	'chest': {
		'material': {
			'leather': {
				'armorValue': 1,
				'attributes': [
					'dexterity',
					'charisma',
					'constitution'
				]
			},
			'studded': {
				'armorValue': 2,
				'attributes': [
					'dexterity',
					'charisma',
					'constitution',
					'strength'
				]
			},
			'cloth': {
				'armorValue': 0,
				'attributes': [
					'charisma',
					'constitution',
					'wisdom',
					'intelligence'
				]
			},
			'steel': {
				'armorValue': 3,
				'attributes': [
					'charisma',
					'constitution',
					'strength'
				]
			},
			'iron': {
				'armorValue': 3,
				'attributes': [
					'constitution',
					'strength'
				]
			},
			'bronze': {
				'armorValue': 3,
				'attributes': [
					'charisma',
					'constitution',
					'wisdom',
					'strength'
				]
			},
			'copper': {
				'armorValue': 2,
				'attributes': [
					'constitution',
					'strength',
					'wisdom'
				]
			},
			'silver': {
				'armorValue': 2,
				'attributes': [
					'charisma',
					'constitution',
					'wisdom',
					'intelligence'
				]
			},
			'gold': {
				'armorValue': 2,
				'attributes': [
					'dexterity',
					'charisma',
					'constitution',
					'strength',
					'wisdom',
					'intelligence'
				]
			}
		},
		'fashion': {
			'hauberk': { 'armorValue': 1 },
			'cuirass': { 'armorValue': 3 },
			'brigandine': { 'armorValue': 2 },
			'lorica': { 'armorValue': 2 }
		}
	}
}
# TODO -> Break out stats off database items into a lookup table
# TODO -> Unique item table


func getItem(type: String):
	if type == 'armor':
		# TODO -> Check to see if this actually returns a value
		var armorType: String = Global.getRandomDictItem(ARMOR, true)[1]
		var armorMaterial: String = \
			Global.getRandomDictItem(
				ARMOR[armorType].material.duplicate(true),
				true
			)[1]
		var armorFashion: String = \
			Global.getRandomDictItem(
				ARMOR[armorType].fashion.duplicate(true),
				true
			)[1]
		
		# TODO -> Return random stats as well
		return {
			'type': armorType,
			'material': armorMaterial,
			'fashion': armorFashion
		}
	elif type == 'weapon':
		var weaponHand: String = Global.getRandomDictItem(WEAPONS, true)[1]
		var weaponType: String = \
			Global.getRandomDictItem(WEAPONS[weaponHand], true)[1]
		# TODO -> Weapon materials
		# TODO -> Weapon stats
		
		return {
			'hand': weaponHand,
			'type': weaponType
		}


func getRarity():
	var rarity = 'common'
	
	rarity = rarityUpgradeCheck(rarity)
	
	return rarity


func rarityUpgradeCheck(rarity: String):
	if rarity == 'unique': return rarity
	
	elif randi_range(1, 100) > 79:
		match rarity:
			'common': rarity = 'uncommon'
			'uncommon': rarity = 'rare'
			'rare': rarity = 'unique'
		rarityUpgradeCheck(rarity)
	else: return rarity
