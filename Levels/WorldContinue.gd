extends Node2D


func _ready():
	Dialogic.set_variable("InDialog",0)
	SaveState.load_game()
	print(Dialogic.get_variable("Leafs"))
	PlayerStats.InBossLevel = false
	PlayerStats.wasInGame = true
#	PlayerStats.health = PlayerStats.MaxHealth

func _physics_process(_delta: float) -> void:
	if int(Dialogic.get_variable("InDialog")) == 1:
		get_tree().set_pause(true)
	else:
		get_tree().set_pause(false)
	
