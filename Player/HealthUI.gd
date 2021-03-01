extends Control

onready var hearths = 4 setget set_hearths
onready var max_hearths = 4 setget set_max_hearths
onready var hearthUIFull = $HearthUiFull
onready var hearthUIEmpty = $HearthUiEmpty


func set_hearths(value):
	hearths = clamp(value, 0 , max_hearths)
	if hearthUIFull != null:
		hearthUIFull.rect_size.x = hearths * 15
		
	
func set_max_hearths(value):
	max_hearths = max(value, 1)
	self.hearths = min(hearths, max_hearths)
	if hearthUIEmpty != null:
		hearthUIEmpty.rect_size.x = max_hearths * 15

func _ready() -> void:
	self.max_hearths = PlayerStats.MaxHealth
	self.hearths = PlayerStats.health
	# warning-ignore:return_value_discarded
	PlayerStats.connect("health_changed", self, "set_hearths")
	# warning-ignore:return_value_discarded
	PlayerStats.connect("max_health_changed", self, "set_max_hearths")
	print(hearths)
