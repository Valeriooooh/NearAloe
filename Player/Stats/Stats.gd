extends Node

export(int) var MaxHealth = 2 setget set_max_health
var health = MaxHealth setget set_health
export var AloeLeaves = 0 setget set_leaves

var FirstEncounter = false
var inDialog = false
var InBossLevel = false
var BossBeeDefeated = false  
var BossBugDefeated = false
var BossSpikeDefeated = false
export var wasInGame = false


signal no_health
signal health_changed(value)
signal max_health_changed(value)

func _physics_process(_delta: float) -> void:
	Dialogic.set_variable("Leafs", AloeLeaves)
	
func set_max_health(value):
	MaxHealth = value
	health = min(health, MaxHealth)
	emit_signal("max_health_changed", MaxHealth)

func set_health(value):
	health = value
	emit_signal("health_changed", value)
	if health <= 0:
		emit_signal("no_health")

func set_leaves(value):
	AloeLeaves = value

func add_leaf():
	AloeLeaves += 1

func _ready() -> void:
	self.health = MaxHealth
