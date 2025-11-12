extends Node2D

@onready var exitScene = preload("res://scenes/exit/exit.tscn")
@onready var monsterScene = preload("res://scenes/monster/monster.tscn")
@onready var chestScene = preload('res://scenes/chest/chest.tscn')

@export var noiseTexture: NoiseTexture2D

const TILE_SIZE := 16
const MAX_MAP_WIDTH := 100
const MAX_MAP_HEIGHT := 100
const MIN_MAP_WIDTH := 20
const MIN_MAP_HEIGHT := 20
const WATER_HEIGHT := -0.4
const FLOOR_FLOOR := -0.1
const FLOOR_HEIGHT := 0
const WALL_HEIGHT := 1.0
const MONSTER_COUNT := 8
const CHEST_COUNT := 3

var noise: Noise

# TODO -> Combat
# TODO -> Game over
# TODO -> Monster AI

# TODO -> Player stats
# TODO -> Equippable gear
# TODO -> Loot
# TODO -> Loot chests

# TODO -> Ability to travel down floors

# TODO -> Level up

# TODO -> Fog of war
# TODO -> Diggable dirt tiles
# TODO -> Dirt layer

# TODO READABILITY -> Create struct for tilemap coordinates and source ids

func _ready() -> void:
	newGame()


func newGame():
	randomize()
	Global.initialize()
	noise = noiseTexture.noise
	noise.seed = randi()
	drawMap()


func drawMap():
	# TODO -> If not drawing the first floor, create staircase back up
	var noiseValue
	var mapWidth = randi_range(MIN_MAP_WIDTH, MAX_MAP_WIDTH)
	var mapHeight = randi_range(MIN_MAP_HEIGHT, MAX_MAP_HEIGHT)
	var floorTiles: Array[Vector2]
	
	$TileMapLayer.clear()
	
	# Draw Tiles
	for x in range(-mapWidth, mapWidth):
		for y in range(-mapHeight, mapHeight):
			noiseValue = noise.get_noise_2d(x, y)
			
			# if there is not a pre-drawn cell
			if $TileMapLayer.get_cell_source_id(Vector2(x, y)) < 0:
				# Draw water
				if noiseValue < WATER_HEIGHT:
					var brightness = 0.1
					$TileMapLayer.set_cell(Vector2(x, y), 0, Vector2(5, 0))
					$TileMapLayer.modulated_cells[Vector2i(x, y)] = \
						Color(
							0,
							abs(noiseValue) + brightness,
							abs(noiseValue) + brightness
						)
				# Draw floor
				elif noiseValue < FLOOR_HEIGHT and noiseValue > FLOOR_FLOOR:
					floorTiles.append(Vector2(x, y))
					#var altTileRand = randi_range(0, 7)
					$TileMapLayer.set_cell(Vector2(x, y), 0, Vector2(2, 0))
					#$TileMapLayer.modulated_cells[Vector2i(x, y)] = \
						#Color(abs(noiseValue * 3), abs(noiseValue * 3), abs(noiseValue * 3))
				# Draw Walls
				elif noiseValue > FLOOR_HEIGHT \
				or (noiseValue < FLOOR_FLOOR and noiseValue > WATER_HEIGHT):
					$TileMapLayer.set_cell(Vector2(x, y), 0, Vector2(0, 0))
					#$TileMapLayer.modulated_cells[Vector2i(x, y)] = \
						#Color(
							#abs(noiseValue),
							#abs(noiseValue),
							#abs(noiseValue)
						#)
			
			# Draw Borders
			if x == -mapWidth:
				$TileMapLayer.set_cell(Vector2(x - 1, y), 0, Vector2(0, 0))
				$TileMapLayer.set_cell(Vector2(x - 1, y - 1), 0, Vector2(0, 0))
			if x == mapWidth - 1:
				$TileMapLayer.set_cell(Vector2(x + 1, y), 0, Vector2(0, 0))
				$TileMapLayer.set_cell(Vector2(x + 1, y + 1), 0, Vector2(0, 0))
			if y == -mapHeight:
				$TileMapLayer.set_cell(Vector2(x, y - 1), 0, Vector2(0, 0))
				$TileMapLayer.set_cell(Vector2(x - 1, y - 1), 0, Vector2(0, 0))
			if y == mapHeight - 1:
				$TileMapLayer.set_cell(Vector2(x, y + 1), 0, Vector2(0, 0))
				$TileMapLayer.set_cell(Vector2(x + 1, y + 1), 0, Vector2(0, 0))
	
	floorTiles.shuffle()
	
	var exitCoords = floorTiles.pop_back()
	var exit = exitScene.instantiate()
	
	exit.position = exitCoords * TILE_SIZE
	$TileMapLayer.set_cell(exitCoords, 0, Vector2(0, 8))
	add_child(exit)
	
	var playerPosition = floorTiles.pop_back()
	
	$Player.position = playerPosition * TILE_SIZE
	
	digToExit(playerPosition, exitCoords)
	spawnMonsters(floorTiles)
	spawnChests(floorTiles)


func digToExit(playerStart: Vector2, exit: Vector2):
	# TODO -> Draw random curce to exit and then carve those tiles
	
	var directionToExit = playerStart.direction_to(exit)
	var currentTile: Vector2 = playerStart
	
	for i in range(ceili(playerStart.distance_to(exit))):
		currentTile = playerStart + (directionToExit * i)
		
		$TileMapLayer.set_cell(currentTile, 0, Vector2(2, 0))
		$TileMapLayer.set_cell(currentTile + Vector2.UP, 0, Vector2(2, 0))
		$TileMapLayer.set_cell(currentTile + Vector2.DOWN, 0, Vector2(2, 0))


func spawnMonsters(floorTiles: Array[Vector2]):
	for mob in MONSTER_COUNT:
		var newMonster = monsterScene.instantiate()
		
		newMonster.position = floorTiles.pop_back() * TILE_SIZE
		
		add_child(newMonster)


func spawnChests(floorTiles: Array[Vector2]):
	for chest in CHEST_COUNT:
		var newChest = chestScene.instantiate()
		
		newChest.position = floorTiles.pop_back() * TILE_SIZE
		
		add_child(newChest)
