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

#var lastMove

func _ready() -> void:
	Global.playerRef = self


func _input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)


func move(dir):
	#lastMove = dir
	ray.target_position = inputs[dir] * tileSize
	ray.force_raycast_update()
	
	if !ray.is_colliding():
		position += inputs[dir] * tileSize
		Global.stepCount += 1
	#else:
		#var collider = ray.get_collider()
		#
		#if collider.is_in_group('WALL'):
			#if collider.move(dir):
				#position += inputs[dir] * tileSize
				#Global.stepCount += 1
	Global.moveMonsters()
