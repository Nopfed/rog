extends PanelContainer


func _ready() -> void:
	setupPlayerStats()

func _process(_delta: float) -> void:
	updateSteps()
	updateStats()


func updateSteps():
	$VBoxContainer/Steps/Value.text = str(Global.stepCount)

func updateStats():
	$VBoxContainer/Health/ProgressBar.value = Global.player['hitpoints']
	$VBoxContainer/Magic/ProgressBar.value = Global.player['mana']
	$VBoxContainer/EXP/ProgressBar.value = Global.player['experience']

func setupPlayerStats():
	$VBoxContainer/Health/ProgressBar.max_value = Global.player['maxHitpoints']
	$VBoxContainer/Magic/ProgressBar.max_value = Global.player['maxMana']
	$VBoxContainer/EXP/ProgressBar.max_value = Global.player['experienceToLevel']
