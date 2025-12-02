extends Node

# TODO -> Monster sprite references
# TODO -> Add more biomes
# TODO -> Add more monsters

const BIOMES = {
	'cave': {
		'rat': {
			'name': 'rat',
			'hitpoints': 3,
			'maxHitpoints': 3,
			'armorClass': 8,
			'strength': 1,
			'dexterity': 10,
			'intelligence': 5
		},
	}
}

func getRandomMonster(biome: String):
	return Global.getRandomDictItem(BIOMES[biome])
