extends Node2D

func _ready() -> void:
	PlayerStats.InBossLevel = true
	Dialogic.set_variable("InDialog",0)

func _physics_process(delta: float) -> void:
	if int(Dialogic.get_variable("InDialog")) == 1:
		get_tree().set_pause(true)
	else:
		get_tree().set_pause(false)
		
