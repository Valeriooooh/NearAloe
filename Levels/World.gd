extends Node2D

func _ready() -> void:
	Dialogic.set_variable("InDialog",0)
#	PlayerStats.MaxHealth = 5
	PlayerStats.health = PlayerStats.MaxHealth
	PlayerStats.wasInGame = true

func _physics_process(_delta: float) -> void:
	Dialogic.set_variable("Left", PlayerStats.AloeLeaves)
	if int(Dialogic.get_variable("InDialog")) == 1:
		get_tree().set_pause(true)
	else:
		get_tree().set_pause(false)
		
