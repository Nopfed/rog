extends Node2D

var stats: Dictionary


func _ready() -> void:
	initialize()


func initialize():
	name = 'rat'
	stats = Bestiary.rat
