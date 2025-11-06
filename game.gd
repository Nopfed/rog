extends Node2D

@onready var exitScene = preload("res://scenes/exit/exit.tscn")

@export var noiseTexture: NoiseTexture2D

const MAX_MAP_WIDTH := 100
const MAX_MAP_HEIGHT := 100
const MIN_MAP_WIDTH := 20
const MIN_MAP_HEIGHT := 20
const WATER_HEIGHT := -0.6
const FLOOR_HEIGHT := 0.6
#const WALL_HEIGHT := 1.0

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
			print(noiseValue)
			# if there is not a pre-drawn cell
			if $TileMapLayer.get_cell_source_id(Vector2(x, y)) < 0:
				# Draw Walls
				if noiseValue > FLOOR_HEIGHT:
					$TileMapLayer.set_cell(
						Vector2(x, y),
						0,
						Vector2(0, 0)
					)
				# Draw floor
				elif noiseValue > WATER_HEIGHT:
					floorTiles.append(Vector2(x, y))
					$TileMapLayer.set_cell(
						Vector2(x, y),
						0,
						Vector2(2, 0)
					)
				# Draw water
				else:
					$TileMapLayer.set_cell(
						Vector2(x, y),
						0,
						Vector2(5, 0)
					)
	var exitCoords = floorTiles.pick_random()
	
	$TileMapLayer.set_cell(exitCoords, 0, Vector2(0, 8))
	
	var exit = exitScene.instantiate()
	
	exit.position = exitCoords * 16
	add_child(exit)
