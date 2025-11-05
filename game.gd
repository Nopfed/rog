extends Node2D

@onready var exitScene = preload("res://scenes/exit/exit.tscn")

const MAX_MAP_WIDTH = 100
const MAX_MAP_HEIGHT = 100
const MIN_MAP_WIDTH = 20
const MIN_MAP_HEIGHT = 20


func _ready() -> void:
	newGame()


func newGame():
	randomize()
	Global.initialize()
	drawMap()


func drawMap():
	var map_width = randi_range(MIN_MAP_WIDTH, MAX_MAP_WIDTH)
	var map_height = randi_range(MIN_MAP_HEIGHT, MAX_MAP_HEIGHT)
	
	$TileMapLayer.clear()
	
	# Place Exit Tile
	var exitX = randi_range(0, map_width)
	var exitY = randi_range(0, map_height)
	
	$TileMapLayer.set_cell(Vector2(exitX, exitY), 0, Vector2(0, 8))
	
	var exit = exitScene.instantiate()
	
	exit.position = Vector2(exitX * 16, exitY * 16)
	add_child(exit)
	
	
	
	#for x in map_width:
		#for y in map_height:
			#if $TileMapLayer.get_cell_source_id(x, y) != -1:
	
