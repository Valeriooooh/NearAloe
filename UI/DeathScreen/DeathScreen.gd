extends Control

export var TitleScreen:PackedScene


func _ready() -> void:
	pass
func _on_Apply_pressed() -> void:
	get_tree().change_scene("res://Levels/WorldContinue.tscn")
func _on_Back_pressed() -> void:
	# warning-ignore:return_value_discarded
	get_tree().change_scene_to(TitleScreen)

