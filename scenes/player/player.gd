extends CharacterBody2D

@onready var ray = $RayCast2D

const tileSize = 16
const inputs = {
	'up': Vector2.UP,
	'down': Vector2.DOWN,
	'left': Vector2.LEFT,
	'right': Vector2.RIGHT,
	'up_left': Vector2(-1, -1),
	'up_right': Vector2(1, -1),
	'down_left': Vector2(-1, 1),
	'down_right': Vector2(1, 1),
	'wait': Vector2(0, 0)
}

var stats = Global.player


func _ready() -> void:
	Global.playerRef = self


func _input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)


func move(dir):
	ray.target_position = inputs[dir] * tileSize
	ray.force_raycast_update()
	
	if !ray.is_colliding():
		position += inputs[dir] * tileSize
		Global.stepCount += 1
	else:
		var collider = ray.get_collider()
		
		# BUG -> Collider is not being detected as a monster
		# TODO -> A more elegant way to detect monster
		#	maybe just change monster tree structure so that static body is root
		
		if collider.is_in_group('MONSTER') \
		or collider.get_parent().is_in_group('MONSTER'):
			attack(collider)
		
	Global.checkForDeaths()
	Global.moveMonsters()


func attack(target):
	# TODO -> Pull stats from player stats
	
	var type = 'physical'
	var accuracy = randi_range(1, 20)
	var damageRoll: int
	
	if accuracy == 20:
		damageRoll = randi_range(1, 4) * 2
	else: damageRoll = randi_range(1, 4)
	
	Global.combat(
		'You', 
		{ 'type': type, 'attackRoll': accuracy, 'damageRoll': damageRoll },
		target
	)


func getAttacked(attacker: String, incomingAttack: Dictionary):
	# TODO -> Account for different types of damage against resistances
	# TODO -> More verbose message system that pulls from dictionary/list
	
	if incomingAttack.attackRoll == 20 \
	or !(incomingAttack.attackRoll < Global.player.armorClass):
		Global.player.hitpoints -= incomingAttack.damageRoll
		
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
