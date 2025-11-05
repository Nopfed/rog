extends PanelContainer


func _process(_delta: float) -> void:
	updateSteps()


func updateSteps():
	$VBoxContainer/Steps/Value.text = str(Global.stepCount)
