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
const STAT_ROLLS = {
	'uncommon': { 'min': 1, 'max': 4 },
	'rare': { 'min': 3, 'max': 10 }
}
# TODO -> Break out stats off database items into a lookup table in order to
#	homogenize armor and weapon stats based on material
# TODO -> Unique item table


func getItem():
	# TODO -> Item names based on attributes
	# TODO -> Different materials should be more rare than others
	# TODO -> Camel case capitlization for item names
	
	var rarity = getRarity()
	#var type = ITEM_TYPES.pick_random()
	var type = 'armor'
	
	if type == 'armor':
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
		
		var stats: Dictionary = {
			'armor': 
				ARMOR[armorType].fashion[armorFashion].armorValue + \
				ARMOR[armorType].material[armorMaterial].armorValue,
		}
		
		if rarity != 'common':
			var materialAttributes: Array = \
				ARMOR[armorType].material[armorMaterial].attributes
			
			if rarity == 'uncommon':
				materialAttributes.shuffle()
				stats.get_or_add(
					materialAttributes.pop_back(),
					randi_range(
						STAT_ROLLS.uncommon.min,
						STAT_ROLLS.uncommon.max
					)
				)
				if randi_range(0, 1):
					stats.get_or_add(
						materialAttributes.pop_back(),
						randi_range(
							STAT_ROLLS.uncommon.min,
							STAT_ROLLS.uncommon.max
						)
					)
			elif rarity == 'rare':
				materialAttributes.shuffle()
				stats.get_or_add(
					materialAttributes.pop_back(),
					randi_range(
						STAT_ROLLS.rare.min,
						STAT_ROLLS.rare.max
					)
				)
				if randi_range(0, 1):
					stats.get_or_add(
						materialAttributes.pop_back(),
						randi_range(
							STAT_ROLLS.rare.min,
							STAT_ROLLS.rare.max
						)
					)
				if randi_range(0, 1):
					stats.get_or_add(
						materialAttributes.pop_back(),
						randi_range(
							STAT_ROLLS.rare.min,
							STAT_ROLLS.rare.max
						)
					)
		return {
			'name': armorMaterial + ' ' + armorFashion,
			'type': armorType,
			'material': armorMaterial,
			'fashion': armorFashion,
			'attributes': stats
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
