extends Node2D


var canOpen := false

# TODO -> Drop loot on ground
# TODO -> Change sprite to open chest after opened

func dropLoot():
	pass


func _on_open_area_body_entered(body: Node2D) -> void:
	if body.is_in_group('PLAYER'):
		canOpen = true


func _on_open_area_body_exited(body: Node2D) -> void:
	if body.is_in_group('PLAYER'):
		canOpen = false
