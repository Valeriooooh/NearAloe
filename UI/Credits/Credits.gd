extends Control

func _ready() -> void:
	$AnimationPlayer.play("Play")

func mudar():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://UI/TitleScreen/TitleScreen.tscn")
