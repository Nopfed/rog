extends Node2D


const TILE_SIZE = 16

var stats: Dictionary
var player = get_parent().get_first_node_in_group('PLAYER')
var canSeePlayer := false
var sleeping := false
var resting := false


# TODO -> Inventory
# TODO -> Equipped gear
# TODO -> Combat stats
# TODO -> Combat logic based on intelligence stat
# TODO -> Dynamically load monster stats and sprites
# TODO -> Dynamically load monster sprites
# TODO -> Hearing trigger
# TODO -> Sight trigger
# TODO -> Flip sprite and sight cone based on direction moved (left or right)
# TODO -> Object permanence based on intelligence
# TODO -> drop a corpse object on ground on death


func _ready() -> void:
	initialize()


func initialize():
	name = 'rat'
	stats = Bestiary.rat


func move():
	var directionToMove: Vector2
	
	if stats['hp'] < stats['max_hp']
	
	if canSeePlayer:
		directionToMove = Vector2i(position.direction_to(player))
	else:
		if !sleeping and !resting:
			var randomX = randi_range(-1, 1)
			var randomY = randi_range(-1, 1)
			
			directionToMove = Vector2i(randomX, randomY)
	
	position += directionToMove * TILE_SIZE


# if can see player
#	if health is low
#		run
# 	else
		# if in range
			# fight player
		# else: get in range
# 
