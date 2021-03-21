extends Node

export(int) var MaxHealth = 2 setget set_max_health
var health = MaxHealth setget set_health

signal no_health
signal health_changed(value)
signal max_health_changed(value)

func set_max_health(value):
	MaxHealth = value
	health = min(health, MaxHealth)
	emit_signal("max_health_changed", MaxHealth)

func set_health(value):
	health = value
	emit_signal("health_changed", value)
	if health <= 0:
		emit_signal("no_health")



func _ready() -> void:
	self.health = MaxHealth
