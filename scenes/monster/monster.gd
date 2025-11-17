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
var lastHitBy


# TODO -> Inventory
# TODO -> Equipped gear
# TODO -> Combat stats
# TODO -> Combat logic based on intelligence stat
# TODO -> Hearing trigger
# TODO -> Flip sprite and sight cone based on direction moved (left or right)
# TODO -> Search mode
# TODO -> Sleep mode
# TODO -> drop a corpse object on ground on death
# TODO -> Monster name changes based on player's interaction with it
# e.g. a rat becomes Deft Rat if it's hard to hit
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
	# TODO -> Logic for fleeing from combat if scaredy cat and health is low
	
	# BUG -> Monsters only move towards player if player is orthogonal to them
	# BUG -> Monsters are 'in range of player' even after player moves away
	
	var directionToMove: Vector2
	
	getPlayerRef()
	
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
		var _attack = attack()
		
		Global.combat(self, _attack, playerRef)
	else:
		if !ray.is_colliding():
			inRangeOfPlayer = false
			position += directionToMove * TILE_SIZE
		elif ray.is_colliding() and ray.get_collider().is_in_group('PLAYER'):
			inRangeOfPlayer = true
			
			var _attack = attack()
			
			Global.combat(self, _attack, playerRef)


func attack():
	# TODO -> Pull this data dynamically from bestiary on monster init
	var type = 'physical'
	var accuracy = randi_range(1, 20)
	var damageRoll: int
	
	if accuracy == 20:
		damageRoll = randi_range(1, 4) * 2
	else: damageRoll = randi_range(1, 4)
	
	return {
		'type': type,
		'attackRoll': accuracy,
		'damageRoll': damageRoll
	}


func getAttacked(attacker: String, incomingAttack: Dictionary):
	# TODO -> Account for different types of damage against resistances
	# TODO -> More verbose message system that pulls from dictionary/list
	# TODO -> Only show chat message if player attacked the mob
	
	if incomingAttack.attackRoll == 20 \
	or !(incomingAttack.attackRoll < Global.player.armorClass):
		Global.player.hitpoints -= incomingAttack.damageRoll
		
		lastHitBy = attacker
		
		if incomingAttack.attackRoll == 20:
			Global.sendMessage(
				'The ' + attacker + 'CRITS for ' +\
				str(incomingAttack.damageRoll) + ' damage.',
				'physical'
			)
		else:
			Global.sendMessage(
				'The ' + attacker + ' attacks for ' +\
				str(incomingAttack.damageRoll) + ' damage.',
				'physical'
			)
	else:
		Global.sendMessage('The ' + attacker + ' misses.')


func checkIfDead():
	if !(stats['hitpoints'] > 0): die()


func die():
	if lastHitBy.is_in_group('PLAYER'):
		# TODO -> Give player exp from global script
		pass
	queue_free()


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
