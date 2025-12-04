extends Node2D

@onready var itemScene = preload("res://scenes/item/item.tscn")
@onready var openedSprite = preload("res://chest_open.png")

var canOpen := false


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_released('interact') and canOpen:
		dropLoot()


func dropLoot():
	# TODO -> Get sprite based on item type
	
	var newItem = itemScene.instantiate()
	var randomLoot = Armory.getItem()
	
	print(randomLoot)
	
	if randomLoot:
		newItem.stats = randomLoot
	
	add_child(newItem)
	
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
