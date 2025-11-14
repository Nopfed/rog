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
	Global.moveMonsters()


func getAttacked(attacker: String, attack: Dictionary):
	# TODO -> Account for different types of damage against resistances
	
	if attack.attackRoll == 20 \
	or !(attack.attackRoll < Global.player.armorClass):
		Global.player.hitpoints -= attack.damageRoll
		
		if attack.attackRoll == 20:
			Global.sendMessage(attacker + 'crits!')
		
		Global.sendMessage(
			attacker + 'attacks for ' + str(attack.damageRoll) + 'damage.'
		)
	else:
		Global.sendMessage(attacker + ' misses.')
