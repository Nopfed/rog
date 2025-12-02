extends Node2D

@onready var itemScene = preload("res://scenes/item/item.tscn")
@onready var openedSprite = preload("res://chest_open.png")

var canOpen := false

# TODO -> Change sprite to open chest after opened

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_released('interact') and canOpen:
		dropLoot()


func dropLoot():
	# TODO -> Implement item generation function
	#var randomLoot = Armory.getItem()
	#var newItem = itemScene.instantiate()
	#
	#newItem.stats = randomLoot
	#
	#add_child(newItem)
	
	# TODO -> Open chest noise
	$Sprite2D.texture = openedSprite
	canOpen = false
	$OpenArea.queue_free()


func _on_open_area_body_entered(body: Node2D) -> void:
	if body.is_in_group('PLAYER'):
		canOpen = true


func _on_open_area_body_exited(body: Node2D) -> void:
	if body.is_in_group('PLAYER'):
		canOpen = false
