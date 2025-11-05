extends Node2D

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
}
const HOLD_THRESHOLD = 0.5

#var lastMove
#var is_action_held = false
#var hold_timer = 0.0


func _input(event):
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			#is_action_held = true747
			move(dir)


#func _process(_delta):
	#if is_action_held:
		#for dir in inputs.keys():
			#if Input.is_action_pressed(dir):
				#move(dir)
			#elif Input.is_action_just_released(dir):
				#is_action_held = false


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
