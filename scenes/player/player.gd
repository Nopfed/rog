extends Node2D

@onready var ray = $RayCast2D

const tileSize = 16
const inputs = {
	'up': Vector2.UP,
	'down': Vector2.DOWN,
	'left': Vector2.LEFT,
	'right': Vector2.RIGHT
}

var lastMove


func _unhandled_input(event: InputEvent) -> void:
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)


func move(dir):
	lastMove = dir
	ray.target_position = inputs[dir] * tileSize
	ray.force_raycast_update()
	
	if !ray.is_colliding():
		position += inputs[dir] * tileSize
		Global.moveCount += 1
	else:
		var collider = ray.get_collider()
		
		if collider.is_in_group('WALL'):
			if collider.move(dir):
				position += inputs[dir] * tileSize
				Global.moveCount += 1
