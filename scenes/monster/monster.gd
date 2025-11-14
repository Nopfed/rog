extends Node2D

@onready var ray = $RayCast2D

const TILE_SIZE = 16

var stats: Dictionary
var playerRef: CharacterBody2D
var canSeePlayer := false
var inRangeOfPlayer := false
var sleeping := false
var resting := false
var seenByPlayer: = false


# TODO -> Inventory
# TODO -> Equipped gear
# TODO -> Combat stats
# TODO -> Combat logic based on intelligence stat
# TODO -> Hearing trigger
# TODO -> Sight trigger
# TODO -> Flip sprite and sight cone based on direction moved (left or right)
# TODO -> Object permanence based on intelligence
# TODO -> drop a corpse object on ground on death
# TODO -> For ranged attacking mobs, they need an extra ranged collider check to
#	determine if they can attack from their current distance if they can see an
#	enemy


func _ready() -> void:
	initialize()


func initialize():
	# TODO -> Dynamic monster data from bestiary
	stats = Bestiary.rat


func getPlayerRef():
	playerRef = Global.playerRef


func move():
	var directionToMove: Vector2
	
	# TODO -> Logic for fleeing from combat if scaredy cat and health is low
	#if stats['hitpoints'] < stats['maxHitpoints']
	
	getPlayerRef()
	
	# BUG -> Monsters only move towards player if player is orthogonal to them
	if canSeePlayer:
		directionToMove = Vector2i(position.direction_to(playerRef.position))
	else:
		if !sleeping and !resting:
			var randomX = randi_range(-1, 1)
			var randomY = randi_range(-1, 1)
			
			directionToMove = Vector2i(randomX, randomY)
	
	ray.target_position = directionToMove * TILE_SIZE
	ray.force_raycast_update()
	
	# NB: look_at() rotates the x axis and we have a visual offset we need to
	# account for
	var lookAtOffset := Vector2(8, 8)
	
	$Sight.look_at(to_global(ray.target_position) + lookAtOffset)
	
	if inRangeOfPlayer:
		var attack = getAttack()
		
		Global.combat(self, attack, playerRef)
	else:
		if !ray.is_colliding():
			inRangeOfPlayer = false
			position += directionToMove * TILE_SIZE
		elif ray.is_colliding() and ray.get_collider().is_in_group('PLAYER'):
			inRangeOfPlayer = true
			
			var attack = getAttack()
			
			Global.combat(self, attack, playerRef)


func getAttack():
	# TODO -> Pull this data dynamically from bestiary on monster init
	var type = 'physical'
	var attackRoll = randi_range(1, 20)
	var damageRoll: int
	
	if attackRoll == 20:
		damageRoll = randi_range(1, 4) * 2
	else: damageRoll = randi_range(1, 4)
	
	return {
		'type': type,
		'attackRoll': attackRoll,
		'damageRoll': damageRoll
	}


func _on_sight_body_entered(body: Node2D) -> void:
	if body.is_in_group('PLAYER'):
		canSeePlayer = true
		
		if $VisibleOnScreenNotifier2D.is_on_screen():
			Global.sendMessage('A ' + stats['name'] + ' notices you.')


func _on_sight_body_exited(body: Node2D) -> void:
	# TODO -> Based on monster's intelligence have the mob go into search mode
	if body.is_in_group('PLAYER'):
		canSeePlayer = false


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	seenByPlayer = true
	Global.sendMessage('You see a ' + stats['name'] + '.')
