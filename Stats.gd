extends Node

export var MaxHealth = 1
onready var health = MaxHealth setget set_health

signal no_health

func set_health(value):
	health = value
	if health <= 0:
		emit_signal("no_health")


