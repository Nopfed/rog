extends Control




func _on_button_button_up() -> void:
	Global.initialize()
	get_tree().change_scene_to_file("res://scenes/HUD/HUD.tscn")
