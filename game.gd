extends Node2D

@onready var exitScene = preload("res://scenes/exit/exit.tscn")

@export var noiseTexture: NoiseTexture2D

const TILE_SIZE := 16
const MAX_MAP_WIDTH := 100
const MAX_MAP_HEIGHT := 100
const MIN_MAP_WIDTH := 20
const MIN_MAP_HEIGHT := 20
const WATER_HEIGHT := -0.45
const FLOOR_HEIGHT := 0.25
const WALL_HEIGHT := 1.0

var noise: Noise


func _ready() -> void:
	newGame()


func newGame():
	randomize()
	Global.initialize()
	noise = noiseTexture.noise
	noise.seed = randi()
	drawMap()


func drawMap():
	# TODO -> Starting safe zone
	# TODO -> If not drawing the first floor, create staircase back up
	# TODO -> Spawn monsters on non-wall tiles
	var noiseValue
	var mapWidth = randi_range(MIN_MAP_WIDTH, MAX_MAP_WIDTH)
	var mapHeight = randi_range(MIN_MAP_HEIGHT, MAX_MAP_HEIGHT)
	var floorTiles: Array
	
	$TileMapLayer.clear()
	
	# Draw Tiles
	for x in range(-mapWidth, mapWidth):
		for y in range(-mapHeight, mapHeight):
			noiseValue = noise.get_noise_2d(x, y)
			
			# if there is not a pre-drawn cell
			if $TileMapLayer.get_cell_source_id(Vector2(x, y)) < 0:
				# Draw water
				if noiseValue < WATER_HEIGHT:
					$TileMapLayer.set_cell(Vector2(x, y), 0, Vector2(5, 0))
				# Draw floor
				elif noiseValue < FLOOR_HEIGHT:
					floorTiles.append(Vector2(x, y))
					$TileMapLayer.set_cell(Vector2(x, y), 0, Vector2(2, 0))
				else: # Draw Walls
					if noiseValue > FLOOR_HEIGHT:
						$TileMapLayer.set_cell(Vector2(x, y), 0, Vector2(0, 0))
			
			# Draw Borders
			if x == -mapWidth or x == mapWidth - 1:
				$TileMapLayer.set_cell(Vector2(x, y), 0, Vector2(0, 0))
			if y == -mapHeight or y == mapHeight - 1:
				$TileMapLayer.set_cell(Vector2(x, y), 0, Vector2(0, 0))
	
	floorTiles.shuffle()
	
	var exitCoords = floorTiles.pop_back()
	var exit = exitScene.instantiate()
	
	exit.position = exitCoords * TILE_SIZE
	$TileMapLayer.set_cell(exitCoords, 0, Vector2(0, 8))
	add_child(exit)
	
	var playerPosition = floorTiles.pop_back()
	
	$Player.position = playerPosition * TILE_SIZE
	
