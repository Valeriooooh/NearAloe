extends Node2D

func _ready():
	SaveState.load_game()
	PlayerStats.InBossLevel = false
