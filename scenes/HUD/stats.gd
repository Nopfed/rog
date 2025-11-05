extends PanelContainer


func _ready() -> void:
	setupPlayerStats()

func _process(_delta: float) -> void:
	updateSteps()
	updateStats()


func updateSteps():
	$VBoxContainer/Steps/Value.text = str(Global.stepCount)

func updateStats():
	$VBoxContainer/Health/ProgressBar.value = Global.player['hp']
	$VBoxContainer/Magic/ProgressBar.value = Global.player['mp']
	$VBoxContainer/EXP/ProgressBar.value = Global.player['xp']

func setupPlayerStats():
	$VBoxContainer/Health/ProgressBar.max_value = Global.player['max_hp']
	$VBoxContainer/Magic/ProgressBar.max_value = Global.player['max_mp']
	$VBoxContainer/EXP/ProgressBar.max_value = Global.player['level_up']
